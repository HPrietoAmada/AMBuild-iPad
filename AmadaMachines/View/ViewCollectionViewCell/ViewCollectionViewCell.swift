//
//  ViewCollectionViewCell.swift
//  AmadaMachines
//
//  Created by IT Support on 9/25/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ViewCollectionViewCell: UICollectionViewCell {

    var displayView: UIView = UIView() {
        didSet {
            mainView = displayView
        }
    }

    var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(mainView)

        mainView.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        mainView.heightAnchor.constraint(equalTo: heightAnchor, constant: -50).isActive = true
        mainView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
