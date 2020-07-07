//
//  MachineCollectionViewHeaderCell.swift
//  AmadaMachines
//
//  Created by IT Support on 9/6/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol MachineCollectionViewHeaderCellDelegate {
    func machineCollectionViewHeaderCell(_ header: MachineCollectionViewHeaderCell, saveButtonClicked machine: MACHINE)
}

class MachineCollectionViewHeaderCell: UICollectionReusableView {

    var delegate: MachineCollectionViewHeaderCellDelegate?

    var machine: MACHINE = MACHINE() {
        didSet {
            nameLabel.text = machine.model
            descriptionLabel.text = machine.modelDesc
            listPriceLabel.text = machine.listPrice.currencyFormatted()
            if let modelImage = UIImage(named: "\(machine.model)_01") {
                imageView.image = modelImage
            }
        }
    }

    var machineCore: MachineCore? {
        didSet {
            guard let machineCore = machineCore else {
                return
            }
            if let machineName = machineCore.model {
                nameLabel.text = machineName
                if let modelImage = UIImage(named: "\(machineName)_01") {
                    imageView.image = modelImage
                }
            }
            if let machineDesc = machineCore.modelDesc {
                descriptionLabel.text = machineDesc
            }
            listPriceLabel.text = machineCore.listPrice.currencyFormatted()
        }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.placeholder.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "HM 1003"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let listPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.MainColors.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtotalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let saveButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        button.backgroundColor = UIColor.MainColors.lightColor
        button.titleLabel?.textColor = .white
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func handleSaveButtonClick() {
        if let delegate = delegate {
            delegate.machineCollectionViewHeaderCell(self, saveButtonClicked: machine)
        }
    }

    let border: BorderView = {
        let border = BorderView()
        border.backgroundColor = .clear
        return border
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(listPriceLabel)
        /*
        addSubview(subtotalLabel)
        addSubview(saveButton)
         */
        addSubview(border)

        let imageViewWidth: CGFloat = 150
        let imageViewHeight: CGFloat = imageViewWidth * (3/4)
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true

        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        listPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        listPriceLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        listPriceLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        listPriceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        /*

        subtotalLabel.topAnchor.constraint(equalTo: listPriceLabel.bottomAnchor, constant: 5).isActive = true
        subtotalLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        subtotalLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        subtotalLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        saveButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        saveButton.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        saveButton.rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        */

        border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        border.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        border.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
