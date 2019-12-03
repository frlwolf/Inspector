//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

struct Response: Decodable {

	let uuid: String
	let score: Int?

	enum CodingKeys: String, CodingKey {
		case uuid
		case score
	}

}
