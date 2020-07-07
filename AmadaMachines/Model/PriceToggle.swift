//
//  PriceToggle.swift
//  AmadaMachines
//
//  Created by IT Support on 10/2/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import Foundation

struct PriceToggle {
    public var id: Int = 0
    public var controller: String = ""
    public var show: Bool = false
    public var view: String = ""
    public var description: String = ""

    init(id: Int,
         controller: String,
         show: Bool,
         view: String,
         description: String) {
        self.id = id
        self.controller = controller
        self.show = show
        self.view = view
        self.description = description
    }

    init() {
        self.id = 0
        self.controller = ""
        self.show = false
        self.view = ""
        self.description = ""
    }

    func priceToggleCore() -> PriceToggleCore? {
        var priceToggleCore: PriceToggleCore?
        CoreDataManager.shared.get { (coreModels: [PriceToggleCore], error) in
            if let _ = error {
                return
            }
            priceToggleCore = coreModels.first(where: { Int($0.id) == self.id })
        }
        return priceToggleCore
    }

    func save() {
        if let savedPriceToggleCore = priceToggleCore() {
            CoreDataManager.shared.update(model: savedPriceToggleCore, nil)
            return
        }
        CoreDataManager.shared.save(model: self, nil)
    }

    func getPriceToggleList() -> [PriceToggle] {
        return [
            PriceToggle(
                id: 1,
                controller: "MachineViewControllerViewController",
                show: false,
                view: "MachineCollectionViewCell",
                description: "Show machine price in machines list"
            ),
            PriceToggle(
                id: 2,
                controller: "MachineOptionsCollectionViewController",
                show: false,
                view: "machinePrice",
                description: "Show machine price in machine description"
            ),
            PriceToggle(
                id: 3,
                controller: "MachineOptionsCollectionViewController",
                show: false,
                view: "optionPrice",
                description: "Show option price in option description"
            ),
            PriceToggle(
                id: 4,
                controller: "MachineSummaryCollectionViewController",
                show: false,
                view: "machinePrice",
                description: "Show machine price in machine summary"
            ),
            PriceToggle(
                id: 5,
                controller: "MachineSummaryCollectionViewController",
                show: false,
                view: "optionPrice",
                description: "Show option price in machine summary"
            ),
            PriceToggle(
                id: 6,
                controller: "MachineSummaryCollectionViewController",
                show: false,
                view: "totalPrice",
                description: "Show total price in machine summary"
            ),
            PriceToggle(
                id: 7,
                controller: "ShoppingCartCollectionViewController",
                show: false,
                view: "machinePrice",
                description: "Show machine price in shopping cart"
            ),
            PriceToggle(
                id: 8,
                controller: "ShoppingCartCollectionViewController",
                show: false,
                view: "optionPrice",
                description: "Show option price in shopping cart"
            ),
            PriceToggle(
                id: 9,
                controller: "ShoppingCartCollectionViewController",
                show: false,
                view: "totalPrice",
                description: "Show total purchase price in shopping cart"
            )
        ]
    }
}
