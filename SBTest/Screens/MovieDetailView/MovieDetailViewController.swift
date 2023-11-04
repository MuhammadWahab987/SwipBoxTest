//
//  MovieDetailViewController.swift
//  SBTest
//
//  Created by Muhammad Wahab on 04/11/2023.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgViewMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblRevenue: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    
    // MARK: - Variables & Constants
    var movieId = ""
    var viewModel:  MovieDetailViewModel! {
        didSet {
            super.baseViewModel = viewModel
        }
    }
    
    // MARK: - UIViewController Initializer
    
    init(viewModel: MovieDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupNavigationBarUI()
        viewModel.loadData(movieId: self.movieId)
    }
    
    // MARK: - UIViewController Helper Methods
    
    override func setupViewController()  {
        viewModel.delegate = self
    }
    
    override func setupNavigationBarUI() {
        
    }
    
    // MARK: - Selectors
    
    // MARK: - IBActions
    
    // MARK: - Private Methods
}

extension MovieDetailViewController:  MovieDetailViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool) {
        DispatchQueue.main.async {
            if isSuccessFullAPIResponse
            {
                
                
                if let imgUrl = self.viewModel.movieDetail?.posterPath, imgUrl != ""
                {
                    let imgFullUrl = "\(Constant.imagesBaseUrl)\(imgUrl)"
                    self.imgViewMovie.setImageWithAlomofire(withUrl: URL(string: imgFullUrl)!, andPlaceholder:#imageLiteral(resourceName: "clapboard"))
                }
                else
                {
                    self.imgViewMovie.image = #imageLiteral(resourceName: "clapboard")
                }
                
                
                
                
                self.lblMovieName.text = self.viewModel.movieDetail?.originalTitle
                self.lblOverview.text = self.viewModel.movieDetail?.overview
                
                self.lblStatus.text = self.viewModel.movieDetail?.status
                self.lblBudget.text = "$\(self.viewModel.movieDetail?.budget ?? 0)"
                self.lblRevenue.text = "$\(self.viewModel.movieDetail?.revenue ?? 0)"
                self.lblReleaseDate.text = self.viewModel.movieDetail?.releaseDate
                
            }
        }
    }
}
