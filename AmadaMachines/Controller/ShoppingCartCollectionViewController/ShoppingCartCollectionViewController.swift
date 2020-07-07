//
//  ShoppingCartCollectionViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 9/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ShoppingCartCollectionViewController: UIViewController {

    var prospectCore: ProspectCore?

    var prospects: [ProspectCore] = [ProspectCore]() {
        didSet {
            collectionView.reloadData()
            collapse = Array(repeating: true, count: prospects.count)
        }
    }

    var collapse: [Bool] = [Bool]()

    var coreModels: [MachineCore] = [MachineCore]()

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        setupTable()

        if let _ = prospectCore {
            setProspectMachineCores()
        } else {
            setProspects()
            setAllMachineCores()
        }
    }

    private func setProspects() {
        CoreDataManager.shared.get { (coreModels: [ProspectCore], error) in
            if let _ = error {
                return
            }
            self.prospects = coreModels
        }
    }

    private func setProspectMachineCores() {
        CoreDataManager.shared.get { (machineCores: [MachineCore], error) in
            if let _ = error {
                return
            }
            if let prospect = prospectCore {
                self.coreModels = machineCores.filter({ $0.prospectId == prospect.id })
            } else {
                self.coreModels = machineCores
            }
            self.collectionView.reloadData()
        }
    }

    private func setAllMachineCores() {
        CoreDataManager.shared.get { (coreModels: [MachineCore], error) in
            if let _ = error {
                return
            }
            self.coreModels = coreModels
        }
    }

    func setup() {
        view.backgroundColor = UIColor.white

        view.addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleCancel))
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}
