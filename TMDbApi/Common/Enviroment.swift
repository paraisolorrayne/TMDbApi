//
//  Enviroment.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation
import UIKit

class Environment {
	
	static let sharedEnvironment = Environment()
	
	enum EnvironmentTypes: String {
		case DEV = "Dev"
		case DEBUG = "Debug"
		case PRD = "Release"
	}
	
	var appKey: String!
	var token: String!
	
	var environment: EnvironmentTypes!
	var baseURL: String!
	
	init() {
		guard let environmentFromList = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String ,
			let environmentType = EnvironmentTypes(rawValue: environmentFromList) else {
				return
		}
		
		setup(environment: environmentType)
	}
	
	private func setup(environment: EnvironmentTypes) {
		switch environment {
		case .DEV, .DEBUG :
			appKey = "api_key=625a7cbd9e0ae06da951620f6f0015d1"
			baseURL = "https://api.themoviedb.org/3/"
			token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjVhN2NiZDllMGFlMDZkYTk1MTYyMGY2ZjAwMTVkMSIsInN1YiI6IjU4ZDI4OWI3OTI1MTQxMWFmNDAyMDFmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PBEWV2bJThrDncjp314r3Ke_udps4Sp5UePZJ44iRGI"
			break
		default:
			break
		}
	}
	
}
