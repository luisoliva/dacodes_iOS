//
//  File.swift
//  Movies
//
//  Created by Luis Oliva on 4/11/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import Foundation

public struct MovieDetails: Codable {
    public let title: String
    public let backdrop_path: String
    public let genres: [MovieGenre]
    public let runtime: Int
    public let release_date: String
    public let vote_average: Double
    public let overview: String
    
    init() {
        self.backdrop_path = ""
        self.genres = [MovieGenre]()
        self.runtime = 0
        self.release_date = ""
        self.vote_average = 0
        self.overview = ""
        self.title = ""
    }
}
