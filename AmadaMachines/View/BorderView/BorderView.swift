//
//  BorderView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class BorderView: UIView {
    private var heightLayoutConstraint: NSLayoutConstraint?
    var height: CGFloat = 0.8 {
        didSet {
            heightLayoutConstraint?.constant = height
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        backgroundColor = UIColor.placeholder

        translatesAutoresizingMaskIntoConstraints = false

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
