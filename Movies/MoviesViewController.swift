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
    let baseUri = "https://image.tmdb.org/t/p/w342"

    override func viewDidLoad() {
        super.viewDidLoad()
        setCellLayout()
        // Do any additional setup after loading the view.
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
            
        if let url = URL(string: self.baseUri + movies.results[indexPath.row].poster_path){
            do {
                let imgData = try Data(contentsOf: url)
                cell.movieWallpaper.image = UIImage(data: imgData)
            }catch{
                print("error")
            }
        }
        return cell
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
