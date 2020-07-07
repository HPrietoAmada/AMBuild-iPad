//
//  ToggleTableViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 10/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol ToggleCollectionViewCellDelegate {
    func toggleCollectionViewCell(_ view: ToggleCollectionViewCell, switchToggled: PriceToggle)
}

class ToggleCollectionViewCell: UICollectionViewCell {

    var delegate: ToggleCollectionViewCellDelegate?

    var priceToggle: PriceToggle = PriceToggle() {
        didSet {
            toggleON = priceToggle.show
            desc = priceToggle.description
        }
    }

    var toggleON: Bool = false {
        didSet {
            toggleSwitch.isOn = toggleON
        }
    }

    var desc: String = "" {
        didSet {
            label.text = desc
        }
    }

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 21)
        label.backgroundColor = .white
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var toggleSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = false
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.addTarget(self, action: #selector(handleToggle), for: .touchUpInside)
        return uiSwitch
    }()
    
    @objc func handleToggle(_ sender: UISwitch) {
        priceToggle.show = sender.isOn
        if let priceToggleCore = priceToggle.priceToggleCore() {
            priceToggleCore.show = sender.isOn
            CoreDataManager.shared.update(model: priceToggleCore) { (true, error) in
                if let delegate = self.delegate {
                    delegate.toggleCollectionViewCell(self, switchToggled: self.priceToggle)
                }
            }
        } else {
            CoreDataManager.shared.save(model: priceToggle) { (priceToggleCore, error) in
                if let delegate = self.delegate {
                    delegate.toggleCollectionViewCell(self, switchToggled: self.priceToggle)
                }
            }
        }
    }


    let border: BorderView = {
        return BorderView()
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        backgroundColor = .white
        addSubview(label)
        addSubview(toggleSwitch)
        addSubview(border)

        toggleSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        toggleSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true

        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        border.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        border.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo: toggleSwitch.rightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
