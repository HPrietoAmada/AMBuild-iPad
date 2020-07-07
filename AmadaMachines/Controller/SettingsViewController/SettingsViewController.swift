//
//  SettingsViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 10/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func settingsViewController(controllerDismissed controller: SettingsViewController)
}

class SettingsViewController: UIViewController, CellViewDelegate {

    var delegate: SettingsViewControllerDelegate?

    func cellView(_ view: CellView, cellTapped tag: Int) {
        switch tag {
        case 1:// priceToggle
            navigationController?.pushViewController(PriceToggleViewController(), animated: true)
            break
        case 2:// Companies
            let controller = CustomerSearchViewController()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
            break
        case 3:// Proposals
            let controller = QuoteSearchViewController()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
    }

    let titleView: TitleView = {
        let view = TitleView("Settings", subtitle: "")
        return view
    }()

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    let priceToggleCellView: CellView = {
        let cell = CellView(text: "Price Toggle")
        cell.tag = 1
        return cell
    }()

    let companiesCellView: CellView = {
        let cell = CellView(text: "Companies")
        cell.tag = 2
        return cell
    }()

    let proposalsCellView: CellView = {
        let cell = CellView(text: "Proposals")
        cell.tag = 3
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setup() {
        view.backgroundColor = .white

        view.addSubview(titleView)
        view.addSubview(scrollView)

        scrollView.addSubview(priceToggleCellView)
        scrollView.addSubview(companiesCellView)
        scrollView.addSubview(proposalsCellView)

        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true

        scrollView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 40).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 200)

        priceToggleCellView.delegate = self
        priceToggleCellView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        priceToggleCellView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        priceToggleCellView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        companiesCellView.delegate = self
        companiesCellView.topAnchor.constraint(equalTo: priceToggleCellView.bottomAnchor).isActive = true
        companiesCellView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        companiesCellView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        proposalsCellView.delegate = self
        proposalsCellView.topAnchor.constraint(equalTo: companiesCellView.bottomAnchor).isActive = true
        proposalsCellView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        proposalsCellView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        let closeNavigationItemImage = UIImage(named: "close")!
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeNavigationItemImage, style: .plain, target: self, action: #selector(handleClose))
    }

    @objc func handleClose() {
        dismiss(animated: true, completion: {
            if let delegate = self.delegate {
                delegate.settingsViewController(controllerDismissed: self)
            }
        })
    }
}
