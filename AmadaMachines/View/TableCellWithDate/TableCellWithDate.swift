//
//  TableCellWithDate.swift
//  AmadaMachines
//
//  Created by IT Support on 9/20/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class TableCellWithDate: UITableViewCell {

    var title: String = "" {
        didSet {
            label.text = title
        }
    }

    var hasBorder: Bool = true {
        didSet {
            bottomBorder.alpha = hasBorder ? 1 : 0
        }
    }

    private let XPADDING: CGFloat = 20

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 3
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textColor = .placeholder
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomBorder: BorderView = {
        let borderView = BorderView()
        return borderView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    func setup() {
        addSubview(label)
        addSubview(detailLabel)
        addSubview(bottomBorder)

        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: XPADDING).isActive = true
        label.rightAnchor.constraint(equalTo: detailLabel.leftAnchor, constant: -10).isActive = true

        detailLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -XPADDING).isActive = true
        detailLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        detailLabel.topAnchor.constraint(equalTo: label.topAnchor).isActive = true

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor, constant: XPADDING).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor, constant: -XPADDING).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

