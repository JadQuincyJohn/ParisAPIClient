//
//  EventsViewModel.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Foundation
import RxSwift

class EventsViewModel {

	private let disposeBag = DisposeBag()

	var filters = Variable<[Category]>([])
	var events = Variable<[Event]>([])
	var isLoading = Variable<Bool>(false)

	init(categories: Variable<[Category]>) {

		self.filters = categories

		self.filters
			.asObservable()
			.subscribe(onNext: { [weak self] _ in
				print("Fliters changes")
				self?.fetchCategories()
		}).disposed(by: disposeBag)
	}

	func fetchCategories() {
		Client.events(categories: filters.value)
			.do(onNext: { [weak self] _ in
				self?.isLoading.value = true
			})
			.subscribe(onNext: { [weak self] response in
				self?.isLoading.value = false
				self?.events.value = response.data
				}, onError: { [weak self] error in
					print(error)
					self?.isLoading.value = false
			}).disposed(by: disposeBag)
	}

	var numberOfEvents: Int {
		return events.value.count
	}

	func event(at index:Int) -> Event {
		return events.value[index]
	}
}
