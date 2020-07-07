//
//  TitleHeaderTableViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class TitleHeaderTableViewCell: UICollectionReusableView {

    private let BOUNDS: CGFloat = 20

    var headerTitle: String? {
        didSet {
            guard let title = headerTitle else { return }
            self.titleLabel.text = title
        }
    }

    var headerSubTitle: String? {
        didSet {
            guard let subTitle = headerSubTitle else { return }
            self.subtitleLabel.text = subTitle
        }
    }

    var subTitleColor: UIColor = UIColor.black {
        didSet {
            subtitleLabel.textColor = subTitleColor
        }
    }

    var titleColor: UIColor = UIColor.black {
        didSet {
            titleLabel.textColor = titleColor
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
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /* Constructor for View */

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        // Add Components to View
        addSubview(titleLabel)
        addSubview(subtitleLabel)

        // Title Label Constraints
        titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: BOUNDS).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -BOUNDS).isActive = true

        // Description Label Constraints
        subtitleLabel.topAnchor.constraint(equalTo: centerYAnchor, constant: 5).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
