//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

struct ResponseSet: Decodable {

	let uuid: String
	let responses: [Response]

	enum CodingKeys: String, CodingKey {
		case uuid
		case responses
	}

}