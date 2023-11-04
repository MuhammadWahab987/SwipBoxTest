//
//  MovieDetailViewModel.swift
//  SBTest
//
//  Created by Muhammad Wahab on 04/11/2023.
//

import Foundation

protocol MovieDetailViewModelDelegate: BaseViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool)
}

class MovieDetailViewModel: BaseViewModel {
    
     
    var movieDetail : MovieDetailModel?
    weak var delegate: MovieDetailViewModelDelegate? {
        didSet {
            super.baseDelegate = delegate
        }
    }
    
    func loadData(movieId:String) {
        let request = MovieDetailRequest()
        request.movieId = movieId
        delegate?.showPorgress()
        APIClient.shared.fetchDataWithRequest(request: request) { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.hideProgress()
            
            if response.success {
                let movieDetailModelResp = response.data as? MovieDetailModel
                print("movieDetailModelResp: ", movieDetailModelResp)
                self.movieDetail = movieDetailModelResp
                self.delegate?.updateView(isSuccessFullAPIResponse: true)
                
                
            } else {
                AlertBuilder.showBannerBelowNavigation(message: response.message)
                self.delegate?.updateView(isSuccessFullAPIResponse: false)
            }
        }
    }
}
