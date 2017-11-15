//
//  ServiceError.swift
//  TMDbApi
//
//  Created by Lorrayne Paraiso C Flor on 15/11/17.
//  Copyright © 2017 Lorrayne Paraiso C Flor. All rights reserved.
//

import Foundation
import Moya

public struct BusinessError: Codable, Error {
	var code: String?
	var text: String?
	var title: String?
}

public enum ServiceError: Swift.Error {
	case businessError(BusinessError)
	case moyaError(MoyaError)
}
