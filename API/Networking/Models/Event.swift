//
//  Player.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation

struct Event: Codable {
	let id: Int
	let type: Int
	let title: String
	let leadText: String
}
