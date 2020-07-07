//
//  MachineBuildModel.swift
//  AmadaMachines
//
//  Created by IT Support on 11/12/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import Foundation

class MachineBuildModel: Codable {
    public var Prospect: ProspectModel?
    public var Machine: MachineModel?
    public var MachineOptions: [MachineOptionModel]?

    init(machine: MachineModel, machineOptions: [MachineOptionModel]) {
        Machine = machine
        MachineOptions = machineOptions
    }

    init(machineCore: MachineCore, machineOptionCores: [MachineOptionCore]) {
        CoreDataManager.shared.get { (prospectCores: [ProspectCore], error) in
            if let _ = error {
                return
            }
            if let coreModel = prospectCores.first(where: { $0.id == machineCore.prospectId }) {
                Prospect = ProspectModel(coreModel)
            }
        }
        Machine = MachineModel(machineCore)
        var machineOptions: [MachineOptionModel] = [MachineOptionModel]()
        machineOptionCores.forEach { (optionCore) in
            let optionModel = MachineOptionModel(optionCore)
            machineOptions.append(optionModel)
        }
        MachineOptions = machineOptions
    }
}
