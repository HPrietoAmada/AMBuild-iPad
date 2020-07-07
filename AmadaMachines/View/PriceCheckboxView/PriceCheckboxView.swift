//
//  PriceCheckboxView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class PriceCheckboxView: UIView {

    private var heightLayoutConstraint: NSLayoutConstraint?

    var height: CGFloat = 30 {
        didSet {
            if let heightConstraint = heightLayoutConstraint {
                heightConstraint.constant = height
            }
        }
    }

    var isChecked: Bool = false {
        didSet {
            checkbox.isChecked = isChecked
        }
    }

    var text: String = "" {
        didSet {
            label.text = text
        }
    }

    var price: Double = 0.0 {
        didSet {
            priceLabel.text = "\(price.currencyFormatted())"
        }
    }

    let checkbox: Checkbox = {
        return Checkbox()
    }()

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
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

    let border: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    init(text: String, price: Double) {
        super.init(frame: CGRect.zero)
        self.label.text = text
        self.priceLabel.text = price.currencyFormatted()
        self.text = text
        self.price = price
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkbox)
        addSubview(label)
        addSubview(priceLabel)
        addSubview(border)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        checkbox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkbox.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        priceLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

        label.leftAnchor.constraint(equalTo: checkbox.rightAnchor, constant: 10).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: priceLabel.leftAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
