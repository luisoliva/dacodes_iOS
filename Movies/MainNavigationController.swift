//
//  MainNavigationController.swift
//  Movies
//
//  Created by Luis Oliva on 4/11/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    var data = MoviesApiResponse()
    var movieImages = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "NavigationToMoviesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MoviesViewController{
            let vc = segue.destination as? MoviesViewController
            vc?.movies = data
            vc?.movieImages = self.movieImages
        }
    }
}
