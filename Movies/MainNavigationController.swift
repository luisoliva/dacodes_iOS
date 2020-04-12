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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "SegueToFirstController", sender: self)

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MoviesViewController{
            print("voy para el movies controller")
            let vc = segue.destination as? MoviesViewController
            vc?.movies = data
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
