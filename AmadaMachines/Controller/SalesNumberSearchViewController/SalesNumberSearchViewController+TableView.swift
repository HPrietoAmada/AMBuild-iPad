//
//  SalesNumberSearchViewController+TableView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/12/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension SalesNumberSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableCellWithDate.self, forCellReuseIdentifier: cellID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableCellWithDate
        if filteredModels.count > 0 {
            let filteredModel = filteredModels[indexPath.row]
            cell.title = "\(filteredModel.FirstName) \(filteredModel.LastName) - \(filteredModel.Email)"
            cell.detailLabel.text = "\(filteredModel.Email)"
            cell.hasBorder = filteredModels.count - 1 != indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = filteredModels[indexPath.row]

        guard let delegate = delegate else {
            return
        }

        delegate.salesNumberSearchViewControllerDelegate(self.navigationController as! NavigationController, salesman: selectedModel, done: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
