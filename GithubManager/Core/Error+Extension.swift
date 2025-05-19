//
//  Error+Extension.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import DataLayer
import SwiftUtilities

public extension Error {
    /// Generate error message
    ///
    ///  Create error message to show in error dialog
    var customErrorDescription: String {
        guard let self = self as? CustomError else {
            return self.localizedDescription
        }

        switch self {
        case .thrownError(let error):
            return error.localizedDescription
        case .customError(let string):
            return string
        case .serverMessage(let string):
            return string
        case .noInternet:
            return "You're not connected to the internet"
        case .expiredToken:
            return "Your session has expired - please log in again"
        case .invalidURL:
            return "There was a problem fetching data from the server - please try again later"
        case .invalidInput:
            return "The input you entered was invalid - please try again"
        case .serverError:
            return "There was a problem connecting with the server - please try again later"
        case .noData:
            return "The server returned no data"
        case .badData:
            return "The server returned bad data - please try again later"
        case .unknownError:
            return "An unknown error occurred - please try again later"
        case .notAvailable:
            return "Data is not available during the requested time"
        }
    }

    var toLoadingStatus: LoadingStatus {
        guard let self = self as? CustomError else {
            return .error(self.localizedDescription)
        }

        switch self {
        case .expiredToken:
            return .success
        default:
            return .error(self.customErrorDescription)
        }
    }
}
