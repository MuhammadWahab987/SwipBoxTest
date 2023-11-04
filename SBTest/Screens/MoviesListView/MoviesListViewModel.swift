//
//  MoviesListViewModel.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import Foundation

protocol MoviesListViewModelDelegate: BaseViewModelDelegate {
    func updateView(isSuccessFullAPIResponse: Bool)
}

class MoviesListViewModel: BaseViewModel {
    
    var moviesList:[MovieModel] = []
    
    weak var delegate: MoviesListViewModelDelegate? {
        didSet {
            super.baseDelegate = delegate
        }
    }
    
    func loadData() {
        let request = MoviesListRequest()
        delegate?.showPorgress()
        APIClient.shared.fetchDataWithRequest(request: request) { [weak self] (response) in
            guard let self = self else { return }
            self.delegate?.hideProgress()
            
            if response.success {
                let moviesListModelResp = response.data as? MoviesListModel
                print("moviesListModelResp:",moviesListModelResp)
                self.moviesList = moviesListModelResp?.results ?? []
                self.delegate?.updateView(isSuccessFullAPIResponse: true)
                
            } else {
                AlertBuilder.showBannerBelowNavigation(message: response.message)
                self.delegate?.updateView(isSuccessFullAPIResponse: false)
            }
        }
    }
}
