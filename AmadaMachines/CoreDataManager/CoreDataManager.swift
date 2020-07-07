//
//  CoreDataManager.swift
//  AmadaMachines
//
//  Created by IT Support on 9/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias ProgressComplete = (_ success: Bool, _ error: Error?) -> Void

struct CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AmadaMachines")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
}
