//
//  BasicCell.swift
//  AmadaMachines
//
//  Created by IT Support on 9/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {

    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }

    var descriptionText: String = "" {
        didSet {
            descriptionTextView.text = descriptionText
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 16)
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(titleLabel)
        addSubview(descriptionTextView)
        backgroundColor = .red

        titleLabel.backgroundColor = .blue
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        descriptionTextView.backgroundColor = .orange
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor).isActive = true
        descriptionTextView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
