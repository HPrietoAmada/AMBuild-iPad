//
//  MachineCoreSummaryCollectionViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 11/4/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension MachineCoreSummaryCollectionViewController: MachineOptionCollectionViewCellDelegate {
    func machineOptionCollectionViewCell(_ view: MachineOptionCollectionViewCell, optionRemove machineOption: MACHINE_OPTION, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Removing Machine Option", message: "Are you sure you want to remove this option?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let removeAction = UIAlertAction(title: "Remove", style: .default) { (action) in
            let removedOption = self.machineOptions[indexPath.row]
            CoreDataManager.shared.delete(model: removedOption) { (true, error) in
                if let _ = error {
                    return
                }
                self.machineOptions.remove(at: indexPath.row)
                self.collectionView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(removeAction)
        present(alertController, animated: true, completion: nil)
    }


    func machineOptionCollectionViewCell(_ view: MachineOptionCollectionViewCell, optionRemove machineOption: MachineOptionCore, indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Removing Machine Option", message: "Are you sure you want to remove this option?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let removeAction = UIAlertAction(title: "Remove", style: .default) { (action) in
            self.machineOptions.remove(at: indexPath.row)
            self.collectionView.reloadData()
            if let delegate = self.delegate {
                delegate.machineCoreSummaryCollectionViewController(self, machineOptionRemoved: self.machine, machineOptions: self.machineOptions)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(removeAction)
        present(alertController, animated: true, completion: nil)
    }
}
