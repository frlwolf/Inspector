//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation
import Combine

class InspectionUseCase {

	let presentable: InspectionPresentable
	let gateway: FormGateway
	var cancellable: AnyCancellable?

	init(gateway: FormGateway, presentable: InspectionPresentable) {
		self.presentable = presentable
		self.gateway = gateway
	}

	func calculateInspection() {
		cancellable = try? gateway.fetchForm()
			.receive(on: RunLoop.main)
			.sink(receiveValue: { form in
				if let form = form {
					let score = FormScoreCalculator(form: form).calculateScore()
					self.presentable.present(inspection: Inspection(score: score))
				}
			})
	}

}

extension Inspection {

	init(score: Score) {
		self.init(actualScore: score.actual, maxScore: score.max)
	}

}
