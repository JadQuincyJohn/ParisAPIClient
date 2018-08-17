//
//  APIError.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation

enum APIError: Error {
	case parsingFailed
	case notConnectedToInternet
	case timedOut
}
