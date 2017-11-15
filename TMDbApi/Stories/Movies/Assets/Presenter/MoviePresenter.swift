//
//  MoviePresenter.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation
import UIKit
import Moya
import Result

public enum FetchType {
	case fetchMovie()
}
protocol MoviePresenterDelegate {
	func didFinishToFetchData()
	func whatIsYourMoviePresenter(presenter: MoviePresenter, sendRequestWith query:String)
}

class MoviePresenter {
	var fetchType: FetchType?
	var viewModel: MoviePresenter.ViewModel!
	var provider = MoyaProvider<MovieType>()
	var delegate: MoviePresenterDelegate?
	var movieName: String!
	
	init() {
		viewModel = ViewModel(movieName: movieName, cellViewModels: [])
	}
	
	@objc func sendData() {
		guard viewModel.movieName != nil else {
			return
		}
	}
	
	func loadData() {
		guard let fetchMovie = fetchType else {
			return
		}
		let preferType = MovieType.fetchMovie(movieName)
		provider.request(preferType, completion: preferType.response(completion: { (result) in
			switch result {
			case .success(let whatDoYouPrefer):
				guard let whatDoYouPrefer = whatDoYouPrefer as? Query else {
					return
				}
				switch fetchMovie {
				case .fetchMovie:
					let informationMovie = whatDoYouPrefer.query
					self.setCells(whatMoviePrefer: informationMovie!)
					break
				}
			case .failure(_): break
				
			}}))
	}
	
	func setCells(whatMoviePrefer: [Movie]){
		var cellViewModels: [MovieTableViewCell.CellViewModel] = []
		var count = 1
		for option in whatMoviePrefer {
			cellViewModels.append(MovieTableViewCell.CellViewModel(text: option.title,
																   detailText: option.overview,
																   cellState: .collapsed,
																   index: count))
			count = count + 1
		}
		
		viewModel =  MoviePresenter.ViewModel(movieName: movieName, cellViewModels: cellViewModels)
		delegate?.didFinishToFetchData()
	}
	
}


extension MoviePresenter {
	struct ViewModel {
		var movieName: String?
		var cellViewModels: [MovieTableViewCell.CellViewModel]
	}
}
