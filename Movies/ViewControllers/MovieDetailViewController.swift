//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Luis Oliva on 4/11/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    let baseUrlImg = "https://image.tmdb.org/t/p/w780"
    var movieId = 0
    var movieDetails = MovieDetails()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.startAnimating()
        self.getMovieDataFromApi()
    }
    
    func getRequestUrl() ->String {
        let baseUrl = "https://api.themoviedb.org/3/movie/"
        let urlQueryParameters = "?api_key=634b49e294bd1ff87914e7b9d014daed&language=es-ES"
        return baseUrl + String(movieId) + urlQueryParameters
    }
    
    func getMovieDataFromApi(){
        let uri = URL( string: self.getRequestUrl())!
        let task = URLSession.shared.dataTask(with: uri){(data,response, error) in
            if (data != nil) {
                do {
                    self.movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data!)
                    self.getMovieImage()
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
    
    func getMovieImage(){
        if let url = URL(string: baseUrlImg + movieDetails.backdrop_path){
            do {
                let imgData = try Data(contentsOf: url)
                OperationQueue.main.addOperation {
                    [weak self] in
                    self?.movieImage.image = UIImage(data: imgData)
                    self?.setLayoutData()
                }
            }catch{
                self.showNetworkErrorAlert()
            }
        }
    }
    
    func setLayoutData(){
        self.movieName.text = self.movieDetails.title
        self.movieRuntime.text = String((self.movieDetails.runtime)) + " min"
        self.movieReleaseDate.text = self.movieDetails.release_date
        self.voteAverage.text = String(format:"%.1f", (self.movieDetails.vote_average))
        self.movieDescription.text = self.movieDetails.overview
        var genres = [String]()
        for genre in (self.movieDetails.genres){
            genres.append(" " + genre.name)
        }
        self.movieGenres.text = genres.joined(separator: ",")
        spinner.stopAnimating()
        loadingView.isHidden = true
    }
    
    func showNetworkErrorAlert(){
        OperationQueue.main.addOperation {
            [weak self] in
            let alert = UIAlertController(title: "Error de conexión", message: "Parece que no hay conexion a internet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Intentar de nuevo", style: .default, handler: { action in
                self?.getMovieDataFromApi()
            }))
            self?.present(alert, animated: true)
        }
    }
}
