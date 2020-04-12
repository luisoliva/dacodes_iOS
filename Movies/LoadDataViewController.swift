//
//  ViewController.swift
//  Movies
//
//  Created by Luis Oliva on 4/10/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//
import UIKit

class LoadDataViewController: UIViewController {
    
    var data = MoviesApiResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromApi(){
        let uri = URL( string: "https://api.themoviedb.org/3/movie/now_playing?api_key=634b49e294bd1ff87914e7b9d014daed&language=es-ES&page=1")!
        let task = URLSession.shared.dataTask(with: uri){(data,response, error) in
            if (data != nil) {
                do {
                    self.data = try JSONDecoder().decode(MoviesApiResponse.self, from: data!)
                    print(self.data)
                } catch let error {
                   print(error)
                }
            }
            if (error != nil){
                print(error!)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainNavigationController{
            print("voy para el navigation controller")
            let vc = segue.destination as? MainNavigationController
            vc?.data = data
        }
    }


}

