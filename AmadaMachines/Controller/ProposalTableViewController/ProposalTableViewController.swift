//
//  ProposalTableViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ProposalTableViewController: UIViewController {

    let titleView: TitleView = {
        let titleView = TitleView("Proposals", subtitle: "5 results found")
        return titleView
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupTable()

        present(NavigationController(rootViewController: CustomerViewController()), animated: true, completion: nil)
    }

    func setup() {
        view.backgroundColor = .white

        view.addSubview(titleView)
        view.addSubview(tableView)

        titleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus-item"), style: .plain, target: self, action: #selector(createProposal))
    }

    @objc func createProposal() {
        present(NavigationController(rootViewController: CustomerViewController()), animated: true, completion: nil)
    }

}
