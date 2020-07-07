//
//  ShoppingCartSummaryCollectionViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 9/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension ShoppingCartSummaryCollectionViewController: MachineOptionCollectionViewCellDelegate {
    func machineOptionCollectionViewCell(_ view: MachineOptionCollectionViewCell, optionRemove machineOption: MACHINE_OPTION, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Removing Machine Option", message: "Are you sure you want to remove this option?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let removeAction = UIAlertAction(title: "Remove", style: .default) { (action) in
            self.machineOptions.remove(at: indexPath.row)
            self.collectionView.reloadData()
            if let delegate = self.delegate {
                delegate.shoppingCartSummaryCollectionViewController(self, machineOptionRemoved: self.machine, machineOptions: self.machineOptions)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(removeAction)
        present(alertController, animated: true, completion: nil)
    }
}
