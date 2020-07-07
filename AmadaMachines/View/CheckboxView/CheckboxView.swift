//
//  CheckboxView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol CheckboxViewDelegate {
    func checkboxView(_ checkboxView: CheckboxView, checkboxTapped isChecked: Bool, tag: Int)
}

class CheckboxView: UIView {

    private let BOUNDS: CGFloat = 30

    var delegate: CheckboxViewDelegate?

    private var heightLayoutConstraint: NSLayoutConstraint?

    var height: CGFloat = 80

    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkboxView.backgroundColor = UIColor.MainColors.mainColor
                checkboxView.layer.borderColor = UIColor.MainColors.mainColor.cgColor
                checkmarkImageView.alpha = 1
            } else {
                checkboxView.backgroundColor = UIColor.clear
                checkboxView.layer.borderColor = UIColor.lightGray.cgColor
                checkmarkImageView.alpha = 0
            }
        }
    }

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 19)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var checkboxView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 3.5
        view.layer.borderColor = UIColor.MainColors.lightGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false

        let checkboxBounds: CGFloat = 25
        view.heightAnchor.constraint(equalToConstant: checkboxBounds).isActive = true
        view.widthAnchor.constraint(equalToConstant: checkboxBounds).isActive = true
        return view
    }()

    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "checkmark25")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        imageView.isUserInteractionEnabled = false
        return imageView
    }()

    let bottomBorder: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    init(_ title: String) {
        super.init(frame: CGRect.zero)
        setup()
        titleLabel.text = title
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(checkboxView)
        addSubview(bottomBorder)
        checkboxView.addSubview(checkmarkImageView)

        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true

        checkboxView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkboxView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

        let padding: CGFloat = 3.5
        checkmarkImageView.topAnchor.constraint(equalTo: checkboxView.topAnchor, constant: padding).isActive = true
        checkmarkImageView.rightAnchor.constraint(equalTo: checkboxView.rightAnchor, constant: -padding).isActive = true
        checkmarkImageView.leftAnchor.constraint(equalTo: checkboxView.leftAnchor, constant: padding).isActive = true
        checkmarkImageView.bottomAnchor.constraint(equalTo: checkboxView.bottomAnchor, constant: -padding).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: checkboxView.rightAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        isChecked = false

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonClicked))
        addGestureRecognizer(tapGesture)
    }

    @objc func buttonClicked(sender: UIButton) {
        isChecked = !isChecked
        guard let delegate = delegate else {
            return
        }
        delegate.checkboxView(self, checkboxTapped: isChecked, tag: tag)
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    func reset() {
        isChecked = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
