//
//  RepositoriesModuleViewController.swift
//  RepositoriesModule
//
//  Created by Mena Bebawy on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit
import Entities
import Utils

public final class RepositoriesModuleViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!

    private var searchController: UISearchController!
    private var repositories: [Repository] = []

    var viewToPresenterProtocol: RepositoriesModulePresenter!

    override public func viewDidLoad() {
        super.viewDidLoad()
        viewToPresenterProtocol.viewIsReady()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewToPresenterProtocol.viewWillAppear()
    }

}

// MARK: - Repositories module presenter to view

extension RepositoriesModuleViewController: RepositoriesModulePresenterToView {
    func addSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    func addNavigationBarTitle() {
        title = "GitHub Public Repos"
    }
    
    func requestRepositoris() {
    }
    
    func deselectSelectedRows() {
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(RepositoryTableViewCell.nib(),
                           forCellReuseIdentifier: RepositoryTableViewCell.identifier)
    }
    
    func reloadTableView(by repositories: [Repository]) {
        self.repositories.append(contentsOf: repositories)
        tableView.reloadData()
    }
    
    func updateTableView(by repositories: [Repository], perPage: Int) {
        self.repositories.append(contentsOf: repositories)
        let lastRow = self.repositories.count
        let indexPaths = Array((lastRow - perPage)..<lastRow).map { IndexPath(row: $0, section: 0) }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .none)
        tableView.endUpdates()
    }
    
}

// MARK: - Table view data source

extension RepositoriesModuleViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(repository: repositories[indexPath.row])
        return cell
    }

}

// MARK: - Table view delegate

extension RepositoriesModuleViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.repositoriesModuleViewController(self, didSelect: repositories[indexPath.row])
    }

}

// MARK: - Table view prefeteching

extension RepositoriesModuleViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let isFetchMoreRepositories = indexPaths.contains(where: { $0.row == repositories.count - 1 })
        if isFetchMoreRepositories {
            viewToPresenterProtocol.fetchRepositories()
        }
    }

}
