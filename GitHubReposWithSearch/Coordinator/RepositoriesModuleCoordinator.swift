//
//  RepositoriesModuleCoordinator.swift
//  GitHubReposWithSearch
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import RepositoriesModule

final class RepositoriesModuleCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let nibName = String(describing: RepositoriesModuleViewController.self)
        let rendererViewController = RepositoriesModuleViewController(nibName: nibName, bundle: .main)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.viewControllers = [rendererViewController]
    }
    
}
