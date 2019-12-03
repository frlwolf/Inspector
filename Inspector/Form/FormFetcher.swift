//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation

protocol FormGateway {

	func fetchForm() throws -> Form

}

class FormFetcher: FormGateway {

	func fetchForm() throws -> Form {
		guard let url = Bundle.main.url(forResource: "form2", withExtension: ".json") else {
			fatalError()
		}

		let json = try JSONDecoder().decode(Form.self, from: Data(contentsOf: url))

		return json
	}

}