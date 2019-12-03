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
			fatalError("The application was unable to find a 'form2.json' file at the project's bundle")
		}

		return try JSONDecoder().decode(Form.self, from: request(url: url))
	}

	private func request(url: URL) throws -> Data {
		return try Data(contentsOf: url)
	}

}