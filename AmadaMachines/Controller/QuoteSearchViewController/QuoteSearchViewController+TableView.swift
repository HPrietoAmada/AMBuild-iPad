//
//  ProspectSearchViewController+TableView.swift
//  AmadaMachines
//
//  Created by IT Support on 11/4/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension QuoteSearchViewController: UITableViewDelegate, UITableViewDataSource {

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
            cell.topLeftLabel.text = filteredModel.modelDesc ?? ""
            cell.topRightLabel.text = machineSubtotal(model: filteredModel).currencyFormatted()
            if let createdDate = filteredModel.createdDate {
                cell.bottomRightLabel.text = createdDate.formatted()
            }

            if let customer = customers.first(where: { $0.id == filteredModel.prospectId }) {
                cell.bottomLeftLabel.text = customer.companyName ?? ""
            }
        }
        return cell
    }

    func machineSubtotal(model: MachineCore) -> Double {
        var subtotal: Double = 0
        let machineOptions = self.machineOptionModels.filter({ $0.modelId == model.id })
        subtotal = subtotal + model.listPrice
        machineOptions.forEach { (machineOption) in
            subtotal = subtotal + machineOption.listPrice
        }
        return subtotal.rounded(toPlaces: 2)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = filteredModels[indexPath.row]
        if let delegate = delegate {
            let options = self.machineOptionModels.filter({ $0.modelId == selectedModel.id })
            delegate.quoteSearchViewController(self.navigationController as! NavigationController, controller: self, selected: selectedModel, optionsCore: options, done: nil)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
