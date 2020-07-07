//
//  ProspectSearchViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 11/4/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension QuoteSearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredModels = models.filter({
            "\($0.listPrice) \($0.model ?? "") \($0.modelDesc ?? "")".uppercased().contains(searchText.uppercased())
        })
        tableView.reloadData()
    }
}
