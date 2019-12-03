//
//  InspectorTests.swift
//  InspectorTests
//
//  Created by Felipe Lobo on 02/12/19.
//  Copyright © 2019 Felipe Lobo. All rights reserved.
//

import XCTest
@testable import Inspector

class InspectorTests: XCTestCase {

    var form: Form? = nil
    
    override func setUp() {
        let items = [
            Item(type: "page", items: [
                Item(type:"question", responseType: "anything"),
                Item(type:"question", responseType: "list", params: Item.Params(responseSet: "ABC"), response: [ "A" ]),
                Item(type:"section", items: [
                    Item(type:"question", responseType: "anything"),
                    Item(type:"question", responseType: "anything_else"),
                    Item(type:"question", responseType: "list", params: Item.Params(responseSet: "CDE"), response: [ "A" ]),
                    Item(type:"question", responseType: "list", params: Item.Params(responseSet: "FGH"), response: [ "B" ])
                ], weight: 2),
                Item(type:"section", items: [
                    Item(type:"question", responseType: "anything"),
                    Item(type:"question", responseType: "list", params: Item.Params(responseSet: "CDE"), response: [ "A" ]),
                    Item(type:"section", items: [
                        Item(type:"question", responseType: "anything"),
                        Item(type:"question", responseType: "list", params: Item.Params(responseSet: "CDE"), response: [ "B" ]),
                        Item(type:"question", responseType: "list", params: Item.Params(responseSet: "IJK"), response: [ "B" ])
                    ], weight: 4)
                ], weight: 3)
            ]),
            Item(type: "page", items: [
                Item(type:"question", responseType: "anything"),
                Item(type:"question", responseType: "list", params: Item.Params(responseSet: "LMN"), response: [ "A" ])
            ])
        ]
        
        let params = Form.Params(responseSets: [
            ResponseSet(uuid: "ABC", responses: [
                Response(uuid: "A", score: 2),
                Response(uuid: "B", score: 1),
            ]),
            ResponseSet(uuid: "CDE", responses: [
                Response(uuid: "A", score: 0),
                Response(uuid: "B", score: 1),
            ]),
            ResponseSet(uuid: "FGH", responses: [
                Response(uuid: "A", score: 12),
                Response(uuid: "B", score: nil),
            ]),
            ResponseSet(uuid: "IJK", responses: [
                Response(uuid: "A", score: 8),
                Response(uuid: "B", score: 4),
            ]),
            ResponseSet(uuid: "LMN", responses: [
                Response(uuid: "A", score: 2),
                Response(uuid: "B", score: 15),
            ])
        ])
        
        form = Form(items: items, params: params)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculatorCalculatesCorrectly() {
        guard let form = form else {
            XCTFail()
            return
        }
        
        let calculator = FormScoreCalculator(form: form)
        let score = calculator.calculateScore()
        
        XCTAssert(score.actual == 64)
        XCTAssert(score.max == 130)
    }

}
