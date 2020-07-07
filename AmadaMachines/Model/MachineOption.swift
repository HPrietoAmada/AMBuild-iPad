//
//  MachineOption.swift
//  AmadaMachines
//
//  Created by IT Support on 9/25/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class MachineOptionModel: Codable {
    public var createdDate: String?
    public var id: Int = 0
    public var listPrice: Double = 0
    public var model: String?
    public var modelId: Int = 0
    public var option: String?
    public var optionDesc: String?

    init(_ coreModel: MachineOptionCore) {
        self.createdDate = coreModel.createdDate?.toDateTime()
        self.id = Int(coreModel.id)
        self.listPrice = coreModel.listPrice
        self.model = coreModel.model
        self.modelId = Int(coreModel.modelId)
        self.option = coreModel.option
        self.optionDesc = coreModel.optionDesc
    }
}

class MACHINE_OPTION: Codable {
    public var MachineType: String = ""
    public var Model: String = ""
    public var Option: String = ""
    public var OptionDesc: String = ""
    public var ListPrice: Double = 0.0
    public var ImageName: String = ""
    public var CreatedDate: Date = Date()

    init() {
    }

    init(machineType: String, model: String, option: String, optionDesc: String, listPrice: Double) {
        MachineType = machineType
        Model = model
        Option = option
        OptionDesc = optionDesc
        ListPrice = listPrice
        ImageName = ""
    }

    func getMachineOptions() -> [MACHINE_OPTION] {
        return [
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00001",optionDesc:"AUTO CROWNING",listPrice:7000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00002",optionDesc:"L-SHIFT BACKGAUGE",listPrice:10000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00003",optionDesc:"AGRIP-M",listPrice:635.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00004",optionDesc:"AGRIP-A",listPrice:995.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00005",optionDesc:"BL-S",listPrice:26500),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00006",optionDesc:"ROBOT INTERFACE",listPrice:1200.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00007",optionDesc:"MANUAL SLIDE FOOT PEDAL",listPrice:3800.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00008",optionDesc:"AUTO SLIDE FOOT PEDAL",listPrice:7600.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00009",optionDesc:"FRONT MATERIAL SUPPORT",listPrice:8000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00010",optionDesc:"DIGI-PRO",listPrice:1500.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00011",optionDesc:"DIGI NOGI",listPrice:1200.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00012",optionDesc:"STATIONARY FINGER",listPrice:1200.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00013",optionDesc:"DOUBLE CLAMP FINGER",listPrice:2000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00014",optionDesc:"2ND OPERATOR FOOT PEDAL",listPrice:3900.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003",option:"HRB00015",optionDesc:"SF1224TL SHEET FOLLOWER",listPrice:68000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00001",optionDesc:"AUTO CROWNING",listPrice:700.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00002",optionDesc:"L-SHIFT BACKGAUGE",listPrice:10000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00003",optionDesc:"AGRIP-M",listPrice:635.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00004",optionDesc:"AGRIP-A",listPrice:995.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00005",optionDesc:"BL-S",listPrice:26500.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00006",optionDesc:"ROBOT INTERFACE",listPrice:1200.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00007",optionDesc:"MANUAL SLIDE FOOT PEDAL",listPrice:3800.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00008",optionDesc:"AUTO SLIDE FOOT PEDAL",listPrice:7600.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00009",optionDesc:"FRONT MATERIAL SUPPORT",listPrice:8000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00010",optionDesc:"DIGI-PRO",listPrice:1500.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00011",optionDesc:"DIGI NOGI",listPrice:1200.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00012",optionDesc:"STATIONARY FINGER",listPrice:1200.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00013",optionDesc:"DOUBLE CLAMP FINGER",listPrice:2000.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00014",optionDesc:"2ND OPERATOR FOOT PEDAL",listPrice:3900.00),
            MACHINE_OPTION(machineType: "Machine Options", model:"HRB1003ATC",option:"HRB00015",optionDesc:"SF1224TL SHEET FOLLOWER",listPrice:68000.00),

            // Software Options
            MACHINE_OPTION(machineType: "Software", model: "HRB1003", option: "VPSS3IBEND", optionDesc: "Increase Bending Machine Runtime", listPrice: 11300.00),
            MACHINE_OPTION(machineType: "Software", model: "HRB1003ATC", option: "VPSS3IBEND", optionDesc: "Increase Bending Machine Runtime", listPrice: 11300.00),

            // Tooling
            MACHINE_OPTION(machineType: "Tooling", model: "HRB1003", option: "TOOLING-CONTRACT", optionDesc: "Tooling Contract for HRB1003", listPrice: 30000.00),
            MACHINE_OPTION(machineType: "Tooling", model: "HRB1003ATC", option: "TOOLING-CONTRACT", optionDesc: "Tooling Contract for HRB1003ATC", listPrice: 30000.00),

            // Service
            MACHINE_OPTION(machineType: "Service", model: "HRB1003", option: "25622003", optionDesc: "Service Contract for HRB1003", listPrice: 6600.00),
            /*
            MACHINE_OPTION(machineType: "Service", model: "HRB1003", option: "25622004", optionDesc: "3rd Year AMP Service Contract for HRB1003 (Years 2 and 3)", listPrice: 13200.00),
            MACHINE_OPTION(machineType: "Service", model: "HRB1003", option: "25622005", optionDesc: "4th Year AMP Service Contract for HRB1003 (Years 2, 3, 4)", listPrice: 19800.00),
            MACHINE_OPTION(machineType: "Service", model: "HRB1003", option: "25622006", optionDesc: "5th Year AMP Service Contract for HRB1003", listPrice: 26400.00),
             */


            MACHINE_OPTION(machineType: "Service", model: "HRB1003ATC", option: "25622003", optionDesc: "AMP Service Contract for HRB1003", listPrice: 6600.00),
            /*
            MACHINE_OPTION(machineType: "Service", model: "HRB1003ATC", option: "25622004", optionDesc: "3rd Year AMP Service Contract for HRB1003", listPrice: 13200.00),
            MACHINE_OPTION(machineType: "Service", model: "HRB1003ATC", option: "25622005", optionDesc: "4th Year AMP Service Contract for HRB1003", listPrice: 19800.00),
            MACHINE_OPTION(machineType: "Service", model: "HRB1003ATC", option: "25622006", optionDesc: "5th Year AMP Service Contract for HRB1003", listPrice: 26400.00),
             */
        ]
    }
}

