//
//  Reusable.swift
//  NBAStatsClient
//
//  Created by Jad  on 16/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import UIKit

protocol Reusable where Self: UIView {
	static var reuseIdentifier: String { get }
}

extension Reusable {

	static var reuseIdentifier: String {
		return String(describing: self)
	}
}
