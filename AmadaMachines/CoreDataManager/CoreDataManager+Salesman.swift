//
//  CoreDataManager+Salesman.swift
//  AmadaMachines
//
//  Created by IT Support on 10/1/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias salesmanReturned = (SalesmanCore?, Error?) -> Void
typealias salesmansReturned = ([SalesmanCore], Error?) -> Void

extension CoreDataManager {

    func save(model: AS400_SALESMAN, _ completionHandler: salesmanReturned?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext

        let object = NSEntityDescription.insertNewObject(forEntityName: "SalesmanCore", into: context) as! SalesmanCore
        object.setValue(model.FirstName, forKey: "firstName")
        object.setValue(model.LastName, forKey: "lastName")
        object.setValue(model.Email, forKey: "email")
        object.setValue(model.SalesmanNumber, forKey: "salesmanNumber")
        do {
            try context.save()
            completionHandler?(object, nil)
        } catch let err {
            completionHandler?(nil, err)
        }
    }

    func get(_ completionHandler: salesmansReturned) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SalesmanCore>(entityName: "SalesmanCore")

        do {
            let models = try context.fetch(fetchRequest)
            completionHandler(models, nil)
        } catch let err {
            completionHandler([], err)
        }
    }

    func getStoredSalesman() -> SalesmanCore? {
        var salesman: SalesmanCore?
        CoreDataManager.shared.get { (coreModels: [SalesmanCore], error) in
            if let _ = error {
                return
            }
            if let firstSalesman = coreModels.first {
                salesman = firstSalesman
            }
        }
        return salesman
    }

    func delete(model: SalesmanCore, _ completionHandler: ProgressComplete?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }
    }

    func deleteAllSalesmanCores() {
        get { (coreModels: [SalesmanCore], error) in
            if let _ = error {
                return
            }
            coreModels.forEach { (coreModel) in
                delete(model: coreModel, nil)
            }
        }
    }

}
