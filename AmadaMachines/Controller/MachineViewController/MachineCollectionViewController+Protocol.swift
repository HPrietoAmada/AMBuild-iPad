//
//  MachineCollectionViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 10/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension MachineCollectionViewController: PriceToggleViewControllerDelegate, SettingsViewControllerDelegate {

    func settingsViewController(controllerDismissed controller: SettingsViewController) {
        collectionView.reloadData()
    }

    func pricetoggleViewController(_ controller: PriceToggleViewController, switchToggled priceToggle: PriceToggle) {
        collectionView.reloadData()
    }
}
