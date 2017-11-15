//
//  Movie.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation

struct Movie: Codable {
	var adult: Bool?
	var genres: Dictionary?
	var idGenre: String?
	var name: String?
	var homepage: String?
	var id: String?
	var imdb_id: String?
	var original_title: String?
	var overview: String?
	var poplarity: String?
	var poster_path: String?
	var runtime: String?
	var status: String?
	var title: String?
	var video: Bool?
	var vote_average: String?
	var vote_count: String?
}
