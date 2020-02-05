//
//  RepositoriesModulePresenterToInteractor.swift
//  RepositoriesModule
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

protocol RepositoriesModulePresenterToInteractor {
    func fetchRepositories(searchText: String, pageIndex: Int)
    func fetchRepositories(nextUrl: URL)
}
