//
//  MovieGenre.swift
//  Movies
//
//  Created by Luis Oliva on 4/11/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import Foundation

public struct MovieGenre: Codable {
    let id: Int
    let name: String
    init() {
        self.id = 0
        self.name = ""
    }
}
