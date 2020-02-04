//
//  RepositoriesModulePresenter.swift
//  RepositoriesModule
//
//  Created by user165891 on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Entities

final class RepositoriesModulePresenter {
    weak var view: RepositoriesModulePresenterToView!
    var interactor: RepositoriesModulePresenterToInteractor!
    
    var pageIndex = 0
    let perPage = 25
}

// MARK: - Repositories module view to presenter

extension RepositoriesModulePresenter: RepositoriesModuleViewToPresenter {
    func viewIsReady() {
        view.addNavigationBarTitle()
        view.addSearchBar()
        view.configureTableView()
        pageIndex += 1
        interactor.fetchRepositories(pageIndex: pageIndex, perPage: perPage)
    }
    
    func viewWillAppear() {
        view.deselectSelectedRows()
    }
    
    func fetchRepositories() {
        pageIndex += 1
        interactor.fetchRepositories(pageIndex: pageIndex, perPage: perPage)
    }
    
}

// MARK: - Repositories module interactor to presenter

extension RepositoriesModulePresenter: RepositoriesModuleInteractorToPresenter {
    func fetched(repositories: [Repository]) {
        pageIndex == 1 ? view.reloadTableView(by: repositories) :
        view.updateTableView(by: repositories, perPage: perPage)
    }
    
    func failedToFetchRepositories(error: Error) {
    }
    
}
