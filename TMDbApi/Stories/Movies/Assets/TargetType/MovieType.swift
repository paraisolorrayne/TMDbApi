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
	case fetchMovie(String!)
}

extension MovieType: TargetType {
	
	var  baseURL: URL {return URL (string: Environment.sharedEnvironment.baseURL)!}
	var path: String {
		/*
		NSString *completeUrl = [NSString stringWithFormat:@"%@%@%@&query=%@", kUrlBase, kSearchMovie, kApiKey, query];
		kUrlBase = @"https://api.themoviedb.org/3/";
		kSearchMovie = @"search/movie?";
		kApiKey = @"api_key=625a7cbd9e0ae06da951620f6f0015d1";
		query
		https://api.themoviedb.org/3/search/movie?api_key=625a7cbd9e0ae06da951620f6f0015d1&query=300
		*/
		switch self {
		case .fetchMovie(let query):
				return "search/movie?" + Environment.sharedEnvironment.appKey + "&query="
		}
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var parameters: [String: Any]? {
		switch self {
		case .fetchMovie(let query):
			return [
				"query": query
			]
		}
	}
	
	public var parameterEncoding: ParameterEncoding {
		switch self {
		case .fetchMovie(_):
			return JSONEncoding.default
		default:
			return URLEncoding.queryString
		}
	}
	
	var sampleData: Data {
		switch self {
		case .fetchMovie(_):
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
					let responseObject = try JSONDecoder().decode(Movie.self, from: data)
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
