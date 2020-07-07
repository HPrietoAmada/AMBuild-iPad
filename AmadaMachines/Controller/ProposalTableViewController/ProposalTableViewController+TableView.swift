//
//  ProposalTableViewController+TableView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension ProposalTableViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InfoTableViewCell
        cell.titleLabel.text = "Audi"
        cell.descriptionLabel.text = "HRB-ATC"
        cell.totalLabel.text = "$250,000"
        cell.dateLabel.text = "August 8, 2019"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(MachineOptionsCollectionViewController(), animated: true)
    }

    
}
