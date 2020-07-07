//
//  MachineOptionsCollectionView+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 9/28/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension MachineOptionsCollectionViewController:
MachineOptionViewDelegate,
MachineSummaryCollectionViewControllerDelegate,
PartLocationButtonDelegate,
ViewDisplayCollectionViewDelegate,
CustomerSearchViewControllerDelegate,
CustomerViewControllerDelegate,
MachineOptionEditViewControllerDelegate,
MachineOptionViewControllerDelegate {

    func machineOptionViewController(_ controller: MachineOptionViewController, removed option: MACHINE_OPTION, indexPath: IndexPath) {
        if machineOptionInSelectedList(machineOption: option) {
            if let optionIndex = selectedOptions.firstIndex(where: { $0.Option == option.Option }) {
                selectedOptions.remove(at: optionIndex)
                collectionView.reloadData()
            }
        }
    }

    func machineOptionViewController(_ controller: MachineOptionViewController, added option: MACHINE_OPTION) {
        if !machineOptionInSelectedList(machineOption: option) {
            selectedOptions.append(option)
            collectionView.reloadData()
        }
    }

    func machineOptionEditViewController(_ controller: MachineOptionEditViewController, removed machineOption: MACHINE_OPTION, indexPath: IndexPath) {
        if machineOptionInSelectedList(machineOption: machineOption) {
            if let optionIndex = selectedOptions.firstIndex(where: { $0.Option == machineOption.Option }) {
                selectedOptions.remove(at: optionIndex)
                collectionView.reloadData()
            }
        }
    }

    func machineOptionEditViewController(_ controller: MachineOptionEditViewController, edited machineOption: MACHINE_OPTION) {
        if !machineOptionInSelectedList(machineOption: machineOption) {
            selectedOptions.append(machineOption)
            collectionView.reloadData()
        }
    }


    func customerViewController(_ controller: CustomerViewController, created customer: ProspectCore) {
        addToCart(prospect: customer)
        controller.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func customerViewController(_ controller: CustomerViewController, updated customer: ProspectCore) {
        
    }

    func customerSearchViewController(_ navigationController: NavigationController, controller: CustomerSearchViewController, selected prospect: ProspectCore, done error: Error?) {
        addToCart(prospect: prospect)
        controller.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }


    func viewDisplayCollectionView(_ view: ViewDisplayCollectionView, imageSelected index: Int) {
        print("index: \(index)")
        /*
        if index == 0 {
            part8.alpha = 1
        } else {
            part8.alpha = 0
        }

        switch index {
        case 0:
            part4.alpha = 1
            break
        case 1:
            part4.alpha = 1
            break
        case 2:
            part4.alpha = 1
            break
        case 3:
            part4.alpha = 0
            break
        default:
            break
        }*/
    }


    func partLocationButton(_ button: PartLocationButton, tag: Int) {
        showMachineOptionView(indexPath: IndexPath(row: tag, section: 0))
    }


    func machineSummaryCollectionViewController(_ controller: MachineSummaryCollectionViewController, machineOptionRemoved machine: MACHINE, machineOptions: [MACHINE_OPTION]) {
        self.selectedOptions = machineOptions
    }

    func machineSummaryCollectionViewController(_ controller: MachineSummaryCollectionViewController, controllerClosed machine: MACHINE, machineOptions: [MACHINE_OPTION]) {
        self.selectedOptions = machineOptions
    }

    func machineSummaryCollectionViewController(_ controller: MachineSummaryCollectionViewController, addToCart machine: MACHINE, machineOptions: [MACHINE_OPTION]) {
        self.dismiss(animated: true, completion: {
            let alertController = UIAlertController(title: "Add to Cart", message: "Is this machine for a new company?", preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: "Create New", style: .default, handler: { (action) in
                let controller = CustomerViewController()
                controller.delegate = self
                self.present(NavigationController(rootViewController: controller), animated: true, completion: nil)
            }))

            alertController.addAction(UIAlertAction(title: "History", style: .default, handler: { (action) in
                let controller = CustomerSearchViewController()
                controller.delegate = self
                self.present(NavigationController(rootViewController: controller), animated: true, completion: nil)
            }))

            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            self.present(alertController, animated: true, completion: nil)
        })
    }

    func addToCart(prospect: ProspectCore) {
        let prospectId = Int(prospect.id)
        if let savedMachineCore = self.saveMachine(machine: machine, prospectId: prospectId) {
            if let _ = self.saveMachineOptions(machineOptions: self.selectedOptions, machine: savedMachineCore) {
            }
        }
    }

    func saveMachine(machine: MACHINE, prospectId: Int) -> MachineCore? {
        var model: MachineCore?
        CoreDataManager.shared.save(model: machine, prospectID: Int(prospectId)) { (machineCore, error) in
            if let machineCore = machineCore {
                model = machineCore
            }
        }
        return model
    }

    func saveMachineOptions(machineOptions: [MACHINE_OPTION], machine: MachineCore) -> [MachineOptionCore]? {
        var models: [MachineOptionCore] = [MachineOptionCore]()
        for (index, model) in machineOptions.enumerated() {
            CoreDataManager.shared.save(model: model, modelId: Int(machine.id), index: index) { (machineOptionCore, error) in
                if let _ = error {
                    return
                }
                if let machineOptionCore = machineOptionCore {
                    models.append(machineOptionCore)
                }
            }
        }
        return models
    }


    func machineOptionView(_ view: MachineOptionView, removeOptionClicked machineOption: MACHINE_OPTION) {
        guard let optionToRemoveIndex = selectedOptions.firstIndex(where: {
            $0.Model == machineOption.Model && $0.Option == machineOption.Option
        }) else {
            return
        }
        selectedOptions.remove(at: optionToRemoveIndex)
        collectionView.reloadData()
    }

    func machineOptionView(_ view: MachineOptionView, addOptionClicked machineOption: MACHINE_OPTION) {
        if !machineOptionInSelectedList(machineOption: machineOption) {
            selectedOptions.append(machineOption)
            collectionView.reloadData()
        }
    }

    func machineOptionInSelectedList(machineOption: MACHINE_OPTION) -> Bool {
        if let _ = selectedOptions.first(where: {
            $0.Model == machineOption.Model && $0.Option == machineOption.Option
        }) {
            return true
        }
        return false
    }
}
