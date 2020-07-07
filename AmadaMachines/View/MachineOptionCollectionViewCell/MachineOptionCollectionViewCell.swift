//
//  MachineOptionCollectionViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 9/28/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol MachineOptionCollectionViewCellDelegate {
    func machineOptionCollectionViewCell(_ view: MachineOptionCollectionViewCell, optionRemove machineOption: MACHINE_OPTION, indexPath: IndexPath)
}

class MachineOptionCollectionViewCell: UICollectionViewCell {

    var delegate: MachineOptionCollectionViewCellDelegate?

    var indexPath: IndexPath = IndexPath(row: 0, section: 0)

    var machineOption: MACHINE_OPTION = MACHINE_OPTION() {
        didSet {
            titleLabel.text = machineOption.Option

            if let machineOptionImage = UIImage(named: machineOption.Option) {
                imageView.image = machineOptionImage
            }

            descriptionLabel.text = machineOption.OptionDesc
            priceLabel.text = machineOption.ListPrice.currencyFormatted()
        }
    }

    var machineOptionCore: MachineOptionCore? {
        didSet {
            guard let machineOptionCore = machineOptionCore else {
                return
            }
            if let name = machineOptionCore.option {
                titleLabel.text = name

                if let machineOptionImage = UIImage(named: name) {
                    imageView.image = machineOptionImage
                }
            }

            if let desc = machineOptionCore.optionDesc {
                descriptionLabel.text = desc
            }

            priceLabel.text = machineOptionCore.listPrice.currencyFormatted()
        }
    }

    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = UIColor.MainColors.red
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var deleteButton: UIButton = {
        let trashImage: UIImage = UIImage(named: "trash")!.withRenderingMode(.alwaysTemplate)
        let imageView = UIButton()
        imageView.tintColor = UIColor.lightGray
        imageView.setImage(trashImage, for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addTarget(self, action: #selector(handleDeleteImageViewClicked), for: .touchUpInside)
        return imageView
    }()

    @objc func handleDeleteImageViewClicked() {
        if let delegate = delegate {
            delegate.machineOptionCollectionViewCell(self, optionRemove: machineOption, indexPath: indexPath)
        }
    }

    let bottomBorder: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(deleteButton)
        addSubview(bottomBorder)

        let imageDims: CGFloat = 50
        imageView.heightAnchor.constraint(equalToConstant: imageDims).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageDims).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true

        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: deleteButton.leftAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomBorder.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true

        let deleteImageDims: CGFloat = 24
        deleteButton.widthAnchor.constraint(equalToConstant: deleteImageDims).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: deleteImageDims).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
