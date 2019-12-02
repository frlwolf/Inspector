//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation

struct Form {

}

protocol FormGateway {

	func fetchForm() -> Form

}

class FormFetcher: FormGateway {

	func fetchForm() -> Form {
		return Form()
	}

}