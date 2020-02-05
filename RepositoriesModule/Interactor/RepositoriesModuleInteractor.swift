//
//  RepositoriesModuleInteractor.swift
//  RepositoriesModule
//
//  Created by user165891 on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Entities
import NetworkLayer

final class RepositoriesModuleInteractor {
    var interactorToPresenterProtocol: RepositoriesModuleInteractorToPresenter!
    let sessionProvider = URLSessionProvider()
}

// MARK: - Repositories module presenter to interactor

extension RepositoriesModuleInteractor: RepositoriesModulePresenterToInteractor {
    func fetchRepositories(nextUrl: URL) {
        sessionProvider.request(type: Repositories.self, url: nextUrl) { response in
            self.handleRespons(response)
        }
    }
    
    func fetchRepositories(searchText: String, pageIndex: Int) {
        let service = GitHubService.repositories(searchText: searchText, pageIndex: pageIndex)
        sessionProvider.request(type: Repositories.self, service: service) { response in
             self.handleRespons(response)
        }
    }
    
    private func handleRespons(_ response: NetworkResponse<Repositories>) {
        switch response {
        case let .success(repositories, nextUrl):
            self.interactorToPresenterProtocol.fetched(repositories: repositories.items, nextUrl: nextUrl)
        case let .failure(error):
            self.interactorToPresenterProtocol.failedToFetchRepositories(error: error)
        }
    }
    
}
