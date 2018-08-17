//
//  Response.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation


protocol Response {
	associatedtype DataType
	var data: DataType { get set }
	var status: String { get }
}
