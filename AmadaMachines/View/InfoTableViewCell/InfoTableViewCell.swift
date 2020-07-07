//
//  InfoTableViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 8/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    /* TableViewCell Components */
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let totalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.MainColors.lightColor
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let milesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        // label.textColor = .black
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        // label.textColor = .black
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MainColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()

    /* TableViewCell Constructor */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    /* Adds UIComponents to TableViewCell's View */
    func setup() {
        // Add views to Custom TableCellView
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        self.addSubview(self.cellView)
        self.cellView.addSubview(self.dateLabel)
        self.cellView.addSubview(self.titleLabel)
        self.cellView.addSubview(self.totalLabel)
        self.cellView.addSubview(self.milesLabel)
        self.cellView.addSubview(self.descriptionLabel)
        self.cellView.addSubview(self.bottomBorder)

        // CellView Constraints
        self.cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        // self.cellView.layer.cornerRadius = 5

        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 25).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.totalLabel.leftAnchor, constant: -5).isActive = true
        self.descriptionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

        self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -5).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 25).isActive = true

        self.dateLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 25).isActive = true

        self.totalLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: -25).isActive = true
        self.totalLabel.centerYAnchor.constraint(equalTo: self.descriptionLabel.centerYAnchor).isActive = true
        self.totalLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

        self.milesLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: -25).isActive = true
        self.milesLabel.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor).isActive = true

        self.bottomBorder.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor).isActive = true
        self.bottomBorder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.bottomBorder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
