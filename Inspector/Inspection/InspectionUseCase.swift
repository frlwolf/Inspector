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
		let form = try! gateway.fetchForm()
		let score = FormScoreCalculator(form: form).calculateScore()
		presentable.present(inspection: Inspection(score: score))
	}

}

extension Inspection {

	init(score: Score) {
		self.init(actualScore: score.actual, maxScore: score.max)
	}

}
