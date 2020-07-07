//
//  SalesNumberSearchViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 9/12/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension SalesNumberSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredModels = models.filter({ "\($0.SalesmanNumber) \($0.FirstName) \($0.LastName)".uppercased().contains(searchText.uppercased()) })
        tableView.reloadData()
    }
}