class MACHINE_OPTION_BULLET_DESCRIPTION {
    public var Option: String = ""
    public var Description: String = ""

    init() {}

    init(Option: String, Description: String) {
        self.Option = Option
        self.Description = Description
    }

    func getMachineOptionBulletDescrptionList() -> [MACHINE_OPTION_BULLET_DESCRIPTION] {
        return [
            // AUTO CROWNING
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00001",
                Description: "Crowning Device – Adjustable crowning device ensures consistent bend angles across different material types."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00001",
                Description: "Natural Crowning ability built into the design of the machine insures consistent bend angles along the entire bend length."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00001",
                Description: "Auto Crowning Device increase longitudinal accuracy over natural crown."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00001",
                Description: "Auto Crowning is beneficial when bneding mutliple material types."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00001",
                Description: ""
            ),

            // L-SHIFT BACKGAUGE
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00002",
                Description: "6-Axis Back-gauge with L-shift handles parts small to large with multiple geometries representing a wide range of industries."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00002",
                Description: "L axes shift  -100 mm to +200 mm"
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00002",
                Description: "Speeds setup for complex parts while ensuring repeatable accuracy"
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00002",
                Description: "Provides a more stable gauging platform helping to eliminate processing errors."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00002",
                Description: ""
            ),

            // AGRIP-M
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00003",
                Description: "AGRIP series supports Grooved Tapered Punch which prevents falling. Tool setup can be performed on Amada press brake machine quickly and efficiently.  Manual grip"
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00003",
                Description: "Punch/GRIP Fall Protection -Dedicated plate prevents GRIP from slipping out so that the tool set-up and GRIP position change can be made safely and efficiently"
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00003",
                Description: "Front-Loading/Front-Unloading of Punch-Punch (12.5kg or less) can be unloaded from the front."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00003",
                Description: "Auto Punch Pull-Up -Punch pulled up to clamp face."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00003",
                Description: "Return Bend Area Securing -Front rear clamp plate can be removed as needed."
            ),

            // AGRIP-A
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00004",
                Description: "AGRIP series supports Grooved Tapered Punch which prevents falling. Tool setup can be performed on Amada press brake machine quickly and efficiently.  Hydraulic grip"
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00004",
                Description: "Punch/GRIP Fall Protection -Dedicated plate prevents GRIP from slipping out so that the tool set-up and GRIP position change can be made safely and efficiently"
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00004",
                Description: "GRIP Connection -GRIP can be connected without gap."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00004",
                Description: ""
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00004",
                Description: ""
            ),

            // BL-S
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00005",
                Description: "Probe-Style, On-The-Fly angle measuring and correcting device."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00005",
                Description: "Guarantees the correct angle within +/- a quarter degree on the forst bend."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00005",
                Description: "Greatly reduces setup time due to test bending and manual angle correction."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00005",
                Description: "Eliminates the need for extra 'setup pieces' or test coupons."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00005",
                Description: "Programmable device can automatically engage and retract out of the way when finished."
            ),

            // ROBOT INTERFACE
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00006",
                Description: "Interface Board providing signals for robotic bending integration."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00006",
                Description: "Easily installed device."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00006",
                Description: "Provides signals required by most robot integrations."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00006",
                Description: ""
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00006",
                Description: ""
            ),

            // MANUAL SLIDE FOOT PEDAL
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00007",
                Description: "Manual Sliding foot-pedal moved on a rail by the operator to any position needed."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00007",
                Description: "Easily accessible by the operators foot for movement and action."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00007",
                Description: "Easily upgraded to fully automatic if desired."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00007",
                Description: ""
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00007",
                Description: ""
            ),

            // AUTO SLIDE FOOT PEDAL
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00008",
                Description: "Programmable Sliding foot pedal moves to the bending position automatically in the bending sequence."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00008",
                Description: "Can be programmmed offline."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00008",
                Description: "Speeds up processing as operator does not have to dragg a cabled footpedal along when stage bending."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00008",
                Description: "Operator can keep both hands on the part when moving between bends."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00008",
                Description: "Foot pedal position is easily adjusted during processing at the machine."
            ),

            // FRONT MATERIAL SUPPORT
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00009",
                Description: "Adjustable front support system to support parts during bending."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00009",
                Description: "Track style system is easily adjustable to process a wide range of parts."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00009",
                Description: "Quick and easy to install."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00009",
                Description: "Robust, handling up to 50 KG's per arm."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00009",
                Description: ""
            ),

            // DIGI-PRO
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00010",
                Description: "Digital protector interfaced with the AMNC-3i control by infrared receiver."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00010",
                Description: "Operator can measure and send anagle corrections to the machine with the push of a button."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00010",
                Description: "Eliminates angle correction errors by manual data entry."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00010",
                Description: "Precision intrument that is easily zeroed and calibrated."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00010",
                Description: "Infrared type signal is not subject to shop interference and multiple units can operate nearby without interference."
            ),

            // DIGI-NOGI
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00011",
                Description: "Digital Calipers interfaced with the AMNC-3i control by infrared."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00011",
                Description: "Can be used for flange adjustment or material thickness adjustment."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00011",
                Description: "Changes are automatically made by the push of a button."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00011",
                Description: "Eliminated flange or material adjustment errors by manual data entry."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00011",
                Description: "Requires purchased of Digi-pro or seperate infrared receiver kit."
            ),

            // STATIONARY FINGER
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00012",
                Description: "Manually mounted stationary finger assembly."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00012",
                Description: "Used when a third gauging point is necessarry for accurate part processing."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00012",
                Description: "Easily attached and removed without tools."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00012",
                Description: ""
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00012",
                Description: ""
            ),

            // DOUBLE CLAMP FINGER
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00013",
                Description: "Multi-gauging point bacgauge finger."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00013",
                Description: "Installed easily without tools like all other backgauge fingers."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00013",
                Description: "Allows stable gauging of complex part geomtries."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00013",
                Description: "Can be used in conjuction with L-Shift backgauge to increase taper bending amount."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00013",
                Description: ""
            ),

            // 2ND OPERATOR FOOT PEDAL
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00014",
                Description: "Secondary cabled foot pedal."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00014",
                Description: "Can be used in 2 operator mode for safe bending of parts requiring 2 operators."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00014",
                Description: "Can be programmed to be used on specific bends in a program in conjuction with the primary foot pedal."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00014",
                Description: "It as a fully function 3 position foot-pedal with built-in emergency stop by extended depression of the pedal."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00014",
                Description: ""
            ),

            // SF1224TL SHEET FOLLOWER
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00015",
                Description: "Sheet following device utilizing 2 support arms."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00015",
                Description: "Eliminates the need for 2 operators when bending larger parts."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00015",
                Description: "Handles parts up to 220 lbs and 4' x 8' in size."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00015",
                Description: "Sensored sheet following action does not require any programming by the operator for use."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "HRB00015",
                Description: "Includes right hand parking station so arms can be moved out of the way when not needede."
            ),

            // SOFTWARE
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "VPSS3IBEND",
                Description: "Every aspect of VPSS3i Bend has been enhanced to offer more functionality than ever before. Accurately rendered by a new simulation engine, VPSS3i Bend’s enhanced collision check now supports forming and hardware inserts for visual collision checks."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "VPSS3IBEND",
                Description: "VPSS3i BEND maximizes bending productivity and efficiency by automatically generating offline press brake programs, verifying the part feasibility and generating common tool setups to bend multiple parts."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "VPSS3IBEND-5",
                Description: "Every aspect of VPSS3i Bend has been enhanced to offer more functionality than ever before. Accurately rendered by a new simulation engine, VPSS3i Bend’s enhanced collision check now supports forming and hardware inserts for visual collision checks."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "VPSS3IBEND-5",
                Description: "VPSS3i BEND maximizes bending productivity and efficiency by automatically generating offline press brake programs, verifying the part feasibility and generating common tool setups to bend multiple parts."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622003",
                Description: "Insures machine operation at peak performance."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622003",
                Description: "Covers cost for service calls related to the covered machine."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622003",
                Description: "Provides minimum machine downtime and production delays."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622003",
                Description: "The combination of an AMADA Maintenance Plan and a discount on parts used in the repair of covered equipment can give you the competitive edge gained by well-maintained equipment."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622005",
                Description: "Insures machine operation at peak performance."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622005",
                Description: "Covers cost for service calls related to the covered machine."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622005",
                Description: "Provides minimum machine downtime and production delays."
            ),
            MACHINE_OPTION_BULLET_DESCRIPTION(
                Option: "25622005",
                Description: "The combination of an AMADA Maintenance Plan and a discount on parts used in the repair of covered equipment can give you the competitive edge gained by well-maintained equipment."
            ),
        ]
    }
}

