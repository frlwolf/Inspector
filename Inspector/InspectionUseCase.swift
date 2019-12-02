//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation

class InspectionUseCase {

	let presentable: InspectionPresentable
	let gateway: FormGateway

	init(gateway: FormGateway, presentable: InspectionPresentable) {
		self.presentable = presentable
		self.gateway = gateway
	}

	func calculateInspection() {
		let _ = gateway.fetchForm()

		// processes the form and creates an inspection

		let inspection = Inspection(actualScore: 1, maxScore: 1)

		presentable.present(inspection: inspection)
	}

}