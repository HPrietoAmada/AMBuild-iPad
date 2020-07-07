//
//  TextNavbarButtonItem.swift
//  AmadaMachines
//
//  Created by IT Support on 9/20/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class TextNavbarButtonItem: UIBarButtonItem {

    var fontSize: CGFloat = 14 {
        didSet {
            setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)], for: .normal)
        }
    }

    var font: String = "HelveticaNeue" {
        didSet {
            setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: font, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)], for: .normal)
        }
    }

    override init() {
        super.init()
        setup()
    }

    init(_ title: String) {
        super.init()
        setup()
        self.title = title
    }

    private func setup() {
        style = UIBarButtonItem.Style.plain
        tintColor = .black
        setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14),], for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

