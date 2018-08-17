//
//  Router.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Alamofire

enum Router: APIConfiguration {

	case events(categories: String, tags: String, start: String, end: String, offset: String, limit: String)
	case categories

	var method: HTTPMethod {
		switch self {
		case .events, .categories:
			return .get


		}
	}

	var path: String {
		switch self {
		case .events:
			return "/2.2/QueFaire/get_events"
		case .categories:
			return "/1.0/Equipements/get_categories"
		}
	}

	var parameters: Parameters? {
		switch self {
		case .events(let categories, let tags, let start, let end, let offset, let limit):
			return [API.ParameterKey.token: APIKeys.ParisData.token,
					API.ParameterKey.Event.categories: categories,
					API.ParameterKey.Event.tags: tags,
					API.ParameterKey.Event.start: start,
					API.ParameterKey.Event.end: end,
					API.ParameterKey.Event.offset: offset,
					API.ParameterKey.Event.limit: limit]
		case .categories:
			return [API.ParameterKey.token: APIKeys.ParisData.token]
		}
	}

	func asURLRequest() throws -> URLRequest {
		
		let baseUrl = try API.Production.Server.baseURL.asURL()
		let endpointUrl = baseUrl.appendingPathComponent(path)

		var resultURLRequest: URLRequest

		if var components = URLComponents(string: endpointUrl.absoluteString), let parameters = parameters {

			var queryItems = [URLQueryItem]()
			for (key, value) in parameters {
				queryItems.append(URLQueryItem(name: key, value: value as? String))
			}
			components.queryItems = queryItems
			resultURLRequest = URLRequest(url: components.url!)
		}
		else {
			resultURLRequest = URLRequest(url: endpointUrl)
		}

		// HTTP Method
		resultURLRequest.httpMethod = method.rawValue
		// Common Headers
		resultURLRequest.setValue(API.ContentType.json.rawValue, forHTTPHeaderField: API.HTTPHeaderField.acceptType.rawValue)
		resultURLRequest.setValue(API.ContentType.json.rawValue, forHTTPHeaderField: API.HTTPHeaderField.contentType.rawValue)

		return resultURLRequest
	}
}
