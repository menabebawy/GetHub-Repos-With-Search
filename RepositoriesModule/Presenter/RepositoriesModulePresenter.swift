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
    
    private var currentPageIndex = 1
    private var nextUrl: URL?
}

// MARK: - Repositories module view to presenter

extension RepositoriesModulePresenter: RepositoriesModuleViewToPresenter {
    func viewIsReady() {
        view.addNavigationBarTitle()
        view.addSearchBar()
        view.configureTableView()
    }
    
    func viewWillAppear() {
        view.deselectSelectedRows()
    }
    
    func fetchFirstPageOfRepositoris(searchText: String) {
        interactor.fetchRepositories(searchText: searchText, pageIndex: currentPageIndex)
    }
    
    func fetchMoreRepositories(searchText: String) {
        if let nextUrl = nextUrl {
            currentPageIndex += 1
            interactor.fetchRepositories(nextUrl: nextUrl)
        } else {
            print("No more repos")
        }
    }
    
    func sectionHeight(repositoriesCount: Int) -> Int {
        return repositoriesCount > 0 ? 28 : 0
    }
    
    func sectionTitle(repositoriesCount: Int) -> String {
        return "Repositories (\(repositoriesCount))"
    }
    
    func resetIndex() {
        currentPageIndex = 1
        nextUrl = nil
    }

}

// MARK: - Repositories module interactor to presenter

extension RepositoriesModulePresenter: RepositoriesModuleInteractorToPresenter {
    func fetched(repositories: [Repository], nextUrl: URL?) {
        self.nextUrl = nextUrl
        currentPageIndex == 1 ? view.reloadTableView(by: repositories) :
            view.updateTableView(by: repositories)
    }
    
    func failedToFetchRepositories(error: Error) {
        print(error.localizedDescription)
    }
    
}
