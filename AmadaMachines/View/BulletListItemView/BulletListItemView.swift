//
//  BulletListView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/25/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class BulletListItemView: UIView {

    private var heightLayoutConstraint: NSLayoutConstraint?

    var height: CGFloat = 50 {
        didSet {
            if let heightLayoutConstraint = heightLayoutConstraint {
                heightLayoutConstraint.constant = height
            }
        }
    }

    var labelText: String = "" {
        didSet {
            self.textView.text = labelText
            if labelText.count > 0 {
                bullet.alpha = 1
            }
        }
    }

    let bullet: UILabel = {
        let label = UILabel()
        label.text = "\u{2022}"
        label.textAlignment = .natural
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "HelveticaNeue", size: 18)
        textView.isUserInteractionEnabled = false
        textView.contentInset = UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(bullet)
        addSubview(textView)

        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: height)
        heightLayoutConstraint?.isActive = true

        bullet.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bullet.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bullet.heightAnchor.constraint(equalToConstant: 20).isActive = true
        bullet.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: bullet.rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
