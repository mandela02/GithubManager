//
//  BaseRepository.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 19/5/25.
//

import Foundation
import DataLayer

public class BaseRepository<Model: Codable> {
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    var endpoint: String
    
    lazy var repository = ApiRepository<Model>(endpoint)
}

