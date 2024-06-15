//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 13/06/2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName: String!
    var followers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
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
    }
    
    private func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch (result){
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go Follow them 🤣."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                
                self.updateData()
            case .failure(let error): self.presentGFAlert(title: "Bad Stuff Happened", message: error.rawValue, buttonText: "Ok")
            }
            
        }
    }
    
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
        
    }
    
}
