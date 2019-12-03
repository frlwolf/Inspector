//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation
import Combine

protocol FormGateway {

	func fetchForm() throws -> AnyPublisher<Form?, Never>

}

class FormFetcher: FormGateway {

	func fetchForm() throws -> AnyPublisher<Form?, Never> {

		let url = URL(string: "http://lumiform-sandbox.s3.eu-central-1.amazonaws.com/form2.json")!
		let publisher = URLSession.shared.dataTaskPublisher(for: url)
				.map { $0.data }
				.decode(type: Form?.self, decoder: JSONDecoder())
				.replaceError(with: nil)
				.eraseToAnyPublisher()

		return publisher
	}

}
