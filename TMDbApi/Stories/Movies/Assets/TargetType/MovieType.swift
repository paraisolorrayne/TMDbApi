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
	case movieURL(query:String)
}

extension MovieType: TargetType {
	
	var  baseURL: URL {return URL (string: Environment.sharedEnvironment.baseURL)!}
	var path: String {
		switch self {
		case .movieURL(let query):
			let queryEncoding = query.replacingOccurrences(of: " ", with: "+")
			let pathUrl =  "search/movie?" + Environment.sharedEnvironment.appKey + "&query=" + queryEncoding
			let pathEncoding = pathUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
			if let pathEncod = pathEncoding {
				return pathEncod
			} else {
				return ""
			}
		}
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var parameters: [String: Any]? {
		return nil
	}
	
	public var parameterEncoding: ParameterEncoding {
			return URLEncoding.default
	}
	
	var sampleData: Data {
		switch self {
		case .movieURL(_):
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
					let responseObject = try JSONDecoder().decode(Query.self, from: data)
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
