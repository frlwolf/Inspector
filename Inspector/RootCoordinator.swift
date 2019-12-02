//
//  RootCoordinator.swift
//  Inspector
//
//  Created by Felipe Lobo on 02/12/19.
//  Copyright © 2019 Felipe Lobo. All rights reserved.
//

import UIKit

class RootCoordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window

        let formFetcher = FormFetcher()
        let viewModel = InspectionViewModel()
        let useCase = InspectionUseCase(gateway: formFetcher, presentable: viewModel)
        
        let viewController = InspectionViewController(viewModel: viewModel, useCase: useCase)

        window.rootViewController = viewController
    }
    
    func start() {
        window.makeKeyAndVisible()
    }
    
}