/*


 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00001",optionDesc:"AUTO CROWNING",listPrice:10000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00002",optionDesc:"L-SHIFT BACKGAUGE",listPrice:10100.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00003",optionDesc:"AGRIP-M",listPrice:10200.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00004",optionDesc:"AGRIP-A",listPrice:10300.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00005",optionDesc:"BL-S",listPrice:10400.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00006",optionDesc:"ROBOT INTERFACE",listPrice:10500.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00007",optionDesc:"MANUAL SLIDE FOOT PEDAL",listPrice:10600.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00008",optionDesc:"AUTO SLIDE FOOT PEDAL",listPrice:10700.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00009",optionDesc:"FRONT MATERIAL SUPPORT",listPrice:10800.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00010",optionDesc:"DIGI-PRO",listPrice:10900.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00011",optionDesc:"DIGI NOGI",listPrice:11000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00012",optionDesc:"STATIONARY FINGER",listPrice:12000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00013",optionDesc:"DOUBLE CLAMP FINGER",listPrice:13000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00014",optionDesc:"2ND OPERATOR FOOT PEDAL",listPrice:14000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303",option:"HRB00015",optionDesc:"SF1224TL SHEET FOLLOWER",listPrice:15000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00001",optionDesc:"AUTO CROWNING",listPrice:10000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00002",optionDesc:"L-SHIFT BACKGAUGE",listPrice:10100.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00003",optionDesc:"AGRIP-M",listPrice:10200.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00004",optionDesc:"AGRIP-A",listPrice:10300.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00005",optionDesc:"BL-S",listPrice:10400.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00006",optionDesc:"ROBOT INTERFACE",listPrice:10500.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00007",optionDesc:"MANUAL SLIDE FOOT PEDAL",listPrice:10600.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00008",optionDesc:"AUTO SLIDE FOOT PEDAL",listPrice:10700.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00009",optionDesc:"FRONT MATERIAL SUPPORT",listPrice:10800.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00010",optionDesc:"DIGI-PRO",listPrice:10900.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00011",optionDesc:"DIGI NOGI",listPrice:11000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00012",optionDesc:"STATIONARY FINGER",listPrice:12000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00013",optionDesc:"DOUBLE CLAMP FINGER",listPrice:13000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00014",optionDesc:"2ND OPERATOR FOOT PEDAL",listPrice:14000.00),
 MACHINE_OPTION(machineType: "Machine Options", model:"HRB1303ATC",option:"HRB00015",optionDesc:"SF1224TL SHEET FOLLOWER",listPrice:15000.00),

 */
