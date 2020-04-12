//
//  MoviesViewController.swift
//  Movies
//
//  Created by Luis Oliva on 4/10/20.
//  Copyright © 2020 Luis Oliva. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = MoviesApiResponse()
    var movieImages = [UIImage]()
    var selectedMovieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellLayout()
    }
    
    func setCellLayout(){
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth/2, height: ((screenWidth/2) * 1.51098))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results.count
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.movieTitle.text = movies.results[indexPath.row].title
        cell.releaseDate.text = movies.results[indexPath.row].release_date
        cell.voteAverage.text = String(format:"%.1f", movies.results[indexPath.row].vote_average)
        cell.movieWallpaper.image = self.movieImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovieId = movies.results[indexPath.row].id
        self.performSegue(withIdentifier: "MovieToDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MovieDetailViewController{
            print("voy para el movie detail controller")
            let vc = segue.destination as? MovieDetailViewController
            vc?.movieId = self.selectedMovieId
        }
    }
}
