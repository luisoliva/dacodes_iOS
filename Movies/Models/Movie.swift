//
//  Movie.swift
//  Movies
//
//  Created by Luis Oliva on 4/11/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    public let id: Int
    public let title: String
    public let release_date: String
    public let vote_average: Double
    public let poster_path: String
    
    init() {
        self.id = 0
        self.title = ""
        self.release_date = ""
        self.vote_average = 0
        self.poster_path = ""
    }
}
