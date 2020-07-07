//
//  ViewDisplayCollectionView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/1/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

// Test Images "car1", "car3", "car5"

protocol ViewDisplayCollectionViewDelegate {
    func viewDisplayCollectionView(_ view: ViewDisplayCollectionView, imageSelected index: Int)
}

class ViewDisplayCollectionView: UIView {

    var delegate: ViewDisplayCollectionViewDelegate?

    private var viewHeightLayoutConstraint: NSLayoutConstraint?
    private var viewWidthLayoutConstraint: NSLayoutConstraint?

    private var collectionViewHeightLayoutConstraint: NSLayoutConstraint?

    var images: [String] = [String]() {
        didSet {
            collectionView.reloadData()
            if let imageName = images.first,
                let image = UIImage(named: imageName) {
                let imageView = UIImageView(image: image)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.tag = 2
                displayView.addSubview(imageView)
                imageView.widthAnchor.constraint(equalTo: displayView.widthAnchor).isActive = true
                imageView.heightAnchor.constraint(equalTo: displayView.heightAnchor).isActive = true
                imageView.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
                imageView.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
            }
        }
    }

    var image360s: [String] = [String]()

    var imageCellSize: CGSize = CGSize(width: 175, height: 125) {
        didSet {
            collectionViewHeightLayoutConstraint?.constant = imageCellSize.height
            collectionView.reloadData()
        }
    }

    var viewSize: CGSize = CGSize(width: 600, height: 450) {
        didSet {
            if let viewHeightLayoutConstraint = viewHeightLayoutConstraint {
                viewHeightLayoutConstraint.constant = viewSize.height
            }

            if let viewWidthLayoutConstraint = viewWidthLayoutConstraint {
                viewWidthLayoutConstraint.constant = viewSize.width
            }
        }
    }

    let displayView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        collectionView.alwaysBounceVertical = false

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
        setupCollectionView()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(displayView)
        addSubview(collectionView)

        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        collectionViewHeightLayoutConstraint = collectionView.heightAnchor.constraint(equalToConstant: imageCellSize.height)
        collectionViewHeightLayoutConstraint?.isActive = true

        displayView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        displayView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20).isActive = true
        displayView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        displayView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
