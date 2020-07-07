//
//  LabeledTextView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/2/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol LabeledTextViewDelegate {
    func labeledTextViewDelegate(_ view: LabeledTextView, done tag: Int)
}

class LabeledTextView: UIView, UITextFieldDelegate {

    private var heightLayoutConstraint: NSLayoutConstraint?

    var delegate: LabeledTextViewDelegate?

    var height: CGFloat = 150

    var placeholder: String?

    var text: String = "" {
        didSet {
            textView.text = text
            textView.textColor = .black
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
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        textView.backgroundColor = .white
        textView.textColor = .placeholder
        textView.tintColor = .gray
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 2.5
        textView.layer.borderWidth = 1.25
        textView.layer.borderColor = UIColor.MainColors.lightGray.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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

    let toolbarSpace: UIBarButtonItem = {
        let barSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                       target: nil,
                                       action: nil)
        return barSpace
    }()

    lazy var toolbarDone: UIBarButtonItem = {
        let barDone = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                      target: nil,
                                      action: #selector(done))
        barDone.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium",
                                                                            size: 16)!],
                                       for: .normal)
        return barDone
    }()

    init(_ label: String, tag:Int, placeholder: String = "") {
        super.init(frame: CGRect.zero)
        self.label.text = label
        self.textView.text = placeholder
        self.placeholder = placeholder
        self.tag = tag
        self.initialzeViews()

    }

    @objc func done() {
        endEditing(true)
        guard let delegate = delegate else {
            return
        }
        delegate.labeledTextViewDelegate(self, done: tag)
    }

    func initialzeViews() {
        translatesAutoresizingMaskIntoConstraints = false
        // Add Components to View
        self.addSubview(self.label)
        self.addSubview(self.textView)

        toolbar.items = [self.toolbarSpace, self.toolbarDone]

        textView.inputAccessoryView = self.toolbar

        // Field Constraints
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5).isActive = true
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: height - 50).isActive = true
        textView.delegate = self

        // Label Constraints
        label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        self.display()
    }

    func getText() -> String {
        let isPlaceholder = textView.textColor != .black
        return isPlaceholder ? "" : textView.text
    }

    func reset() {
        if let placeholder = placeholder {
            textView.text = placeholder
        } else {
            textView.text = ""
        }

        textView.textColor = .placeholder
    }

    func display(_ display: Bool = true) {
        self.alpha = display ? 1 : 0
        heightLayoutConstraint?.constant = display ? height : 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
