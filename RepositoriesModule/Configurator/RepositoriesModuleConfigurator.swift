//
//  RepositoriesModuleConfigurator.swift
//  RepositoriesModule
//
//  Created by user165891 on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

final class RepositoriesModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? RepositoriesModuleViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: RepositoriesModuleViewController) {
        let presenter = RepositoriesModulePresenter()
        presenter.view = viewController

        let interactor = RepositoriesModuleInteractor()
        interactor.interactorToPresenterProtocol = presenter

        presenter.interactor = interactor
        viewController.viewToPresenterProtocol = presenter
    }
}
