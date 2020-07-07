//
//  MachineOptionsCollectionView+CollectionView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension MachineOptionsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TitleHeaderCollectionViewHeaderDelegate {

    func titleHeaderCollectionViewHeader(_ header: TitleHeaderCollectionViewHeader, indexPath: IndexPath) {
        collapseSections[indexPath.section] = !collapseSections[indexPath.section]
        collectionView.reloadData()
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight: CGFloat = (collectionViewWidth * (6/9)) + 50
        return CGSize(width: collectionViewWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collapseSections[section] {
            return 0
        }
        return getSectionOptions(section: section).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let options = getSectionOptions(section: indexPath.section)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! ListBasicCollectionViewCell
        let machineOption = options[indexPath.row]
        cell.titleText = machineOption.Option
        cell.index = indexPath.row + 1

        if let machineOptionImage = UIImage(named: machineOption.Option) {
            cell.image = machineOptionImage
        } else {
            cell.image = UIImage()
            cell.imageView.backgroundColor = .lightGray
        }
        cell.descText = machineOption.OptionDesc
        /*
        cell.descriptionText = "Amada punch holder that utilizes the One Touch type tooling tang. Automatically seats the punch when the locking lever is engaged. Eliminates the need to seat punches which is required with the standard AGRIP-S punch holders which can accept both One Touch and Standard Amada tooling."*/
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let options = getSectionOptions(section: indexPath.section)
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! TitleHeaderCollectionViewHeader
            header.titleFont = UIFont(name: "HelveticaNeue-Bold", size: 21)
            header.subtitleFont = UIFont(name: "HelveticaNeue", size: 18)
            header.headerTitle = sections[indexPath.section]
            header.headerSubTitle = "\(options.count) result(s) found"
            header.indexPath = indexPath
            header.delegate = self
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.width, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let optionSection = indexPath.section == 0
        let toolingSection = indexPath.section == 1
        let softwareSection = indexPath.section == 2
        let serviceContractSection = indexPath.section == 3

        if optionSection {
            showMachineOptionView(indexPath: indexPath)
        }

        if toolingSection {
            showEditOptionViewController(indexPath: indexPath)
        }

        if softwareSection {
            showMachineOptionView(indexPath: indexPath)
        }

        if serviceContractSection {
            showEditOptionViewController(indexPath: indexPath, showPickerView: true)
        }
    }

    func showEditOptionViewController(indexPath: IndexPath, showPickerView: Bool = false) {
        let sectionOptions = getSectionOptions(section: indexPath.section)
        let option = sectionOptions[indexPath.row]

        let controller = MachineOptionEditViewController()
        controller.machineOptionSelected = machineOptionInSelectedList(machineOption: getSectionOptions(section: indexPath.section)[indexPath.row])
        controller.machineOption = option
        controller.showPickerViewModel = showPickerView
        controller.delegate = self
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    func showMachineOptionView(indexPath: IndexPath, _ show: Bool = true) {
        let controller = MachineOptionViewController()
        controller.delegate = self
        controller.machineOptionSelected = machineOptionInSelectedList(machineOption: getSectionOptions(section: indexPath.section)[indexPath.row])
        controller.machineOption = getSectionOptions(section: indexPath.section)[indexPath.row]
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
        /*
        let machineOption = getSectionOptions(section: indexPath.section)[indexPath.row]
        machineOptionView.machineOption = machineOption
        machineOptionView.contentSize = CGSize(width: 600, height: 1200)
        machineOptionView.machineOptionSelected = machineOptionInSelectedList(machineOption: machineOption)
        machineOptionView.index = "\(indexPath.row + 1)"

        UIView.animate(withDuration: blurAnimationDuration, animations: {
            self.blurBackgroundView.alpha = show ? 1 : 0
            self.view.layoutIfNeeded()
        })
         */
    }

    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ListBasicCollectionViewCell.self, forCellWithReuseIdentifier: self.cellID)
        collectionView.register(TitleHeaderCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

    func getSectionOptions(section: Int) -> [MACHINE_OPTION] {
        let optionSection = sections[section]
        return machineOptions.filter({ $0.MachineType.uppercased() == optionSection.uppercased() })
    }

}
