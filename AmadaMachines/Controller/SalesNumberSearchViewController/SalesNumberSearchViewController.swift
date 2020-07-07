//
//  SalesNumberSearchViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 9/12/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol SalesNumberSearchViewControllerDelegate {
    func salesNumberSearchViewControllerDelegate(_ controller: NavigationController, salesman: AS400_SALESMAN, done error: Error?)
}

class SalesNumberSearchViewController: UIViewController {

    let cellID: String = "cell-id"
    let headerID: String = "header-id"

    var delegate: SalesNumberSearchViewControllerDelegate?

    var models = [AS400_SALESMAN]()
    var filteredModels = [AS400_SALESMAN]()

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = "Search Amada Salesman Number..."
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        models = AS400_SALESMAN().getSalesman()

        searchBar.becomeFirstResponder()
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
