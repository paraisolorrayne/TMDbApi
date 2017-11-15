//
//  DataExtension.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation

extension Data {
	init?(fromFileWithName name: String, ofType type: String) {
		if let url = Bundle.main.url(forResource: name, withExtension: type),
			let data = try? Data(contentsOf: url, options: .mappedIfSafe) {
			self = data
		}
		else {
			return nil
		}
		
	}
}
