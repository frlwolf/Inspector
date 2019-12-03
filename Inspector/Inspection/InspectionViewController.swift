//
//  ViewController.swift
//  Inspector
//
//  Created by Felipe Lobo on 02/12/19.
//  Copyright © 2019 Felipe Lobo. All rights reserved.
//

import UIKit
import Combine

class InspectionViewController: UIViewController {

    let viewModel: InspectionViewModel
    let useCase: InspectionUseCase

    var subscriber: AnyCancellable?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    init(viewModel: InspectionViewModel, useCase: InspectionUseCase) {
        self.viewModel = viewModel
        self.useCase = useCase

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("No coder implementation whatsoever")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true

        subscriber = viewModel.inspection.sink(receiveCompletion: { completion in
            print("Will never print")
        }, receiveValue: { inspection in
            print(inspection)
        })

        useCase.calculateInspection()
    }

}

