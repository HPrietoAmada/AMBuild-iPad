//
//  NavigationController.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    let statusBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if traitCollection.userInterfaceStyle == .dark {
            statusBarBackground.backgroundColor = .black
            navigationBar.tintColor = .white
            navigationBar.backgroundColor = .black
        } else {
            statusBarBackground.backgroundColor = .white
            navigationBar.tintColor = .black
            navigationBar.backgroundColor = .white
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    func setupNavbar() {
        navigationBar.isHidden = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        navigationBar.addSubview(statusBarBackground)
        statusBarBackground.bottomAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
        statusBarBackground.widthAnchor.constraint(equalTo: navigationBar.widthAnchor).isActive = true
        statusBarBackground.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor).isActive = true
        statusBarBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}
