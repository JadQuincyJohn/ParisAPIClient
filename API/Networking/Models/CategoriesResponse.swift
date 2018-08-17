//
//  CategoriesResponse.swift
//  NBAStatsClient
//
//  Created by Jad  on 16/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation

struct CategoriesResponse: Response, Codable {
	typealias DataType = [Category]
	var data: [Category]
	var status: String
}
