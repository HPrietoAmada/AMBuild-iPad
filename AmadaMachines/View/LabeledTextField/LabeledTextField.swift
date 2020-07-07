//
//  LabeledTextField.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol LabeledTextFieldDelegate {
    func didEndEditing(_ textField: UITextField, value: String, tag: Int)
    func labeledTextField(_ view: LabeledTextField, valueChanged value: String, tag: Int)
}

class LabeledTextField: UIView, UITextFieldDelegate {
    var value: Int?

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledTextFieldDelegate?

    var height: CGFloat = 100

    var text: String = "" {
        didSet {
            field.text = text
        }
    }

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    /* View Components */
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.MainColors.darkGray
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var field: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "HelveticaNeue", size: 18)
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .left
        textField.textColor = UIColor.MainColors.darkGray
        textField.tintColor = UIColor.black
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        return textField
    }()

    let toolBarLeftSpace: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        return barButton
    }()

    let toolBarDone: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
        barButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 16)!], for: .normal)
        return barButton
    }()

    let toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isTranslucent = true
        toolbar.barStyle = UIBarStyle.default
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = UIColor.white
        toolbar.tintColor = UIColor.MainColors.lightColor
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    let bottomBorder: BorderView = {
        return BorderView()
    }()

    init(_ label: String, tag:Int, placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.label.text = label
        self.field.placeholder = placeholder
        self.tag = tag
        self.initialzeViews()
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholder])
    }

    @objc func recognizeTap() {
        if !self.field.isFirstResponder {
            self.field.becomeFirstResponder()
        }
    }

    func initialzeViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        self.addSubview(self.label)
        self.addSubview(self.field)
        self.addSubview(self.bottomBorder)

        self.toolBar.items = [self.toolBarLeftSpace,self.toolBarDone]
        self.field.inputAccessoryView = self.toolBar

        toolBarDone.action = #selector(handleDone)

        // Field Constraints
        field.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        field.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        field.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true
        field.delegate = self

        bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bottomBorder.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recognizeTap))
        self.addGestureRecognizer(tapGesture)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        self.display()
    }

    @objc func textFieldChanged(_ textField: UITextField) {
        guard let delegate = delegate else {
            return
        }

        if let text = textField.text {
            delegate.labeledTextField(self, valueChanged: text, tag: tag)
        }
    }

    func reset() {
        text = ""
    }

    @objc func handleDone() {
        endEditing(true)
        delegate?.didEndEditing(field, value: field.text!, tag: tag)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        delegate?.didEndEditing(textField, value: field.text!, tag: tag)
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
