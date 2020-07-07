//
//  DBManager.swift
//  AmadaMachines
//
//  Created by IT Support on 11/11/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import CoreData

typealias templateReturned = (Encodable?, Error?) -> Void

struct DBManager {
    let loginPath: String = "https://fieldapp.amada.com/api/account/"
    let apiPath: String = "https://fieldappdev.amada.com/ExpenseReportAPI/api/expense/"
    static let shared = DBManager()
}
