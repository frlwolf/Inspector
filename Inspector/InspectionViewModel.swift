//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation
import Combine

extension Inspection {

	enum Error: Swift.Error {
		case any
	}

}

protocol InspectionPresentable {

	func present(inspection: Inspection)

}

class InspectionViewModel {

	let inspection: CurrentValueSubject<Inspection?, Inspection.Error>

	init() {
		inspection = CurrentValueSubject(nil)
	}

}

extension InspectionViewModel: InspectionPresentable {

	func present(inspection: Inspection) {
		self.inspection.send(inspection)
	}

}