//
//  CoreDataManager+PriceToggle.swift
//  AmadaMachines
//
//  Created by IT Support on 10/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias priceToggleReturned = (PriceToggleCore?, Error?) -> Void
typealias priceTogglesReturned = ([PriceToggleCore], Error?) -> Void

extension CoreDataManager {

    func save(model: PriceToggle, _ completionHandler: priceToggleReturned?) {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: "PriceToggleCore", into: context) as! PriceToggleCore
        object.setValue(model.id, forKey: "id")
        object.setValue(model.controller, forKey: "controller")
        object.setValue(model.show, forKey: "show")
        object.setValue(model.view, forKey: "view")
        object.setValue(model.description, forKey: "desc")

        do {
            try context.save()
            completionHandler?(object, nil)
        } catch let err {
            completionHandler?(nil, err)
        }

    }

    func get(_ completionHandler: priceTogglesReturned) {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PriceToggleCore>(entityName: "PriceToggleCore")
        do {
            let models = try context.fetch(fetchRequest)
            completionHandler(models, nil)
        } catch let err {
            completionHandler([], err)
        }

    }

    func delete(model: PriceToggleCore, _ completionHandler: ProgressComplete?) {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }

    }

    func update(model: PriceToggleCore, _ completionHandler: ProgressComplete?) {

        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<PriceToggleCore>(entityName: "PriceToggleCore")
        do {
            let coreModels = try context.fetch(request)
            guard let coreModel = coreModels.first(where: { $0.id == model.id }) else {
                completionHandler?(false, nil)
                return
            }
            coreModel.setValue(model.id, forKey: "id")
            coreModel.setValue(model.controller, forKey: "controller")
            coreModel.setValue(model.show, forKey: "show")
            coreModel.setValue(model.view, forKey: "view")
            coreModel.setValue(model.description, forKey: "desc")
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }

    }

    func deleteAllPriceToggleCores() {

        get { (coreModels: [PriceToggleCore], error) in
            if let _ = error {
                return
            }
            coreModels.forEach { (coreModel) in
                delete(model: coreModel, nil)
            }
        }

    }

}
