//
//  CustomerSearchViewController+TableView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/29/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension CustomerSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasicTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BasicTableViewCell
        if filteredModels.count > 0 {
            let filteredModel = filteredModels[indexPath.row]
            cell.topLeftLabel.text = "\(filteredModel.companyName ?? "")"
            cell.bottomLeftLabel.text = filteredModel.email ?? ""
            if let createdDate = filteredModel.createdDate {
                cell.bottomRightLabel.text = createdDate.formatted()
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = filteredModels[indexPath.row]
        if let delegate = delegate {
            delegate.customerSearchViewController(self.navigationController as! NavigationController, controller: self, selected: selectedModel, done: nil)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
