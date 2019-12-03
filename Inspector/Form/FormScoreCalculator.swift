//
// Created by Felipe Lobo on 02/12/19.
// Copyright (c) 2019 Felipe Lobo. All rights reserved.
//

import Foundation

struct FormScoreCalculator {

	let items: [Item]
	let responsesDict: Dictionary<String, [Response]>

	init(form: Form) {
		items = form.items
		responsesDict = form.responseSets.reduce([String: [Response]]()) { seed, next in
			var dict = seed
			dict[next.uuid] = next.responses
			return dict
		}
	}

	func calculateScore() -> Score {
		return calculateScore(items: items)
	}

	private func calculateScore(items: [Item]?) -> Score {
		guard let items = items else {
			return .zero
		}

		return items.reduce(Score.zero) { seed, item in
			return seed + self.calculateScore(item: item)
		}
	}

	private func calculateScore(item: Item) -> Score {
		if let question = ScorableQuestion(item: item) {
			return scoreFor(question: question)
		} else if let section = Section(item: item) {
			return scoreFor(section: section)
		}

		return calculateScore(items: item.items)
	}

	private func scoreFor(question: ScorableQuestion) -> Score {
		if question.responseType != "list" {
			return .zero
		}

		guard let responses = responsesDict[question.responseSet] else {
			return .zero
		}

		guard let actual = responses.first(where: { rp in
			return question.responses.first == rp.uuid
		})?.score else {
			return .zero
		}

		let maxScore = responses.reduce(0) { seed, response in
			return max(seed, (response.score ?? 0))
		}

		return Score(actual: actual, max: maxScore)
	}

	private func scoreFor(section: Section) -> Score {
		return calculateScore(items: section.items) * section.weight
	}

}

struct Score {

	let actual: Int
	let max: Int

	static var zero = Score(actual: 0, max: 0)

	static func +(lhs: Score, rhs: Score) -> Score {
		let actual = lhs.actual + rhs.actual
		let max = lhs.max + rhs.max
		return Score(actual: actual, max: max)
	}

	static func *(lhs: Score, rhs: Int) -> Score {
		return Score(actual: lhs.actual * rhs, max: lhs.max * rhs)
	}

}
