//
//  BlurrView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/16/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class BlurView: UIView {

    var blurStyle: UIBlurEffect.Style = UIBlurEffect.Style.light

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }

    public func fadeIn(_ duration: TimeInterval = 0.25) {
        alpha = 1
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }

    public func fadeOut(_ duration: TimeInterval = 0.25) {
        alpha = 0
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }
}
