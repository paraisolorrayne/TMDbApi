//
//  MovieType.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation
import Moya
import Result
enum MovieType {
	case fetchMovie()
}

extension MovieType: TargetType {
	var  baseURL: URL {return URL (string: Environment.sharedEnvironment.baseURL)!}
	var path: String {
		switch self {
		case .fetchMovie():
			return "search/movie?" + Environment.sharedEnvironment.appKey + "&query="
		}
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var parameters: [String: Any]? {
		switch self {
		case .fetchMovie(let query):
			return [
				"query": phoneNumber
			]
		default:
			return nil
		}
	}
	
	public var parameterEncoding: ParameterEncoding {
		switch self {
		case .fetchMovie(_):
			return JSONEncoding.default
		default:
			return URLEncoding.default
		}
	}
	
	var sampleData: Data {
		switch self {
		case .fetchMovie():
			return Data(fromFileWithName: "movie", ofType: "json") ?? Data()
		}
	}
	
	var task: Task {
		return .requestPlain
	}
	
	func response(completion: @escaping (_ responseResult: Result<Codable?, ServiceError>) -> Void) -> Completion {
		return { (result) in
			switch result {
			case let .success(moyaResponse):
				let data = moyaResponse.data
				if moyaResponse.response?.expectedContentLength == 0 {
					completion(.success(nil))
					return
				}
				do {
					let responseObject = try JSONDecoder().decode(WhatDoYouPrefer.self, from: data)
					completion(.success(responseObject))
					
				} catch {
					let mappingError = MoyaError.jsonMapping(moyaResponse)
					completion(.failure(ServiceError.moyaError(mappingError)))
				}
			case let .failure(error):
				completion(.failure(ServiceError.moyaError(error)))
				break
			}
		}
	}
}
