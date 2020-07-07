//
//  ImageViewCollectionViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 10/15/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ImageViewCollectionViewCell: UICollectionViewCell {

    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    var imageBackgroundColor: UIColor = UIColor.white {
        didSet {
            imageView.backgroundColor = imageBackgroundColor
        }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(imageView)

        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -40).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
