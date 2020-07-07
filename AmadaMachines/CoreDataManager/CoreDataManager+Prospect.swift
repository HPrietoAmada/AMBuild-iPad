//
//  CoreDataManager+Prospect.swift
//  AmadaMachines
//
//  Created by IT Support on 9/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias prospectReturned = (ProspectCore?, Error?) -> Void
typealias prospectsReturned = ([ProspectCore], Error?) -> Void

extension CoreDataManager {

    func save(model: Prospect, _ completionHandler: prospectReturned?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext

        let object = NSEntityDescription.insertNewObject(forEntityName: "ProspectCore", into: context) as! ProspectCore
        object.setValue(model.salesnumber, forKey: "salesnumber")
        object.setValue(model.companyName, forKey: "companyName")
        object.setValue(model.email, forKey: "email")
        object.setValue(model.phoneNumber, forKey: "phoneNumber")
        object.setValue(model.qrCode, forKey: "qrCode")
        object.setValue(model.notes, forKey: "notes")
        object.setValue(model.createdDate, forKey: "createdDate")
        var prospectID: Int32 = 1
        get { (prospects: [ProspectCore], error) in
            if let _ = error {
                return
            }
            if let lastProspect = prospects.sorted(by: { $0.id < $1.id }).last {
                prospectID = lastProspect.id + 1
            }
        }

        object.setValue(prospectID, forKey: "id")
        
        do {
            try context.save()
            completionHandler?(object, nil)
        } catch let err {
            completionHandler?(nil, err)
        }
    }

    func get(_ completionHandler: prospectsReturned) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ProspectCore>(entityName: "ProspectCore")

        do {
            let models = try context.fetch(fetchRequest)
            completionHandler(models, nil)
        } catch let err {
            completionHandler([], err)
        }
    }

    func delete(model: ProspectCore, _ completionHandler: ProgressComplete?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }
    }

    func deleteAllProspectCores() {
        get { (coreModels: [ProspectCore], error) in
            if let _ = error {
                return
            }
            coreModels.forEach { (coreModel) in
                delete(model: coreModel, nil)
            }
        }
    }

    func update(model: ProspectCore, _ completionHandler: ProgressComplete?) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<ProspectCore>(entityName: "ProspectCore")
        do {
            let coreModels = try context.fetch(request)
            guard let coreModel = coreModels.first(where: { $0.id == model.id }) else {
                completionHandler?(false, nil)
                return
            }
            coreModel.setValue(model.companyName, forKey: "companyName")
            coreModel.setValue(model.email, forKey: "email")
            coreModel.setValue(model.notes, forKey: "notes")
            coreModel.setValue(model.phoneNumber, forKey: "phoneNumber")
            coreModel.setValue(model.qrCode, forKey: "qrCode")
            coreModel.setValue(model.salesnumber, forKey: "salesnumber")
            coreModel.setValue(model.createdDate, forKey: "createdDate")
            try context.save()
            completionHandler?(true, nil)
        } catch let err {
            completionHandler?(false, err)
        }
    }

}
