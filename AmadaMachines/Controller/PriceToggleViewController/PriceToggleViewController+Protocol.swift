//
//  PriceToggleViewController+Protocol.swift
//  AmadaMachines
//
//  Created by IT Support on 10/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension PriceToggleViewController: ToggleCollectionViewCellDelegate {
    func toggleCollectionViewCell(_ view: ToggleCollectionViewCell, switchToggled: PriceToggle) {
        if let delegate = delegate {
            delegate.pricetoggleViewController(self, switchToggled: switchToggled)
        }
    }
}
