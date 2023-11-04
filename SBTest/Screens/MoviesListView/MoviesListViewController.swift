//
//  MoviesListViewController.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import UIKit
import Alamofire

class MoviesListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cvMovies: UICollectionView!
    
    
    // MARK: - Variables & Constants
    let networkReachabilityManager = NetworkReachabilityManager()
    var viewModel:  MoviesListViewModel! {
        didSet {
            super.baseViewModel = viewModel
        }
    }
    
    // MARK: - UIViewController Initializer
    
    init(viewModel: MoviesListViewModel) {
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
            viewModel.loadData()
        }
        else
        {
            AlertBuilder.showBannerBelowNavigation(message: "No Internet")
            if let movieList = UserDefaultsHelper().getMovieListing()
            {
                viewModel.moviesList = movieList.results ?? []
                cvMovies.reloadData()
            }
        }
    }
    
    // MARK: - UIViewController Helper Methods
    
    override func setupViewController()  {
        viewModel.delegate = self
        
        //Collection View
        cvMovies.registerCell(class: MoviesListCollectionViewCell.self)
        cvMovies.delegate = self
        cvMovies.dataSource = self
       
    }
    
    override func setupNavigationBarUI() {
        navigationItem.title = "Popular Movies"
    }
    
    // MARK: - Selectors
    
    // MARK: - IBActions
    
    // MARK: - Private Methods
}

// MARK: - MoviesListViewModelDelegate
extension MoviesListViewController:  MoviesListViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.cvMovies.reloadData()
        }
        
    }
    
    
    
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell:MoviesListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCollectionViewCell", for: indexPath) as? MoviesListCollectionViewCell else {return UICollectionViewCell()}
        let movie = viewModel.moviesList[indexPath.item]
        cell.setupCell(movie: movie, indexPath: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetailVC = MovieDetailViewController(viewModel: MovieDetailViewModel())
        movieDetailVC.movieId = "\(viewModel.moviesList[indexPath.item].id ?? 0)"
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
