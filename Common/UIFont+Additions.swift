//
//  UIFont+Additions.swift
//  NBAStatsClient
//
//  Created by Jad  on 16/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import UIKit

extension UIFont {
	func sizeOfString (string: String, constrainedToWidth width: CGFloat) -> CGSize {
		return NSString(string: string).boundingRect(
			with: CGSize(width: width, height: .greatestFiniteMagnitude),
			options: .usesLineFragmentOrigin,
			attributes: [.font: self],
			context: nil).size
	}
}
