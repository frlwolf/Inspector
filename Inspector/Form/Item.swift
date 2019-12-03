//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

struct Item: Decodable {

	let type: String
	let items: [Item]?

	let responseType: String?
	var responseSet: String? {
		params?.responseSet
	}
	let response: [String]?
	private let params: Params?

	let weight: Int?

	enum CodingKeys: String, CodingKey {
		case type
		case items
		case responseType = "response_type"
		case params
		case response
		case weight
	}

    struct Params: Decodable {
		let responseSet: String?
		enum CodingKeys: String, CodingKey {
			case responseSet = "response_set"
		}
	}
    
    init(type: String, items: [Item]? = nil, responseType: String? = nil, params: Params? = nil, response: [String]? = nil, weight: Int? = nil) {
        self.type = type
        self.items = items
        self.responseType = responseType
        self.response = response
        self.params = params
        self.weight = weight
    }
    
}

struct ScorableQuestion {

	let responseType: String
	let responseSet: String
	let responses: [String]

	init?(item: Item) {
		if item.type != "question" || item.responseType != "list" {
			return nil
		}
		responseType = item.responseType!
		responseSet = item.responseSet!
		responses = item.response!
	}

}

struct Section {

	let items: [Item]
	let weight: Int

	init?(item: Item) {
		if item.type != "section" {
			return nil
		}
		items = item.items!
		weight = item.weight!
	}

}
