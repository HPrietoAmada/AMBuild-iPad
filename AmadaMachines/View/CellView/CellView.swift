//
//  CellView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol CellViewDelegate {
    func cellView(_ view: CellView, cellTapped tag: Int)
}

class CellView: UIView {

    var delegate: CellViewDelegate?

    private var heightLayoutConstraint: NSLayoutConstraint?

    var height: CGFloat = 60 {
        didSet {
            heightLayoutConstraint?.constant = height
        }
    }
    var text: String = "" {
        didSet {
            self.label.text = text
        }
    }

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 21)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let border: BorderView = {
        let border = BorderView()
        return border
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    init(text: String) {
        super.init(frame: CGRect.zero)
        self.label.text = text
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(border)

        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: heightAnchor).isActive = true

        border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        border.widthAnchor.constraint(equalTo: label.widthAnchor).isActive = true
        border.centerXAnchor.constraint(equalTo: label.centerXAnchor).isActive = true

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapped))
        addGestureRecognizer(tap)
    }

    @objc private func handleTapped() {
        print("tap")
        guard let delegate = delegate else {
            return
        }

        delegate.cellView(self, cellTapped: tag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
