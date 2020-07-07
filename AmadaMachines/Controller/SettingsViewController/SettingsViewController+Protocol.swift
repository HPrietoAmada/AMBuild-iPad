//
//  SettingsViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 10/29/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension SettingsViewController: CustomerSearchViewControllerDelegate, CustomerViewControllerDelegate, QuoteSearchViewControllerDelegate {

    func quoteSearchViewController(_ navigationController: NavigationController, controller: QuoteSearchViewController, selected model: MachineCore, optionsCore: [MachineOptionCore], done error: Error?) {
        let controller = MachineCoreSummaryCollectionViewController()
        controller.machine = model
        controller.machineOptions = optionsCore
        navigationController.pushViewController(controller, animated: true)
    }

    func customerViewController(_ controller: CustomerViewController, created customer: ProspectCore) {

    }

    func customerViewController(_ controller: CustomerViewController, updated customer: ProspectCore) {
        controller.navigationController?.popViewController(animated: true)
    }

    func customerSearchViewController(_ navigationController: NavigationController, controller: CustomerSearchViewController, selected prospect: ProspectCore, done error: Error?) {
        let controller = CustomerViewController()
        controller.prospectCore = prospect
        controller.delegate = self
        print("Prospect: \(prospect.companyName ?? "None")")
        navigationController.pushViewController(controller, animated: true)
    }
}
