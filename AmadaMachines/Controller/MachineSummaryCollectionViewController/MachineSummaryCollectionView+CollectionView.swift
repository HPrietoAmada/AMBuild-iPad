//
//  MachineSummaryCollectionView+CollectionView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/28/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension MachineSummaryCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return machineOptions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MachineOptionCollectionViewCell
        cell.machineOption = machineOptions[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        cell.priceLabel.alpha = 0
        CoreDataManager.shared.get { (coreModels: [PriceToggleCore], error) in
            if let _ = error {
                return
            }

            // Option Price
            if let priceToggleCore = coreModels.first(where: { $0.controller == "MachineSummaryCollectionViewController" && $0.view == "optionPrice"}) {
                cell.priceLabel.alpha = priceToggleCore.show ? 1 : 0
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! MachineCollectionViewHeaderCell
            header.machine = machine
            header.subtotalLabel.text = "Subtotal (\(machineOptions.count + 1) items): $\(subtotal().currencyFormatted())"
            header.saveButton.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
            header.listPriceLabel.alpha = 0
            header.subtotalLabel.alpha = 0
            CoreDataManager.shared.get { (coreModels: [PriceToggleCore], error) in
                if let _ = error {
                    return
                }
                // Machine Price
                if let priceToggleCore = coreModels.first(where: { $0.controller == "MachineSummaryCollectionViewController" && $0.view == "machinePrice"}) {
                    header.listPriceLabel.alpha = priceToggleCore.show ? 1 : 0
                }

                // Total Price
                if let priceToggleCore = coreModels.first(where: { $0.controller == "MachineSummaryCollectionViewController" && $0.view == "totalPrice"}) {
                    header.subtotalLabel.alpha = priceToggleCore.show ? 1 : 0
                }
            }
            return header
        }
        return UICollectionReusableView()
    }

    @objc func handleAddToCart() {
        if let delegate = delegate {
            delegate.machineSummaryCollectionViewController(self, addToCart: machine, machineOptions: machineOptions)
        }
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MachineOptionCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(MachineCollectionViewHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

    func subtotal() -> Double {
        var subtotal: Double = 0
        subtotal = subtotal + machine.listPrice

        machineOptions.forEach { (machineOption) in
            subtotal = subtotal + machineOption.ListPrice
        }
        return subtotal.rounded(toPlaces: 2)
    }

}
