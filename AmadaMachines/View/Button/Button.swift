//
//  Button.swift
//  AmadaMachines
//
//  Created by IT Support on 8/29/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit
protocol ButtonDelegate {
    func button(_ button: Button, buttonClicked tag: Int)
}

class Button: UIButton {

    var activeColor: UIColor?

    var delegate: ButtonDelegate?

    fileprivate var heightLayoutConstraint: NSLayoutConstraint?
    fileprivate var widthLayoutConstraint: NSLayoutConstraint?

    var height: CGFloat = 40 {
        didSet {
            guard let heightLayoutConstraint = heightLayoutConstraint else {
                return
            }

            let buttonIsHidden = heightLayoutConstraint.constant == 0

            heightLayoutConstraint.constant = buttonIsHidden ? 0 : height
        }
    }

    var width: CGFloat = 60 {
        didSet {
            guard let widthLayoutConstraint = widthLayoutConstraint else {
                return
            }
            widthLayoutConstraint.constant = width
        }
    }

    var fontSize: CGFloat = 16 {
        didSet {
            titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        }
    }

    var titleFont: UIFont = UIFont(name: "HelveticaNeue-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16) {
        didSet {
            titleLabel?.font = titleFont
        }
    }

    var title: String = "Button" {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    var titleColor: UIColor = UIColor.white {
        didSet {
            setTitleColor(titleColor, for: .normal)
        }
    }

    var buttonTintColor: UIColor = UIColor.black {
        didSet {
            tintColor = buttonTintColor
        }
    }

    var unselectedTintColor: UIColor? {
        didSet {
            if isSelected == true { return }
            guard let unselectedTintColor = unselectedTintColor else {
                return
            }
            tintColor = unselectedTintColor
        }
    }

    var borderColor: UIColor = UIColor.MainColors.mainColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }

    var cornerRadius: CGFloat = 3 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    var buttonColor: UIColor = UIColor.MainColors.mainColor {
        didSet {
            backgroundColor = buttonColor
        }
    }

    var unselectedButtonColor: UIColor? {
        didSet {
            if isSelected == true { return }
            guard let unselectedButtonColor = unselectedButtonColor else {
                return
            }
            backgroundColor = unselectedButtonColor
        }
    }

    var buttonImage: UIImage = UIImage() {
        didSet {
            let tintedImage = buttonImage.withRenderingMode(.alwaysTemplate)
            setImage(tintedImage, for: .normal)
        }
    }

    var imagePadding: CGFloat = 0 {
        didSet {
            imageEdgeInsets = UIEdgeInsets(top: imagePadding, left: imagePadding, bottom: imagePadding, right: imagePadding)
        }
    }

    init(_ backgroundImage: UIImage,
         title: String = "") {
        super.init(frame: CGRect.zero)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.title = title
        setTitle(title, for: .normal)
        self.activeColor = backgroundColor
        self.initialize()
    }

    init(_ title: String) {
        super.init(frame: CGRect.zero)
        self.title = title
        setTitle(title, for: .normal)
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initialize()
        self.activeColor = UIColor.black
    }

    func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = 3
        titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        backgroundColor = buttonColor
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        widthLayoutConstraint = widthAnchor.constraint(equalToConstant: width)
        widthLayoutConstraint?.isActive = true

        display()
    }

    func display(_ display: Bool = true) {
        alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    func activate(_ active: Bool = true) {
        self.backgroundColor = active ? self.activeColor : UIColor.lightGray
        self.isEnabled = active
    }

    @objc func buttonClicked() {
        guard let delegate = delegate else {
            return
        }
        isSelected = !isSelected
        if let unselectedTintColor = unselectedTintColor {
            tintColor = isSelected ? tintColor : unselectedTintColor
        }
        if let unselectedButtonColor = unselectedButtonColor {
            backgroundColor = isSelected ? buttonColor : unselectedButtonColor
        }
        delegate.button(self, buttonClicked: tag)
    }

    func setState(_ title: String, active: Bool = false) {
        setTitle(title, for: .normal)
        setTitleColor(active ? UIColor.MainColors.lightColor : UIColor.white, for: .normal)
        backgroundColor = active ? UIColor.white : UIColor.MainColors.green
        layer.borderColor = active ? UIColor.MainColors.lightColor.cgColor : UIColor.MainColors.green.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
