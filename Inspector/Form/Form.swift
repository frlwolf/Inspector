//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation

struct Form: Decodable {

	let items: [Item]
	var responseSets: [ResponseSet] {
		params.responseSets
	}

	private let params: Params

	enum CodingKeys: String, CodingKey {
		case items
		case params
	}

	struct Params: Decodable {
		let responseSets: [ResponseSet]
		enum CodingKeys: String, CodingKey {
			case responseSets = "response_sets"
		}
	}

}