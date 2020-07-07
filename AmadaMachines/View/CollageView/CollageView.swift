//
//  CollageView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/25/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class CollageView: UIView {

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
