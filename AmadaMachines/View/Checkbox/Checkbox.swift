//
//  Checkbox.swift
//  AmadaMachines
//
//  Created by IT Support on 10/1/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol CheckboxDelegate {
    func checkbox(_ view: Checkbox, isChecked: Bool)
}

class Checkbox: UIView {

    var delegate: CheckboxDelegate?

    private var checkboxWidthLayoutConstraint: NSLayoutConstraint?
    private var checkboxHeightLayoutConstraint: NSLayoutConstraint?

    var checkboxDims: CGFloat = 25 {
        didSet {
            checkboxWidthLayoutConstraint?.constant = checkboxDims
            checkboxHeightLayoutConstraint?.constant = checkboxDims
        }
    }

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

    lazy var checkboxView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 3.5
        view.layer.borderColor = UIColor.MainColors.lightGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
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

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(checkboxView)
        checkboxView.addSubview(checkmarkImageView)

        let padding: CGFloat = 20
        checkboxWidthLayoutConstraint = widthAnchor.constraint(equalToConstant: checkboxDims + padding)
        checkboxHeightLayoutConstraint = heightAnchor.constraint(equalToConstant: checkboxDims + padding)
        checkboxWidthLayoutConstraint?.isActive = true
        checkboxHeightLayoutConstraint?.isActive = true

        checkboxView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        checkboxView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        checkboxView.widthAnchor.constraint(equalTo: widthAnchor, constant: -padding).isActive = true
        checkboxView.heightAnchor.constraint(equalTo: heightAnchor, constant: -padding).isActive = true

        let checkmarkImagePadding: CGFloat = 3.5
        checkmarkImageView.topAnchor.constraint(equalTo: checkboxView.topAnchor, constant: checkmarkImagePadding).isActive = true
        checkmarkImageView.bottomAnchor.constraint(equalTo: checkboxView.bottomAnchor, constant: -checkmarkImagePadding).isActive = true
        checkmarkImageView.rightAnchor.constraint(equalTo: checkboxView.rightAnchor, constant: -checkmarkImagePadding).isActive = true
        checkmarkImageView.leftAnchor.constraint(equalTo: checkboxView.leftAnchor, constant: checkmarkImagePadding).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCheckmarkTapped))
        addGestureRecognizer(tapGesture)
    }

    @objc func handleCheckmarkTapped() {
        isChecked = !isChecked
        if let delegate = delegate {
            delegate.checkbox(self, isChecked: isChecked)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
