//
//  CoreDataManager+Machine.swift
//  AmadaMachines
//
//  Created by IT Support on 9/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias machineReturned = (MachineCore?, Error?) -> Void
typealias machinesReturned = ([MachineCore], Error?) -> Void

extension CoreDataManager {
    func save(model: MACHINE, prospectID: Int, _ completionHandler: machineReturned?) {
        let context = persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: "MachineCore", into: context) as! MachineCore
        object.setValue(model.model, forKey: "Model")
        object.setValue(model.modelDesc, forKey: "ModelDesc")
        object.setValue(model.listPrice, forKey: "ListPrice")
        object.setValue(prospectID, forKey: "prospectId")
        object.setValue(model.createdDate, forKey: "createdDate")
        var machineId: Int32 = 1
        get { (machineCores: [MachineCore], error) in
            if let last = machineCores.sorted(by: { $0.id < $1.id }).last {
                machineId = last.id + 1
            }
        }
        object.setValue(machineId, forKey: "id")
        do {
            try context.save()
            completionHandler?(object, nil)
        } catch let err {
            completionHandler?(nil, err)
        }
    }

    func get(_ completionHandler: machinesReturned) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MachineCore>(entityName: "MachineCore")
        do {
            let models = try context.fetch(fetchRequest)
            completionHandler(models, nil)
        } catch let err {
            completionHandler([], err)
        }
    }

    func delete(model: MachineCore, _ completionHandler: ProgressComplete?) {
        let context = persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }
    }

    func deleteAllMachineCores() {
        get { (coreModels: [MachineCore], error) in
            if let _ = error {
                return
            }
            coreModels.forEach { (coreModel) in
                delete(model: coreModel, nil)
            }
        }
    }
}
