//
//  RepositoriesModuleInteractorToPresenter.swift
//  RepositoriesModule
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Entities

protocol RepositoriesModuleInteractorToPresenter {
    func fetched(repositories: [Repository])
    func failedToFetchRepositories(error: Error)
}
