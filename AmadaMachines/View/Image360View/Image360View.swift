//
//  Image360View.swift
//  AmadaMachines
//
//  Created by IT Support on 9/7/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class Image360View: UIView {

    var images: [String] = [String]() {
        didSet {
            if let firstImage = images.first {
                imageView.image = UIImage(named: firstImage)
            }
        }
    }

    fileprivate var imageIndex: Int = 0 {
        didSet {
            if images.count < 1 {
                return
            }
            if imageIndex == images.count {
                imageIndex = 0
            }
            if imageIndex < 0 {
                imageIndex = images.count - 1
            }
            if let nextImage = UIImage(named: images[imageIndex]) {
                imageView.image = nextImage
            }
        }
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let imageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 23)
        label.textColor = UIColor.MainColors.lightColor
        label.text = "Drag to Spin"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(imageLabel)

        imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        imageLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20).isActive = true

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.addGestureRecognizer(swipeLeft)

        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPress.delaysTouchesBegan = false
        longPress.minimumPressDuration = 0.01
        self.addGestureRecognizer(longPress)
    }

    private var lastPressX: CGFloat = 0
    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        let xFingerLocation = sender.location(in: self).x
        let longPressState = sender.state.rawValue
        print("Long Press Direction: \(xFingerLocation)")

        switch longPressState {
        case 1://BEGAN
            lastPressX = 0
            break
        case 2://PRESSING
            let swipingRight = lastPressX < xFingerLocation
            let swipingLeft = lastPressX > xFingerLocation
            let imageChangeStep = Int(xFingerLocation) % 30 == 0

            if swipingRight && imageChangeStep {
                rightSwipe()
            }

            if swipingLeft && imageChangeStep {
                leftSwipe()
            }

            lastPressX = xFingerLocation
            break
        case 3://ENDED
            lastPressX = 0
            break
        default:
            break
        }

    }

    @objc func handleSwipe(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                rightSwipe()
                print("Right swipe")
                break
            case UISwipeGestureRecognizer.Direction.left:
                leftSwipe()
                print("Left swipe")
                break
            default:
                break
            }
        }
    }

    fileprivate func rightSwipe() {
        imageIndex += 1
    }

    fileprivate func leftSwipe() {
        imageIndex -= 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension Image360View: UIGestureRecognizerDelegate {

}
