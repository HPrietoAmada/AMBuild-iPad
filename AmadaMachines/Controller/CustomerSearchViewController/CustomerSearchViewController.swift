//
//  CustomerSearchViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 10/29/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol CustomerSearchViewControllerDelegate {
    func customerSearchViewController(_ navigationController: NavigationController, controller: CustomerSearchViewController, selected prospect: ProspectCore, done error: Error?)
}

class CustomerSearchViewController: UIViewController {

    let cellID: String = "cell-id"
    let headerID: String = "header-id"

    var delegate: CustomerSearchViewControllerDelegate?

    var models: [ProspectCore] = [ProspectCore]()
    var filteredModels: [ProspectCore] = [ProspectCore]()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search for companies from Fabtech"
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

        CoreDataManager.shared.get { (prospects: [ProspectCore], error) in
            if let _ = error {
                return
            }

            self.models = prospects
            self.filteredModels = prospects
            self.tableView.reloadData()
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
