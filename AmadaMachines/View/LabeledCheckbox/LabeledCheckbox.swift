//
//  LabeledCheckbox.swift
//  AmadaMachines
//
//  Created by IT Support on 10/2/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class LabeledCheckbox: UIView {

    private var heightLayoutConstraint: NSLayoutConstraint?

    let checkbox: Checkbox = {
        return Checkbox()
    }()

    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        addSubview(checkbox)

        checkbox.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        checkbox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: checkbox.leftAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
