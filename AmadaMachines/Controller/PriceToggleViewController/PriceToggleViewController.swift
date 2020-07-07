//
//  PriceToggleViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 10/2/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol PriceToggleViewControllerDelegate {
    func pricetoggleViewController(_ controller: PriceToggleViewController, switchToggled priceToggle: PriceToggle)
}

class PriceToggleViewController: UIViewController {

    var delegate: PriceToggleViewControllerDelegate?

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

        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"close")!, style: .plain, target: self, action: #selector(handleClose))
    }

    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
}
