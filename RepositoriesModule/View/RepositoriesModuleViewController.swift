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
    private var requestSearchWorkItem: DispatchWorkItem?
    
    var viewToPresenterProtocol: RepositoriesModulePresenter!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewToPresenterProtocol.viewIsReady()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewToPresenterProtocol.viewWillAppear()
    }
    
    private func resetTableViewData() {
        repositories = []
        tableView.reloadData()
        viewToPresenterProtocol.resetIndex()
    }
    
    private func dismissSearchbarKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.searchController.searchBar.resignFirstResponder()
        }
    }
    
    private func firstSectionTitle() -> String {
        viewToPresenterProtocol.sectionTitle(repositoriesCount: repositories.count)
    }
    
}

// MARK: - Repositories module presenter to view

extension RepositoriesModuleViewController: RepositoriesModulePresenterToView {
    func addSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Repository search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    func addNavigationBarTitle() {
        title = "GitHub search"
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
        dismissSearchbarKeyboard()
        self.repositories.append(contentsOf: repositories)
        tableView.reloadData()
    }
    
    func updateTableView(by repositories: [Repository]) {
        dismissSearchbarKeyboard()
        self.repositories.append(contentsOf: repositories)
        let lastRow = self.repositories.count
        let indexPaths = Array((lastRow - repositories.count)..<lastRow).map { IndexPath(row: $0, section: 0) }
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .none)
        tableView.endUpdates()
        // Update section 0 title
        tableView.headerView(forSection: 0)?.textLabel?.text = firstSectionTitle()
    }
    
}

// MARK: - Search controller delegate

extension RepositoriesModuleViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dismissSearchbarKeyboard()
            resetTableViewData()
        } else {
            requestSearchWorkItem?.cancel()

            requestSearchWorkItem = DispatchWorkItem { [weak self] in
                self?.viewToPresenterProtocol.fetchFirstPageOfRepositoris(searchText: searchText)
            }

            if let requestSearchWorkItem = requestSearchWorkItem  {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: requestSearchWorkItem)
            }
        }
    }
        
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resetTableViewData()
    }
    
}

// MARK: - Table view data source

extension RepositoriesModuleViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.identifier, for: indexPath) as? RepositoryTableViewCell else {
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
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryTableViewCell.estimatedHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(viewToPresenterProtocol.sectionHeight(repositoriesCount: repositories.count))
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Update by first section title because we have only one section
        return firstSectionTitle()
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 1,
            let searchText = searchController.searchBar.text {
            viewToPresenterProtocol.fetchMoreRepositories(searchText: searchText)
        }
    }
    
}
