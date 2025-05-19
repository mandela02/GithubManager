//
//  CustomError.swift
//  PhotoEase
//
//  Created by Tree Bui Quang Tri on 6/3/25.
//

import Foundation

public enum CustomError: LocalizedError {
    case thrownError(Error)
    case customError(String)
    case serverMessage(String)
    case noInternet
    case expiredToken
    case invalidURL
    case invalidInput
    case serverError
    case noData
    case badData
    case unknownError
    case notAvailable
}
