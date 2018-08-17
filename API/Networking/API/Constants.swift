//
//  Constants.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation

protocol Tokenable {
	static var token: String { get }
}

enum APIKeys {
	enum ParisData: Tokenable {
		static var token = "hBpH5zFZz9aXuRwzkbW3jxCt6tDpUCSXdwpSt4AL0QSuKwXWSHBSrQ"
	}
}

enum API {
	enum ParameterKey {

		static let token = "token"

		enum Event {
			static let categories = "categories" // identifiants des catégories, séparés par des virgules
			static let tags = "tags" 			 //identifiants des tags, séparés par des virgules
			static let start = "start"			 // début d'inteval de la date de l'évènement, indiquez 0 pour tout récupérer
			static let end = "end"				 //fin d'inteval de la date de l'évènement, indiquez 0 pour tout récupérer
			static let offset = "offset"		 //offset de la requête
			static let limit = "limit"			 //(Int) - nombre maximum d'évènement à récupérer
		}
	}

	enum HTTPHeaderField: String {
		case authentication = "Authorization"
		case contentType = "Content-Type"
		case acceptType = "Accept"
		case acceptEncoding = "Accept-Encoding"
	}

	enum ContentType: String {
		case json = "application/json"
	}

	enum Production {
		enum Server {
			static let baseURL = "https://api.paris.fr/api/data"
		}
	}
}
