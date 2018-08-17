//
//  CategoriesViewModel.swift
//  NBAStatsClient
//
//  Created by Jad  on 16/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import RxSwift

class CategoriesViewModel {

	private let disposeBag = DisposeBag()

	var categories = Variable<[Category]>([])
	var isLoading = Variable<Bool>(false)

	init() {

		Client.categories()
			.do(onNext: { [weak self] _ in
				self?.isLoading.value = true
			})
			.subscribe(onNext: { [weak self] response in
				self?.isLoading.value = false
				self?.categories.value = response.data
				}, onError: { [weak self] error in
					print(error)
					self?.isLoading.value = false
			}).disposed(by: disposeBag)
	}

	var numberOfCategories: Int {
		return categories.value.count
	}

	func category(at index:Int) -> Category {
		return categories.value[index]
	}
}
