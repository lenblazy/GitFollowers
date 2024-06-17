//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 13/06/2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    
    init(username: String){
        super.init(nibName: nil, bundle: nil)
        self.userName = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers(username: userName, page: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureSearchController() {
        let searchController                    = UISearchController()
        searchController.searchResultsUpdater   = self
        searchController.searchBar.placeholder  = "Search For a username"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
    
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch (result){
            case .success(let followers): self.updateUI(with: followers)
            case .failure(let error): self.presentGFAlert(title: "Bad Stuff Happened", message: error.rawValue, buttonText: "Ok")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    private func updateUI(with followers: [Follower]){
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go Follow them 🤣."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            dismissLoadingView()
            
            switch result{
            case .success(let user): self.addUserToFavorite(user: user)  
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonText: "Ok")
            }
            
        }
        
    }
    
    private func addUserToFavorite(user: User){
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlert(title: "Success", message: "User saved successfully. 🎉", buttonText: "Hooray")
                return
            }
            
            self.presentGFAlert(title: "Sowmething went wrong", message: error.rawValue, buttonText: "Ok")
        }
    }
    
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = self.isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = self.followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
}

extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.userName = username
        title       = username
        page        = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
    
}
