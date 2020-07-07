//
//  ModelDisplayView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class MachineCollectionViewCell: UICollectionViewCell {

    var modelWidthLayoutConstraint: NSLayoutConstraint?

    var selectable: Bool = false

    var modelSelected: Bool = false {
        didSet {
            if !selectable { return }
            containerView.layer.borderColor = modelSelected ? UIColor.MainColors.green.cgColor : UIColor.placeholder.cgColor
            containerView.layer.borderWidth = modelSelected ? 3 : 1
            selectFilterView.alpha = modelSelected ? 0.5 : 0
        }
    }

    var machine: MACHINE = MACHINE() {
        didSet {
            name = machine.model
            desc = machine.modelDesc
            listPrice = machine.listPrice
        }
    }

    var machineCore: MachineCore? {
        didSet {
            guard let machineCore = machineCore else {
                return
            }
            if let machineName = machineCore.model {
                name = machineName
            }

            if let machineDesc = machineCore.modelDesc {
                desc = machineDesc
            }

            listPrice = machineCore.listPrice
        }
    }

    var cellSize: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            let imageWidth: CGFloat = cellSize.width * 0.75
            modelWidthLayoutConstraint?.constant = imageWidth
        }
    }

    var modelImage: UIImage? {
        didSet {
            guard let modelImage = modelImage else {
                return
            }
            modelImageView.image = modelImage
        }
    }

    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }

    var desc: String = "" {
        didSet {
            descriptionLabel.text = desc
        }
    }

    var listPrice: Double = 0.0 {
        didSet {
            listPriceLabel.text = listPrice.currencyFormatted()
        }
    }

    var nameLabelFontSize: CGFloat = 18 {
        didSet {
            nameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: nameLabelFontSize)
        }
    }

    var descriptionLabelFontSize: CGFloat = 16 {
        didSet {
            descriptionLabel.font = UIFont(name: "HelveticaNeue", size: descriptionLabelFontSize)
        }
    }

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.layer.masksToBounds = true
        //view.layer.cornerRadius = 5
        //view.layer.borderColor = UIColor.placeholder.cgColor
        //view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let modelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let listPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
        label.textColor = UIColor.MainColors.red
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return label
    }()

    let descriptionLabel: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let selectFilterView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.MainColors.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let border: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        backgroundColor = .clear

        addSubview(containerView)
        containerView.addSubview(modelImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(selectFilterView)
        containerView.addSubview(border)
        containerView.addSubview(listPriceLabel)

        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        // descriptionLabel, nameLabel, listPriceLabel, modelImageView

        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //descriptionLabel.backgroundColor = .red

        nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor, constant: -10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //nameLabel.backgroundColor = .orange

        listPriceLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        listPriceLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        listPriceLabel.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor).isActive = true
        listPriceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        //listPriceLabel.backgroundColor = .yellow

        modelImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        modelImageView.centerXAnchor.constraint(equalTo: descriptionLabel.centerXAnchor).isActive = true
        modelImageView.bottomAnchor.constraint(equalTo: listPriceLabel.topAnchor).isActive = true
        modelWidthLayoutConstraint = modelImageView.widthAnchor.constraint(equalToConstant: 0)
        modelWidthLayoutConstraint?.isActive = true

        selectFilterView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        selectFilterView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        selectFilterView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        selectFilterView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        border.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        border.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40).isActive = true
        border.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

/*

 func setup() {
     backgroundColor = .clear

     addSubview(containerView)
     containerView.addSubview(modelImageView)
     containerView.addSubview(nameLabel)
     containerView.addSubview(descriptionLabel)
     containerView.addSubview(selectFilterView)
     containerView.addSubview(border)
     containerView.addSubview(listPriceLabel)

     containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
     containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
     containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
     containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

     modelImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
     modelImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
     modelWidthLayoutConstraint = modelImageView.widthAnchor.constraint(equalToConstant: 600)
     modelWidthLayoutConstraint?.isActive = true
     modelHeightLayoutConstraint = modelImageView.heightAnchor.constraint(equalToConstant: 600 * (9/16))
     modelHeightLayoutConstraint?.isActive = true

     listPriceLabel.topAnchor.constraint(equalTo: modelImageView.bottomAnchor, constant: 5).isActive = true
     listPriceLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40).isActive = true
     listPriceLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

     nameLabel.topAnchor.constraint(equalTo: listPriceLabel.bottomAnchor, constant: 10).isActive = true
     nameLabel.widthAnchor.constraint(equalTo: listPriceLabel.widthAnchor).isActive = true
     nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

     descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
     descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
     descriptionLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor, constant: 10).isActive = true
     descriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true

     selectFilterView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
     selectFilterView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
     selectFilterView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
     selectFilterView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

     border.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
     border.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -40).isActive = true
     border.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
 }

 */
