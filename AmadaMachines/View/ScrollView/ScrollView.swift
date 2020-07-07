//
//  ScrollView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/20/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        bounces = true
        isUserInteractionEnabled = true
        showsVerticalScrollIndicator = true
        tintColor = UIColor.white
        isScrollEnabled = true
        backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
