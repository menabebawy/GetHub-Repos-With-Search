//
//  RepositoriesModulePresenterToView.swift
//  RepositoriesModule
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import Entities

protocol RepositoriesModulePresenterToView: class {
    func addSearchBar()
    func addNavigationBarTitle()
    func requestRepositoris()
    func deselectSelectedRows()
    func configureTableView()
    func reloadTableView(by repositories: [Repository])
    func updateTableView(by repositories: [Repository], perPage: Int)
}
