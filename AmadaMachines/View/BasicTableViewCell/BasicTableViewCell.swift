//
//  BasicTableViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 11/4/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

    let topLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let topRightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.MainColors.red
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomLeftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomRightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .right
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let border: BorderView = {
        return BorderView()
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        addSubview(topLeftLabel)
        addSubview(topRightLabel)
        addSubview(bottomLeftLabel)
        addSubview(bottomRightLabel)
        addSubview(border)

        topLeftLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        topLeftLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topLeftLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topLeftLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        topRightLabel.leftAnchor.constraint(equalTo: topLeftLabel.rightAnchor).isActive = true
        topRightLabel.topAnchor.constraint(equalTo: topLeftLabel.topAnchor).isActive = true
        topRightLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        topRightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        bottomLeftLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        bottomLeftLabel.topAnchor.constraint(equalTo: topLeftLabel.bottomAnchor).isActive = true
        bottomLeftLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        bottomLeftLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        bottomRightLabel.leftAnchor.constraint(equalTo: bottomLeftLabel.rightAnchor, constant: 20).isActive = true
        bottomRightLabel.topAnchor.constraint(equalTo: bottomLeftLabel.topAnchor).isActive = true
        bottomRightLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        bottomRightLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        border.leftAnchor.constraint(equalTo: topLeftLabel.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo: topRightLabel.rightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
