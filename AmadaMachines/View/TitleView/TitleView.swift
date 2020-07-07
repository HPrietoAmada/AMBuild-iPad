//
//  TitleView.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class TitleView: UIView {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String = "" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    /* View Components */
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.MainColors.darkGray
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /* Constructor for View */
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.initializeViews()
    }

    init(_ title: String, subtitle: String) {
        super.init(frame: CGRect.zero)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.initializeViews()
    }

    func initializeViews() {
        // Add Components to View
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)

        translatesAutoresizingMaskIntoConstraints = false

        // Title Label Constraints
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        // Description Label Constraints
        self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

        self.bottomAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: -20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
