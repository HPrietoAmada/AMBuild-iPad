//
//  CoreDataManager+MachineOption.swift
//  AmadaMachines
//
//  Created by IT Support on 9/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias machineOptionReturned = (MachineOptionCore?, Error?) -> Void
typealias machineOptionsReturned = ([MachineOptionCore], Error?) -> Void

extension CoreDataManager {

    func save(model: MACHINE_OPTION, modelId: Int, index: Int, _ completionHandler: machineOptionReturned?) {
        let context = persistentContainer.viewContext

        let object = NSEntityDescription.insertNewObject(forEntityName: "MachineOptionCore", into: context) as! MachineOptionCore
        object.setValue(model.Model, forKey: "Model")
        object.setValue(model.Option, forKey: "Option")
        object.setValue(model.OptionDesc, forKey: "OptionDesc")
        object.setValue(model.ListPrice, forKey: "ListPrice")
        object.setValue(modelId, forKey: "modelId")
        object.setValue(index, forKey: "id")
        object.setValue(model.CreatedDate, forKey: "createdDate")

        do {
            try context.save()
            completionHandler?(object, nil)
        } catch let err {
            completionHandler?(nil, err)
        }
    }

    func get(_ completionHandler: machineOptionsReturned) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MachineOptionCore>(entityName: "MachineOptionCore")

        do {
            let models = try context.fetch(fetchRequest)
            completionHandler(models, nil)
        } catch let err {
            completionHandler([], err)
        }
    }

    func delete(model: MachineOptionCore, _ completionHandler: ProgressComplete?) {
        let context = persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }
    }

    func deleteAllMachineOptionCores() {
        get { (coreModels: [MachineOptionCore], error) in
            if let _ = error {
                return
            }
            coreModels.forEach { (coreModel) in
                delete(model: coreModel, nil)
            }
        }
    }

}
