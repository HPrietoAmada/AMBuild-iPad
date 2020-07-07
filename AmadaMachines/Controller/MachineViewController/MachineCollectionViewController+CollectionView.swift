//
//  MachineTableViewController+TableView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension MachineCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MACHINE().getMachines().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MachineCollectionViewCell
        let machine = MACHINE().getMachines()[indexPath.row]
        if let machineImage = UIImage(named: "\(machine.model)_01") {
            cell.modelImage = machineImage
        }
        //cell.modelImage = UIImage(named: "press_brake_aai")
        cell.machine = machine
        cell.listPriceLabel.alpha = 0
        CoreDataManager.shared.get { (coreModels: [PriceToggleCore], error) in
            if let _ = error {
                return
            }
            if let showMachinePrice = coreModels.first(where: { $0.controller == "MachineViewControllerViewController" && $0.view == "MachineCollectionViewCell" }) {
                cell.listPriceLabel.alpha = showMachinePrice.show ? 1 : 0
            }
        }
        cell.cellSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        /*
        let viewHeight: CGFloat = view.bounds.height - 160
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:

            break
        case .pad:
            cell.cellSize = CGSize(width: view.bounds.width, height: viewHeight)
            break
        default:
            break
        }*/
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewHeight: CGFloat = (view.bounds.height) - 200
        return CGSize(width: view.bounds.width, height: viewHeight)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! TitleHeaderTableViewCell
            header.headerTitle = "Amada Machines"
            header.headerSubTitle = "\(MACHINE().getMachines().count) Machines Found."
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let machine = MACHINE().getMachines()[indexPath.row]
        let controller = MachineOptionsCollectionViewController()
        controller.machine = machine
        if let prospectCore = prospectCore {
            controller.prospectCore = prospectCore
        }
        navigationController?.pushViewController(controller, animated: true)
    }

    func setupTable() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MachineCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(TitleHeaderTableViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

}
