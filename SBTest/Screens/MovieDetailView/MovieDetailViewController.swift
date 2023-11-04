//
//  MovieDetailViewController.swift
//  SBTest
//
//  Created by Muhammad Wahab on 04/11/2023.
//

import UIKit
import Alamofire

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
    let networkReachabilityManager = NetworkReachabilityManager()
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
        
        
        if networkReachabilityManager?.isReachable ?? false
        {
            viewModel.loadData(movieId: self.movieId)
        }
        else
        {
            AlertBuilder.showBannerBelowNavigation(message: "No Internet")
            if UserDefaults.isExists(key: movieId)
            {
                if let movie = UserDefaultsHelper().getMovie(movieId: movieId)
                {
                    viewModel.movieDetail = movie
                    feedView()
                }
                else
                {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
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
    func feedView()
    {
        if let imgUrl = self.viewModel.movieDetail?.posterPath, imgUrl != ""
        {
            let imgFullUrl = "\(Constant.imagesBaseUrl)\(imgUrl)"
            self.imgViewMovie.setImageFromUrl(path: imgFullUrl)
        }
        else
        {
            self.imgViewMovie.image = #imageLiteral(resourceName: "clapboard")
        }
        
        
        
        
        self.lblMovieName.text = self.viewModel.movieDetail?.originalTitle ?? "N/A"
        self.lblOverview.text = self.viewModel.movieDetail?.overview ?? "N/A"
        
        self.lblStatus.text = self.viewModel.movieDetail?.status
        self.lblBudget.text = "$\(self.viewModel.movieDetail?.budget ?? 0)"
        self.lblRevenue.text = "$\(self.viewModel.movieDetail?.revenue ?? 0)"
        self.lblReleaseDate.text = self.viewModel.movieDetail?.releaseDate
    }
}

extension MovieDetailViewController:  MovieDetailViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool) {
        DispatchQueue.main.async {
            if isSuccessFullAPIResponse
            {
                self.feedView()
            }
        }
    }
}
