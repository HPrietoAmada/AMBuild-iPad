//
//  CustomerSearchViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 10/29/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension CustomerSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredModels = models.filter({
            "\($0.companyName ?? "") \($0.email ?? "") \($0.notes ?? "") \($0.phoneNumber ?? "") \($0.qrCode ?? "") \($0.salesnumber)".uppercased().contains(searchText.uppercased())
        })
        tableView.reloadData()
    }
}
