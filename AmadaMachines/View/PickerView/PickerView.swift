//
//  PickerView.swift
//  AmadaMachines
//
//  Created by IT Support on 11/5/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class PickerViewModel {
    var description: String?
    var value: Any?

    init(description: String, value: Any) {
        self.description = description
        self.value = value
    }
}

protocol PickerViewDelegate {
    func pickerViewRowSelected(_ pickerView: UIPickerView, row: Int, inComponent component: Int, pickerViewModel: PickerViewModel)
}

class PickerView: UIView {

    var models: [PickerViewModel] = []

    var selectedModel: PickerViewModel?

    var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: PickerViewDelegate?

    var height: CGFloat = 100

    var disabled: Bool = false {
        didSet {
            isUserInteractionEnabled = false
        }
    }

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
        textField.textAlignment = .left
        textField.textColor = UIColor.MainColors.darkGray
        textField.tintColor = UIColor.black
        textField.backgroundColor = UIColor.clear
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 75))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.isTranslucent = true
        toolbar.barStyle = UIBarStyle.default
        toolbar.isUserInteractionEnabled = true
        toolbar.backgroundColor = UIColor.white
        toolbar.tintColor = UIColor.MainColors.lightColor
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    let toolbarSpaceButton: UIBarButtonItem = {
        let barSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        return barSpace
    }()

    let toolbarDoneButton: UIBarButtonItem = {
        let barDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil)
        barDone.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 16)!], for: .normal)
        return barDone
    }()

    let bottomBorder: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeView()
        self.initPicker()
        self.models = []
        self.label.text = ""
    }

    init(text: String,
         models: [PickerViewModel]) {
        super.init(frame: CGRect.zero)
        label.text = text
        self.models = models
        initializeView()
        initPicker()
        picker.reloadAllComponents()
    }

    init(_ text: String,
         labels: [String],
         placeholder: String = "") {
        super.init(frame: CGRect.zero)
        initializeView()
        initPicker()
        field.placeholder = placeholder
        label.text = text
        models.removeAll()
        for (index, label) in labels.enumerated() {
            let viewModel = PickerViewModel(description: label, value: index)
            models.append(viewModel)
        }
        self.picker.reloadAllComponents()
    }

    func setPickerValue(index: Int) {
        let selectedModel = models[index]
        picker.selectRow(index, inComponent: 0, animated: false)
        field.text = selectedModel.description
        self.selectedModel = selectedModel
    }

    private func initializeView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.label)
        self.addSubview(self.field)
        self.addSubview(self.bottomBorder)

        self.toolbar.items = [self.toolbarSpaceButton, self.toolbarDoneButton]
        self.field.inputAccessoryView = self.toolbar
        self.field.inputView = picker

        // Field Constraints
        field.topAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true
        field.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        field.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        field.heightAnchor.constraint(equalToConstant: 40).isActive = true

        // Bottom Border Constraints
        self.bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true

        // Label Constraints
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -4).isActive = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(becomeResponder))
        self.addGestureRecognizer(tapGesture)

        heightLayoutConstraint = self.heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        display()
    }

    func reset() {
        selectedModel = nil
        field.text = ""
    }

    @objc func becomeResponder() {
        self.field.becomeFirstResponder()
    }

    func display(_ display: Bool = true)
    {
        alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    func setHeight(height: CGFloat)
    {
        heightLayoutConstraint?.constant = height
        heightLayoutConstraint?.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

