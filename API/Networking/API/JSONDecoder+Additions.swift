//
//  JSONDecoder+Additions.swift
//  NBAStatsClient
//
//  Created by Jad  on 10/08/2018.
//  Copyright © 2018 Jad . All rights reserved.
//

import Alamofire


extension JSONDecoder {
	func decodeResponse<T: Decodable>(from response: DataResponse<T>) -> Result<T> {
		guard response.error == nil else {
			// got an error in getting the data, need to handle it
			print(response.error!)
			return .failure(response.error!)
		}

		// make sure we got JSON and it's a dictionary

		guard let responseData = response.data else {
			print("didn't get any data from API")
			return .failure(response.error!)
		}

		// turn data into expected type
		do {
			let item = try decode(T.self, from: responseData)
			return .success(item)
		} catch {
			print("error trying to decode response")
			print(error)
			return .failure(error)
		}
	}
}
