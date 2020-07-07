//
//  MachineCoreSummaryViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 11/4/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol MachineCoreSummaryCollectionViewControllerDelegate {
    func machineCoreSummaryCollectionViewController(_ controller: MachineCoreSummaryCollectionViewController, controllerClosed machine: MachineCore, machineOptions: [MachineOptionCore])
    func machineCoreSummaryCollectionViewController(_ controller: MachineCoreSummaryCollectionViewController, machineOptionRemoved machine: MachineCore, machineOptions: [MachineOptionCore])
    func machineCoreSummaryCollectionViewController(_ controller: MachineCoreSummaryCollectionViewController, addToCart machine: MachineCore, machineOptions: [MachineOptionCore])
}

class MachineCoreSummaryCollectionViewController: UIViewController {

    var delegate: MachineCoreSummaryCollectionViewControllerDelegate?
    
    var machine: MachineCore = MachineCore() {
        didSet {
            collectionView.reloadData()
            subtotalLabel.text = subtotal().currencyFormatted()
        }
    }

    var machineOptions : [MachineOptionCore] = [MachineOptionCore]() {
        didSet {
            collectionView.reloadData()
            subtotalLabel.text = subtotal().currencyFormatted()
        }
    }

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()

    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
        label.text = "Total: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
        label.textColor = UIColor.MainColors.red
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let addButton: Button = {
        let button = Button("Update Proposal")
        return button
    }()

    let totalBorder: BorderView = {
        return BorderView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        setupCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setup() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(totalLabel)
        view.addSubview(subtotalLabel)
        view.addSubview(addButton)
        view.addSubview(totalBorder)

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.width = view.bounds.width - 40

        totalLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -10).isActive = true
        totalLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        totalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        subtotalLabel.topAnchor.constraint(equalTo: totalLabel.topAnchor).isActive = true
        subtotalLabel.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subtotalLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        subtotalLabel.heightAnchor.constraint(equalTo: totalLabel.heightAnchor).isActive = true

        totalBorder.bottomAnchor.constraint(equalTo: totalLabel.topAnchor, constant: -10).isActive = true
        totalBorder.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        totalBorder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        collectionView.bottomAnchor.constraint(equalTo: totalBorder.topAnchor).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleClose))
    }

    @objc func handleClose() {
        if let delegate = delegate {
            delegate.machineCoreSummaryCollectionViewController(self, controllerClosed: machine, machineOptions: machineOptions)
        }
        dismiss(animated: true, completion: nil)
    }
}
