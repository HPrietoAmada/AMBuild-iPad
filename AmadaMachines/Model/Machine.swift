//
//  Machine+Extension.swift
//  AmadaMachines
//
//  Created by IT Support on 9/25/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ProspectModel: Codable {
    public var CompanyName: String?
    public var Email: String?
    public var id: Int = 0
    public var Notes: String?
    public var PhoneNumber: String?
    public var qrCode: String?
    public var salesnumber: Int = 0

    init(_ coreModel: ProspectCore) {
        self.CompanyName = coreModel.companyName
        self.Email = coreModel.email
        self.id = Int(coreModel.id)
        self.Notes = coreModel.notes
        self.PhoneNumber = coreModel.phoneNumber
        self.qrCode = coreModel.qrCode
        self.salesnumber = Int(coreModel.salesnumber)
    }
}

class MachineModel: Codable {
    public var createdDate: String?
    public var id: Int = 0
    public var listPrice: Double = 0
    public var model: String?
    public var modelDesc: String?
    public var prospectId: Int = 0

    init(_ coreModel: MachineCore) {
        self.createdDate = coreModel.createdDate?.toDateTime()
        self.id = Int(coreModel.id)
        self.listPrice = coreModel.listPrice
        self.model = coreModel.model
        self.modelDesc = coreModel.modelDesc
        self.prospectId = Int(coreModel.prospectId)
    }
}

class MACHINE {
    public var model: String = ""
    public var modelDesc: String = ""
    public var listPrice: Double = 0.0
    public var description: String = ""
    public var createdDate: Date = Date()

    init() {
    }

    init(Model: String, ModelDesc: String, ListPrice: Double, Description: String) {
        self.model = Model
        self.modelDesc = ModelDesc
        self.listPrice = ListPrice
        self.description = Description
    }

    init(coreModel: MachineCore) {

    }

    func getMachines() -> [MACHINE] {
        return [
            MACHINE(
                Model: "HRB1003",
                ModelDesc: "Hydraulic Retrofitable Bender",
                ListPrice: 125000.00,
                Description: "H: Hybrid Drive Hydraulic R: Retrofittable B: Bender \nA hydrualic-powered press brake designed for efficient, accurate and repeatable bending \nwith an exceptional price-performance ration"
            ),
            MACHINE(
                Model: "HRB1003ATC",
                ModelDesc: "Hydraulic Retrofitable Bender ATC",
                ListPrice: 295000.00,
                Description: "The HRB’s ATC design combines the flexibility and capability of the base machine with the fast and precise tool change capabilities of an automated bending system. Perfect for complex tool layouts and when multiple setups per shift are needed."
            ),
            /*
            MACHINE(Model:"HRB1003",ModelDesc:"Hydraulic Retrofitable Bender",ListPrice:200000.00),
            MACHINE(Model:"HRB1003ATC",ModelDesc:"Hydraulic Retrofitable Bender ATC",ListPrice:250000.00),
            MACHINE(Model:"HRB1303",ModelDesc:"Hydraulic Retrofitable Bender",ListPrice:300000.00),
            MACHINE(Model:"HRB1303ATC",ModelDesc:"Hydraulic Retrofitable Bender ATC",ListPrice:350000.00)
            */
        ]
    }
}

class MACHINE_BULLET_DESCRIPTION {
    public var Model: String = ""
    public var Description: String = ""

    init(Model: String, Description: String) {
        self.Model = Model
        self.Description = Description
    }

    init() {}

    func getDescriptions() -> [MACHINE_BULLET_DESCRIPTION] {
        return [
            // HRB1003 START
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003",
                Description: "The HRB’s flexible design allows you to purchase a base machine and add retrofittable, production enhancing technology to meet your changing bending requirements."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003",
                Description: "AMNC3i intelligent control handles many of the intellectual components of the press brake programming process, requiring a less skilled operator."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003",
                Description: "Tool-Navi- interactive tool setup function utilizes AMNC3i and Back-gauge to guides operators on tool placement shortening setup time."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003",
                Description: "6-Axis Back-gauge handles parts small to large with multiple geometries representing a wide range of industries."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003",
                Description: "Natural Crowning ability built into the design of the machine insures consistent bend angles along the entire bend length."
            ),
              // HRB1003 END
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003ATC",
                Description: "ATC – Automatic Tool Changing device utilizing Amada’s new AFH-ATC Ready tooling, further reducing setup times and operator skill level."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003ATC",
                Description: "AMNC3i intelligent control handles many of the intellectual components of the press brake programming process, requiring a less skilled operator."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003ATC",
                Description: "Tool-Navi- interactive tool setup function utilizes AMNC3i and Back-gauge to guides operators on tool placement shortening setup time."
            ),
            MACHINE_BULLET_DESCRIPTION(
                Model: "HRB1003ATC",
                Description: "Auto-Slide Foot Pedal – Sliding foot pedal advances with operator through tool stations reducing processing times when stage bending."
            )
        ]
    }
}
