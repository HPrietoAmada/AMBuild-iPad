//
//  MachineTableViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class MachineCollectionViewController: UIViewController {
    
    var prospectCore: ProspectCore?

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        setupTable()
        collectionView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
        CoreDataManager.shared.get { (coreMachine: [MachineCore], e) in
            if let _ = e {
                return
            }
            guard let firstMachineCore = coreMachine.first else { return }
            /*
            DBManager.shared.create(model: MachineModel(firstMachineCore)) { (success, error) in
                print("Successfully reached api: \(success)")
                print("Reason: \(error?.localizedDescription)")
            }*/

            CoreDataManager.shared.get { (optionCores: [MachineOptionCore], e2) in
                if let _ = e2 {
                    return
                }
                let machineBuild = MachineBuildModel(machineCore: firstMachineCore, machineOptionCores: optionCores.filter({ $0.modelId == firstMachineCore.id }))
                DBManager.shared.create(model: machineBuild) { (response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }*/
        
        CoreDataManager.shared.get { (machineCores: [MachineCore], e1) in
            if let e1 = e1 {
                DispatchQueue.main.async {
                    self.presentMessage(title: "Error", message: e1.localizedDescription)
                }
                return
            }
            var machineBuilds: [MachineBuildModel] = [MachineBuildModel]()
            machineCores.forEach { (machineCore) in
                CoreDataManager.shared.get { (optionCores: [MachineOptionCore], e2) in
                    if let e2 = e2 {
                        DispatchQueue.main.async {
                            self.presentMessage(title: "Error", message: e2.localizedDescription)
                        }
                        return
                    }
                    let machineBuild = MachineBuildModel(machineCore: machineCore, machineOptionCores: optionCores.filter({ $0.modelId == machineCore.id }))
                    machineBuilds.append(machineBuild)
                    /*
                    DBManager.shared.create(model: machineBuild) { (response, error) in
                        if let error = error {
                            DispatchQueue.main.async {
                                self.presentMessage(title: "Error", message: error.localizedDescription)
                            }
                        }
                    }*/
                }
            }
            DBManager.shared.create(models: machineBuilds) { (buildModels, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        self.presentMessage(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }

    func presentMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func setup() {
        view.backgroundColor = UIColor.white

        view.addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "PriceToggle", style: .plain, target: self, action: #selector(handlePriceToggle))
        let cogImage: UIImage = UIImage(named: "cog")!
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: cogImage, style: .plain, target: self, action: #selector(handleShowSettings))

        let plus: UIImage = UIImage(named: "plus-item")!
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: plus, style: .plain, target: self, action: #selector(handleAddCustomer))
    }

    @objc func handleAddCustomer() {
        let controller = NavigationController(rootViewController: CustomerViewController())
        present(controller, animated: true, completion: nil)
    }

    @objc func handleShowSettings() {
        let cont = SettingsViewController()
        cont.delegate = self
        let controller = NavigationController(rootViewController: cont)
        present(controller, animated: true, completion: nil)
    }

    @objc func handlePriceToggle() {
        let controller = PriceToggleViewController()
        controller.delegate = self
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    @objc func handleShowCart() {
        let controller = ShoppingCartCollectionViewController()
        if let prospectCore = prospectCore {
            controller.prospectCore = prospectCore
        }
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}
