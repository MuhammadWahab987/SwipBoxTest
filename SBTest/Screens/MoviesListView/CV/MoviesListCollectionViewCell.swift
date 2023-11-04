//
//  MoviesListCollectionViewCell.swift
//  SBTest
//
//  Created by Muhammad Wahab on 03/11/2023.
//

import UIKit

class MoviesListCollectionViewCell: UICollectionViewCell {

    
    
    //MARK: - Outlets
    @IBOutlet weak var imgViewMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieDate: UILabel!
    
    //MARK: - Variables & Constants
    
    //MARK: - UIViewController Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - @objc Functions
    
    // MARK: - IBActions
    
    //MARK: - Helper Methods
    func setupCell(movie: MovieModel, indexPath: IndexPath)
    {
        if let imgUrl = movie.posterPath, imgUrl != ""
        {
            let imgFullUrl = "\(Constant.imagesBaseUrl)\(imgUrl)"
            imgViewMovie.setImageWithAlomofire(withUrl: URL(string: imgFullUrl)!, andPlaceholder:#imageLiteral(resourceName: "clapboard"))
            //imgViewMovie.setImageFromUrl(path: imgFullUrl)
        }
        else
        {
            imgViewMovie.image = #imageLiteral(resourceName: "clapboard")
        }
        lblMovieName.text = movie.originalTitle ?? "N/A"
        lblMovieDate.text = movie.releaseDate ?? "N/A"
    }

}
