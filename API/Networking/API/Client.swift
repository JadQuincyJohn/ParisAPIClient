//
//  Client.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Alamofire
import RxSwift


struct Client {

	@discardableResult
	private static func performRequest<T: Decodable>(route: Router, decoder: JSONDecoder = JSONDecoder()) -> Observable<T> where T: Response {

		return Observable.create { observer  -> Disposable in

			let request = Alamofire
				.request(route)
				.validate()
				.responseData { (response) in

					switch response.result {
					case .success(let data):
						print(response)
						guard let response = try? decoder.decode(T.self, from: data) else {
							observer.onError( APIError.parsingFailed )
							return
						}
						observer.onNext(response)
						observer.onCompleted()
					case .failure(let error):
						switch (error as NSError).code {
						case NSURLErrorNotConnectedToInternet:
							observer.onError( APIError.notConnectedToInternet )
						case NSURLErrorTimedOut:
							observer.onError( APIError.timedOut )
						default:
							observer.onError( error )
						}
					}
			}
			return Disposables.create(with: request.cancel)
		}
	}

	static func events(categories: [Category]) -> Observable<EventsResponse> {
		let categoriesIdentifiersArray = categories.map { String($0.idcategories) }.joined(separator: ",")
		let route = Router.events(categories: categoriesIdentifiersArray, tags: "0", start: "0", end: "0", offset: "0", limit: "")
		let eventsResponse: Observable<EventsResponse> = performRequest(route: route)
		return eventsResponse
	}

	static func categories() -> Observable<CategoriesResponse> {
		let route = Router.categories
		let categoriesResponse: Observable<CategoriesResponse> = performRequest(route: route)
		return categoriesResponse
	}
}
