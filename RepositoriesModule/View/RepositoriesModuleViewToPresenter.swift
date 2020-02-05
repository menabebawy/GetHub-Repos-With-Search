//
//  RepositoriesModuleViewToPresenter.swift
//  RepositoriesModule
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Foundation

protocol RepositoriesModuleViewToPresenter {
    func viewIsReady()
    func viewWillAppear()
    func fetchFirstPageOfRepositoris(searchText: String)
    func fetchMoreRepositories(searchText: String)
    func sectionHeight(repositoriesCount: Int) -> Int
    func sectionTitle(repositoriesCount: Int) -> String
    func resetIndex()
}
