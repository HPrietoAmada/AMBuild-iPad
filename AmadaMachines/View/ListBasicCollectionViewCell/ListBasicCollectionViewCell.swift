//
//  ListBasicCollectionViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 9/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ListBasicCollectionViewCell: UICollectionViewCell {

    var descText: String = "" {
        didSet {
            descriptionLabel.text = descText
        }
    }

    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }

    /*
    var descriptionText: String = "" {
        didSet {
            descriptionTextView.text = descriptionText
        }
    }
     */

    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    var index: Int = 0 {
        didSet {
            indexLabel.text = "\(index)"
        }
    }

    let indexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        label.textColor = .white
        label.backgroundColor = UIColor.MainColors.mainColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    /*
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 14)
        textView.textColor = .black
        textView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = false
        return textView
    }()
     */

    let bottomBorder: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        //addSubview(listLabel)
        addSubview(indexLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(imageView)
        addSubview(bottomBorder)

        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        indexLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        indexLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: indexLabel.rightAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: indexLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
