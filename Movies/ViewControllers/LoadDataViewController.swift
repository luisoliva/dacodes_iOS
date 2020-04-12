//
//  ViewController.swift
//  Movies
//
//  Created by Luis Oliva on 4/10/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//
import UIKit

class LoadDataViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    
    var data = MoviesApiResponse()
    var movieImages = [UIImage]()
    let baseUrl = "https://image.tmdb.org/t/p/w342"

    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromApi()
    }
    
    func getDataFromApi(){
        self.progressView.progress = 0.0
        let uri = URL( string: "https://api.themoviedb.org/3/movie/now_playing?api_key=634b49e294bd1ff87914e7b9d014daed&language=es-ES&page=1")!
        let task = URLSession.shared.dataTask(with: uri){(data,response, error) in
            if (data != nil) {
                do {
                    self.data = try JSONDecoder().decode(MoviesApiResponse.self, from: data!)
                    self.getMovieImages()
                } catch let error {
                    self.showNetworkErrorAlert()
                }
            }
            if (error != nil){
                self.showNetworkErrorAlert()
            }
        }
        task.resume()
    }
    
    func getMovieImages(){
        movieImages.removeAll()
        let step: Float = Float(1) / Float(self.data.results.count)
        for index in 0...self.data.results.count-1{
            if let url = URL(string: self.baseUrl + data.results[index].poster_path){
                do {
                    let imgData = try Data(contentsOf: url)
                    movieImages.append(UIImage(data: imgData)!)
                    OperationQueue.main.addOperation {
                        [weak self] in
                        self!.progressView.progress += step
                        if self!.progressView.progress == 1 {
                            self?.performSegue(withIdentifier: "LoadingToNavigationSegue", sender: self)
                        }
                    }
                }catch{
                    self.showNetworkErrorAlert()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainNavigationController{
            let vc = segue.destination as? MainNavigationController
            vc?.data = data
            vc?.movieImages = self.movieImages
        }
    }
    
    func showNetworkErrorAlert(){
        OperationQueue.main.addOperation {
            [weak self] in
            let alert = UIAlertController(title: "Error de conexión", message: "Parece que no hay conexion a internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Intentar de nuevo", style: .default, handler: { action in
                self?.getDataFromApi()
            }))
            self?.present(alert, animated: true)
        }
    }


}

