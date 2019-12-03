//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation

struct Inspection {

	let actualScore: Int
	let maxScore: Int

	var score: Float {
		return maxScore == 0 ? 0 : Float(actualScore) / Float(maxScore)
	}

}
