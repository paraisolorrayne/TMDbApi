//
//  MovieTableViewCell.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation
import UIKit

enum CellState {
	case collapsed
	case expanded
}

class MovieTableViewCell: UITableViewCell {
	
	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var descriptionView: UIView!
	
	var viewModel: MovieTableViewCell.CellViewModel? {
		didSet{
			didSetViewModel()
		}
	}
	
	var state: CellState = .collapsed {
		didSet {
			toggle()
		}
	}
	
	func didSetViewModel() {
		
		guard let viewModel = viewModel else {
			return
		}
		
		numberLabel.text = String(viewModel.index ?? 0)
		titleLabel.text = viewModel.text ?? ""
		descriptionLabel.text = viewModel.detailText ?? ""
		descriptionLabel.isHidden = viewModel.cellState != nil ? viewModel.cellState == .collapsed : true
		descriptionView.isHidden = viewModel.cellState != nil ? viewModel.cellState == .collapsed : true
	}
	
	private func toggle() {
		descriptionLabel.isHidden = state == .collapsed
		descriptionView.isHidden = state == .collapsed
	}
}

extension MovieTableViewCell {
	struct CellViewModel {
		var text: String?
		var detailText: String?
		var cellState: CellState?
		var index: Int?
	}
}
