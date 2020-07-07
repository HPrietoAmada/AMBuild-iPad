//
//  QRScannerViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 9/23/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol QRScannerViewControllerDelegate {
    func qrScannerViewController(didFail: Bool, str: String?)
}

class QRScannerViewController: UIViewController, QRScannerViewDelegate {
    func qrScanningDidFail() {
        if let delegate = self.delegate {
            delegate.qrScannerViewController(didFail: true, str: nil)
            scanner.stopScanning()
        }
    }

    func qrScanningSucceededWithCode(_ str: String?) {
        print("Scanned: \(str ?? "nothing")")
        if let delegate = self.delegate {
            delegate.qrScannerViewController(didFail: false, str: str)
            scanner.stopScanning()
        }
    }

    func qrScanningDidStop() {
        dismiss(animated: true, completion: nil)
    }

    var delegate: QRScannerViewControllerDelegate?


    let scanner: QRScannerView = {
        return QRScannerView()
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }()

    let crossHeir: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false

        view.heightAnchor.constraint(equalToConstant: 150).isActive = true
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        view.addSubview(scanner)
        view.addSubview(crossHeir)
        view.addSubview(closeButton)

        scanner.delegate = self
        scanner.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        scanner.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        scanner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scanner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        crossHeir.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        crossHeir.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        scanner.startScanning()
    }

    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
}
