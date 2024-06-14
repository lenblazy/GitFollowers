//
//  ErrorMessages.swift
//  GitFollowers
//
//  Created by Lennox Mwabonje on 14/06/2024.
//

import Foundation

enum ErrorMessage: String {
    case invalidUserName = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidUResponse = "Invalid response from server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."
}
