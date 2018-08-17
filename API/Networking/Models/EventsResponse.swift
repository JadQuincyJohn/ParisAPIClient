//
//  EventsResponse.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation

struct EventsResponse: Response, Codable {
	typealias DataType = [Event]
	var data: [Event]
	var status: String
}
