//
//  UserSelection.swift
//  NBAStatsClient
//
//  Created by Jad  on 16/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import RxSwift

enum UserSelection {

	static var categories = Variable<[Category]>([])

	static func clear() {
		categories.value = []
	}

	static func add(category: Category) {
		categories.value.append(category)
		printState()
	}

	static func remove(category: Category) {
		let index = categories.value.index(where: {
			$0.idcategories == category.idcategories
		})

		if let index = index {
			categories.value.remove(at: index)
		}
		printState()
	}

	static func printState() {
		categories.value.forEach {
			print($0.name)
		}
	}
}
