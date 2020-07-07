//
//  ListView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/21/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class ListView: UIView {

    fileprivate var listViewBottomAnchor: NSLayoutYAxisAnchor?

    var title: String = "Title" {
        didSet {
            titleLabel.text = title
        }
    }

    var list: [String] = [] {
        didSet {
            // remove subviews before adding new subview list items
            self.subviews.forEach { (subview) in
                if subview.tag != 0 { subview.removeFromSuperview() }
            }

            // iterate through each new list item
            // create textview from list item
            // anchor under textview before it
            for (index, item) in list.enumerated() {

                // create textview
                let textView = UITextView()
                textView.isUserInteractionEnabled = false
                textView.font = UIFont(name: "HelveticaNeue", size: 18)
                textView.text = "· \(item)"
                textView.tag = index + 1
                self.addSubview(textView)

                if index == 0 {
                    textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
                } else {
                    if let prev = subviews.first(where: { (subview) -> Bool in
                        return subview.tag == index
                    }) {
                        textView.topAnchor.constraint(equalTo: prev.bottomAnchor, constant: 0).isActive = true
                    }
                }

                textView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
                textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

                // check if last item to anchor main view to bottom of last list item view
                if index == (item.count - 1) {
                    listViewBottomAnchor?.constraint(equalTo: textView.bottomAnchor, constant: 10).isActive = true
                }
            }
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 23)
        label.tag = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let listView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLabel)

        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
