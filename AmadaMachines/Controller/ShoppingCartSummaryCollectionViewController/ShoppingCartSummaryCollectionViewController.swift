//
//  ShoppingCartSummaryCollectionViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 9/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol ShoppingCartSummaryCollectionViewControllerDelegate {
    func shoppingCartSummaryCollectionViewController(_ controller: ShoppingCartSummaryCollectionViewController, controllerClosed machine: MachineCore, machineOptions: [MachineOptionCore])
    func shoppingCartSummaryCollectionViewController(_ controller: ShoppingCartSummaryCollectionViewController, machineOptionRemoved machine: MachineCore, machineOptions: [MachineOptionCore])
    func shoppingCartSummaryCollectionViewController(_ controller: ShoppingCartSummaryCollectionViewController, addToCart machine: MachineCore, machineOptions: [MachineOptionCore])
}

class ShoppingCartSummaryCollectionViewController: UIViewController {

    var delegate: ShoppingCartSummaryCollectionViewControllerDelegate?

    var machine: MachineCore = MachineCore() {
        didSet {
            collectionView.reloadData()

            CoreDataManager.shared.get { (machineOptionCores: [MachineOptionCore], error) in
                if let _ = error {
                    return
                }
                self.machineOptions = machineOptionCores.filter({ $0.modelId == machine.id })
            }
        }
    }

    var machineOptions : [MachineOptionCore] = [MachineOptionCore]() {
        didSet {
            collectionView.reloadData()
        }
    }

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
    }

    func setup() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleClose))
    }

    @objc func handleClose() {
        if let delegate = delegate {
            delegate.shoppingCartSummaryCollectionViewController(self, controllerClosed: machine, machineOptions: machineOptions)
        }
        dismiss(animated: true, completion: nil)
    }
}
