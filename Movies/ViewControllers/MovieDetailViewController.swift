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
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieRuntime: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                   print(error)
                }
            }
            if (error != nil){
                print(error!)
            }
        }
        task.resume()
    }
    
    func getMovieImage(){
        print(baseUrlImg + movieDetails.backdrop_path)
        if let url = URL(string: baseUrlImg + movieDetails.backdrop_path){
            do {
                let imgData = try Data(contentsOf: url)
                OperationQueue.main.addOperation {
                    [weak self] in
                    self?.movieImage.image = UIImage(data: imgData)
                    self?.setLayoutData()
                }
            }catch{
                print("error")
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
    }
}
