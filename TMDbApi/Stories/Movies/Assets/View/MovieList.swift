//
//  MovieList.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation
import UIKit

fileprivate extension UITableViewCell.Identifier {
	static let movieInfo = UITableViewCell.Identifier("MovieResult")
}

class MovieList: UIViewController, UISearchBarDelegate {
	var presenter = MoviePresenter()
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	var query: String!
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.delegate = self
		searchBar.delegate = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 74.0
	}
	
	public func setTypeOfView(type: FetchType) {
		presenter.fetchType = type
	}
	
	func captureQuery() -> String {
		query = searchBar.text
		return query
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		presenter.movieName = captureQuery()
		presenter.loadData()
	}
}

extension MovieList: MoviePresenterDelegate {
//	func whatIsYourMoviePresenter(presenter: MoviePresenter, sendRequestWith query: String) {
//		self.query = self.captureQuery()
//	}
	
	func didFinishToFetchData() {
		tableView.reloadData()
	}
}

extension MovieList: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.viewModel.cellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MovieResult", for: indexPath) as! MovieTableViewCell
		cell.viewModel = presenter.viewModel.cellViewModels[indexPath.row]
		
		return cell
	}
}

extension MovieList: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
		cell.state = .expanded
		presenter.viewModel.cellViewModels[indexPath.row].cellState = .expanded
		
		tableView.beginUpdates()
		tableView.endUpdates()
		
		let cellRect: CGRect = tableView.convert(cell.frame, to: tableView.superview)
		
		if !tableView.frame.contains(cellRect) {
			tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
		}
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
		cell.state = .collapsed
		presenter.viewModel.cellViewModels[indexPath.row].cellState = .collapsed
		
		tableView.beginUpdates()
		tableView.endUpdates()
	}
}
