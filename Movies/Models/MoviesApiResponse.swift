//
//  MoviesApiResponse.swift
//  Movies
//
//  Created by Luis Oliva on 4/11/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import Foundation

public struct MoviesApiResponse: Codable {
    public let results: [Movie]
    init() {
        self.results = [Movie()]
    }
}
