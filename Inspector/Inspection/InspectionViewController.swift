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

    private lazy var actualLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()

    private lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28)

        return label
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 36)

        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.lightText, for: .normal)
        button.setTitle("Unleash the magic", for: .normal)
        button.layer.cornerRadius = 4.0
        button.addTarget(self, action: #selector(unleashTheMagic(sender:)), for: .touchUpInside)
//        button.setContentHuggingPriority(.defaultLow, for: .horizontal)

        return button
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

        setupViews()
        setupConstraints()
        
        subscriber = viewModel.inspection.sink(receiveCompletion: { completion in
            print("Will never print")
        }, receiveValue: { [weak self] inspection in
            if let inspection = inspection {
                self?.configure(inspection: inspection)
            }
        })
    }

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(actualLabel)
        view.addSubview(maxLabel)
        view.addSubview(scoreLabel)
        view.addSubview(button)
    }

    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            actualLabel.bottomAnchor.constraint(equalTo: maxLabel.topAnchor, constant: -8),
            actualLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            
            maxLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -8),
            maxLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor),

            scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor),

            button.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 24),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.66),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    @objc
    private func unleashTheMagic(sender: UIButton) {
        sender.isEnabled = false
        useCase.calculateInspection()
    }
    
    private func configure(inspection: Inspection) {
        actualLabel.text = "Actual: \(inspection.actualScore)"
        maxLabel.text = "Max: \(inspection.maxScore)"
        scoreLabel.text = "Score: \(inspection.score)"
    }

}

