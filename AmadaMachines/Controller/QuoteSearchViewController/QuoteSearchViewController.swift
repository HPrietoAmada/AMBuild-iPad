//
//  ProspectSearchViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 11/4/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol QuoteSearchViewControllerDelegate {
    func quoteSearchViewController(_ navigationController: NavigationController, controller: QuoteSearchViewController, selected model: MachineCore, optionsCore: [MachineOptionCore], done error: Error?)
}

class QuoteSearchViewController: UIViewController {

    let cellID: String = "cell-id"
    let headerID: String = "header-id"

    var delegate: QuoteSearchViewControllerDelegate?

    var models: [MachineCore] = [MachineCore]()
    var filteredModels: [MachineCore] = [MachineCore]()

    var customers: [ProspectCore] = [ProspectCore]()
    var machineOptionModels: [MachineOptionCore] = [MachineOptionCore]()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search for proposals from Fabtech"
        searchBar.sizeToFit()
        return searchBar
    }()

    lazy var cancelNavbarButtonItem: TextNavbarButtonItem = {
        let textNavbarButtonItem = TextNavbarButtonItem("Cancel")
        textNavbarButtonItem.action = #selector(cancel)
        textNavbarButtonItem.target = self
        return textNavbarButtonItem
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()

        CoreDataManager.shared.get { (prospects: [MachineCore], error) in
            if let _ = error {
                return
            }

            self.models = prospects
            self.filteredModels = prospects
            self.tableView.reloadData()
        }

        CoreDataManager.shared.get{ (models: [MachineOptionCore], error) in
            if let _ = error {
                return
            }
            self.machineOptionModels = models
        }

        CoreDataManager.shared.get{ (models: [ProspectCore], error) in
            if let _ = error {
                return
            }
            self.customers = models
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }

    func setup() {
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = cancelNavbarButtonItem
        searchBar.delegate = self

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
