//
//  ShoppingCartCollectionViewController+CollectionView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension ShoppingCartCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = prospectCore {
            return coreModels.count
        }
        let prospectCoreModel = prospects[section]
        return coreModels.filter({ $0.prospectId == prospectCoreModel.id }).count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let _ = prospectCore {
            return 1
        } else {
            return prospects.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MachineCollectionViewCell
        CoreDataManager.shared.get { (coreModels: [PriceToggleCore], error) in
            if let _ = error {
                return
            }
            if let showMachinePrice = coreModels.first(where: { $0.controller == "MachineViewControllerViewController" && $0.view == "MachineCollectionViewCell" }) {
                cell.listPriceLabel.alpha = showMachinePrice.show ? 1 : 0
            }
        }
        if let _ = prospectCore {
            cell.machineCore = coreModels[indexPath.row]
        } else {
            let prospectCoreModel = prospects[indexPath.section]
            let machine = coreModels.filter({ $0.prospectId == prospectCoreModel.id })[indexPath.row]
            cell.machineCore = machine
        }
        cell.modelImage = UIImage(named: "press_brake_aai")
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            cell.cellSize = CGSize(width: view.bounds.width, height: 575)
            break
        case .pad:
            cell.cellSize = CGSize(width: view.bounds.width, height: 400)
            break
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return CGSize(width: view.bounds.width, height: 400)
        default:
            return CGSize(width: view.bounds.width, height: 550)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! TitleHeaderTableViewCell
            if let _ = prospectCore {
                header.headerTitle = "Shopping Cart"
                header.headerSubTitle = "\(coreModels.count) Machines Found."
            } else {
                if coreModels.count == 0 {
                    header.headerTitle = "No results found."
                } else {
                    let prospectCoreModel = prospects[indexPath.section]
                    header.headerTitle = prospectCoreModel.companyName ?? "Customer Name"
                    header.titleColor = UIColor.MainColors.lightColor
                    var emailText: String = ""
                    var phoneText: String = ""
                    if let prospectEmail = prospectCoreModel.email {
                        emailText = prospectEmail.count == 0 ? "" : "Email: \(prospectEmail)"
                    }
                    if let prospectPhone = prospectCoreModel.phoneNumber {
                        phoneText = prospectPhone.count == 0 ? "" : "Phone: \(prospectPhone)"
                    }
                    header.headerSubTitle = "\(emailText) \(phoneText)"
                }
            }
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let _ = prospectCore {
            return CGSize(width: view.bounds.width, height: 100)
        } else {
            return CGSize(width: view.bounds.width, height: 60)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if let _ = prospectCore {
            return UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let machine = coreModels[indexPath.row]
        let controller = ShoppingCartSummaryCollectionViewController()
        controller.machine = machine
        navigationController?.pushViewController(controller, animated: true)
    }

    func setupTable() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MachineCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(TitleHeaderTableViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

}
