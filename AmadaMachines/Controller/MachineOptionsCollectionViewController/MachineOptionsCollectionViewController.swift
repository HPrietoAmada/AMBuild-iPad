//
//  MachineOptionsCollectionViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 8/27/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit
import WebKit

protocol PartLocationButtonDelegate {
    func partLocationButton(_ button: PartLocationButton, tag: Int)
}

class PartLocationButton: UIButton {

    var delegate: PartLocationButtonDelegate?

    var index: Int = 0 {
        didSet {
            setTitle("\(index)", for: .normal)
            tag = index
        }
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        layer.masksToBounds = true
        layer.cornerRadius = 25
        backgroundColor = UIColor.MainColors.mainColor
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2

        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 50).isActive = true

        addTarget(self, action: #selector(handleClick), for: .touchUpInside)
    }

    @objc func handleClick() {
        if let delegate = delegate {
            delegate.partLocationButton(self, tag: tag)
        }
    }
}

class MachineOptionsCollectionViewController: UIViewController {

    var prospectCore: ProspectCore?

    var sections: [String] = [
        "Machine Options",
        "Tooling",
        "Software",
        "Service"
    ]

    var collapseSections: [Bool] = [
        true,
        true,
        true,
        true
    ]

    var selectedOptions: [MACHINE_OPTION] = [MACHINE_OPTION]() {
        didSet {
            collectionView.reloadData()
            let selectedOptionsCount = selectedOptions.count
            viewSummaryButton.alpha = selectedOptionsCount > 0 ? 1 : 1
        }
    }

    var machine: MACHINE = MACHINE() {
        didSet {
            let machineName: String = machine.model
            let listPrice: Double = machine.listPrice
            machineModelNameLabel.text = machineName
            let machineImages: [String] = [
                "\(machineName)_01",
                "\(machineName)_02",
                "\(machineName)_03"
            ]
            machineImageDisplayView.images = machineImages
            machineListPriceLabel.text = listPrice.currencyFormatted()

            let machineOptions = MACHINE_OPTION().getMachineOptions().filter({
                $0.Model == machine.model
            })

            machineDescriptionTextView.text = machine.description
            self.machineOptions = machineOptions

            let bulletDescriptions: [MACHINE_BULLET_DESCRIPTION] = MACHINE_BULLET_DESCRIPTION().getDescriptions().filter({
                $0.Model == machine.model &&
                $0.Description != ""
            })

            let bulletCount: Int = bulletDescriptions.count

            if bulletCount >= 1 {
                bulletDescription1.labelText = bulletDescriptions[0].Description
            }

            if bulletCount >= 2 {
                bulletDescription2.labelText = bulletDescriptions[1].Description
            }

            if bulletCount >= 3 {
                bulletDescription3.labelText = bulletDescriptions[2].Description
            }

            if bulletCount >= 4 {
                bulletDescription4.labelText = bulletDescriptions[3].Description
            }

            if bulletCount >= 5 {
                bulletDescription5.labelText = bulletDescriptions[4].Description
            }
        }
    }

    var machineOptions: [MACHINE_OPTION] = [MACHINE_OPTION]() {
        didSet {
            collectionView.reloadData()
        }
    }

    let blurAnimationDuration: Double = 0.25

    let collectionViewWidth: CGFloat = 250
    let cellID: String = "options-cell"

    let collectionView: CollectionView = {
        let collectionView = CollectionView()
        collectionView.layer.borderColor = UIColor.placeholder.cgColor
        collectionView.layer.borderWidth = 1
        collectionView.backgroundColor = .white
        return collectionView
    }()

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    let machineModelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 25)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let machineImageDisplayView: ViewDisplayCollectionView = {
        let view = ViewDisplayCollectionView()
        view.images = ["car1", "car3", "car5"]
        return view
    }()
    let topBorder: BorderView = {
        let border = BorderView()
        return border
    }()

    lazy var blurBackgroundView: BlurView = {
        let view = BlurView()
        view.alpha = 0

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBlurBackgroundTap))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    lazy var machineOptionView: MachineOptionView = {
        let view = MachineOptionView()
        return view
    }()

    @objc func handleBlurBackgroundTap(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: blurAnimationDuration) {
            self.blurBackgroundView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }

    let border1: BorderView = {
        return BorderView()
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 25)
        label.text = "Description"
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let machineListPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 21)
        label.numberOfLines = 1
        label.textColor = UIColor.MainColors.red
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let machineDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.textColor = .black
        textView.font = UIFont(name: "HelveticaNeue", size: 18)
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let bulletDescription1: BulletListItemView = {
        return BulletListItemView()
    }()

    let bulletDescription2: BulletListItemView = {
        return BulletListItemView()
    }()

    let bulletDescription3: BulletListItemView = {
        return BulletListItemView()
    }()

    let bulletDescription4: BulletListItemView = {
        return BulletListItemView()
    }()

    let bulletDescription5: BulletListItemView = {
        return BulletListItemView()
    }()

    let border2: BorderView = {
        return BorderView()
    }()

    let videoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let youtubePlayer: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        webConfig.allowsInlineMediaPlayback = false
        let view = WKWebView(frame: .zero, configuration: webConfig)
        let myURL = URL(string: "https://www.youtube.com/embed/eu-zSocKnZo?playsinline=1")
        //let myURL = URL(string: "https://www.youtube.com/embed/BY-aB72nONA?playsinline=1")
        let youtubeRequest = URLRequest(url: myURL!)
        view.load(youtubeRequest)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var viewSummaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Machine Build", for: .normal)
        button.backgroundColor = UIColor.MainColors.lightColor

        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleViewSummary), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc func handleViewSummary() {
        let controller = MachineSummaryCollectionViewController()
        controller.machine = machine
        controller.machineOptions = selectedOptions
        controller.delegate = self
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    // Part Location Buttons
    /*
    let part4: PartLocationButton = {
        let button = PartLocationButton()
        button.index = 4
        return button
    }()

    let part8: PartLocationButton = {
        let button = PartLocationButton()
        button.index = 8
        return button
    }()
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        machineListPriceLabel.alpha = 0
        machineOptionView.listPriceLabel.alpha = 0
        CoreDataManager.shared.get { (coreModels: [PriceToggleCore], error) in
            if let _ = error {
                return
            }
            if let priceToggleCore = coreModels.first(where: { $0.controller == "MachineOptionsCollectionViewController" && $0.view == "machinePrice" }) {
                self.machineListPriceLabel.alpha = priceToggleCore.show ? 1 : 0
            }
            if let priceToggleCore = coreModels.first(where: { $0.controller == "MachineOptionsCollectionViewController" && $0.view == "optionPrice" }) {
                self.machineOptionView.listPriceLabel.alpha = priceToggleCore.show ? 1 : 0
            }
        }
    }

    func setup() {
        let machineImageViewWidth: CGFloat = view.bounds.width - collectionViewWidth - 30
        let machineImageViewHeight: CGFloat = machineImageViewWidth * (0.8)
        let videoWidth: CGFloat = 600
        let videoHeight: CGFloat = videoWidth * (9/16)
        let scrollViewHeight: CGFloat = 725 + machineImageViewHeight + videoHeight
        let scrollViewWidth: CGFloat = view.bounds.width - collectionViewWidth
        let optionViewWidth: CGFloat = view.bounds.width * 0.85
        let optionViewHeight: CGFloat = view.bounds.height * 0.7

        view.backgroundColor = UIColor.tableBackground

        view.addSubview(collectionView)
        view.addSubview(scrollView)
        view.addSubview(topBorder)
        view.addSubview(viewSummaryButton)
        //view.addSubview(part4)
        //view.addSubview(part8)
        view.addSubview(blurBackgroundView)

        scrollView.addSubview(machineModelNameLabel)
        scrollView.addSubview(machineImageDisplayView)
        scrollView.addSubview(border1)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(machineListPriceLabel)
        scrollView.addSubview(machineDescriptionTextView)
        scrollView.addSubview(bulletDescription1)
        scrollView.addSubview(bulletDescription2)
        scrollView.addSubview(bulletDescription3)
        scrollView.addSubview(bulletDescription4)
        scrollView.addSubview(bulletDescription5)
        /*
        scrollView.addSubview(border2)
        scrollView.addSubview(videoTitleLabel)
        scrollView.addSubview(youtubePlayer)
         */

        blurBackgroundView.addSubview(machineOptionView)

        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: collectionViewWidth).isActive = true

        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.contentSize = CGSize(width: scrollViewWidth, height: scrollViewHeight)

        machineModelNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 25).isActive = true
        machineModelNameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        machineModelNameLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60).isActive = true

        machineImageDisplayView.widthAnchor.constraint(equalToConstant: machineImageViewWidth).isActive = true
        machineImageDisplayView.heightAnchor.constraint(equalToConstant: machineImageViewHeight).isActive = true
        machineImageDisplayView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        machineImageDisplayView.topAnchor.constraint(equalTo: machineModelNameLabel.bottomAnchor, constant: 10).isActive = true
        machineImageDisplayView.viewSize = CGSize(width: machineImageViewWidth, height: machineImageViewHeight)
        machineImageDisplayView.delegate = self
        let modelName = machine.model
        machineImageDisplayView.image360s = [
            "\(modelName)_1_360",
            "\(modelName)_2_360",
            "\(modelName)_3_360",
            "\(modelName)_4_360",
            "\(modelName)_5_360",
            "\(modelName)_6_360",
            "\(modelName)_7_360",
            "\(modelName)_8_360",
            "\(modelName)_9_360"
        ]

        topBorder.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topBorder.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topBorder.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        blurBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        blurBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        blurBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        machineOptionView.delegate = self
        machineOptionView.centerXAnchor.constraint(equalTo: blurBackgroundView.centerXAnchor).isActive = true
        machineOptionView.centerYAnchor.constraint(equalTo: blurBackgroundView.centerYAnchor, constant: 20).isActive = true
        machineOptionView.widthAnchor.constraint(equalToConstant: optionViewWidth).isActive = true
        machineOptionView.heightAnchor.constraint(equalToConstant: optionViewHeight).isActive = true

        // Machine Description ScrollView Contents
        border1.topAnchor.constraint(equalTo: machineImageDisplayView.bottomAnchor, constant: 50).isActive = true
        border1.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        border1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: border1.bottomAnchor, constant: 40).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        machineListPriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        machineListPriceLabel.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor, constant: 0).isActive = true
        machineListPriceLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        machineListPriceLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        machineDescriptionTextView.topAnchor.constraint(equalTo: machineListPriceLabel.bottomAnchor, constant: 5).isActive = true
        machineDescriptionTextView.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor, constant: 0).isActive = true
        machineDescriptionTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        machineDescriptionTextView.heightAnchor.constraint(equalToConstant: 75).isActive = true

        bulletDescription1.topAnchor.constraint(equalTo: machineDescriptionTextView.bottomAnchor, constant: 20).isActive = true
        bulletDescription1.widthAnchor.constraint(equalTo: machineDescriptionTextView.widthAnchor).isActive = true
        bulletDescription1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletDescription2.topAnchor.constraint(equalTo: bulletDescription1.bottomAnchor).isActive = true
        bulletDescription2.widthAnchor.constraint(equalTo: machineDescriptionTextView.widthAnchor).isActive = true
        bulletDescription2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletDescription3.topAnchor.constraint(equalTo: bulletDescription2.bottomAnchor).isActive = true
        bulletDescription3.widthAnchor.constraint(equalTo: machineDescriptionTextView.widthAnchor).isActive = true
        bulletDescription3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletDescription4.topAnchor.constraint(equalTo: bulletDescription3.bottomAnchor).isActive = true
        bulletDescription4.widthAnchor.constraint(equalTo: machineDescriptionTextView.widthAnchor).isActive = true
        bulletDescription4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletDescription5.topAnchor.constraint(equalTo: bulletDescription4.bottomAnchor).isActive = true
        bulletDescription5.widthAnchor.constraint(equalTo: machineDescriptionTextView.widthAnchor).isActive = true
        bulletDescription5.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        /*

        border2.topAnchor.constraint(equalTo: machineDescriptionListView.bottomAnchor, constant: 50).isActive = true
        border2.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        border2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        videoTitleLabel.text = "Videos"
        videoTitleLabel.topAnchor.constraint(equalTo: border2.bottomAnchor, constant: 40).isActive = true
        videoTitleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        videoTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        videoTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        youtubePlayer.topAnchor.constraint(equalTo: videoTitleLabel.topAnchor, constant: 0).isActive = true
        youtubePlayer.widthAnchor.constraint(equalToConstant: videoWidth).isActive = true
        youtubePlayer.heightAnchor.constraint(equalToConstant: videoHeight).isActive = true
        youtubePlayer.leftAnchor.constraint(equalTo: videoTitleLabel.rightAnchor).isActive = true
         */

        viewSummaryButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        viewSummaryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        viewSummaryButton.rightAnchor.constraint(equalTo: collectionView.leftAnchor, constant: -20).isActive = true

        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(handleShowCart))

        /*part4.centerXAnchor.constraint(equalTo: machineImageDisplayView.centerXAnchor).isActive = true
        part4.centerYAnchor.constraint(equalTo: machineImageDisplayView.centerYAnchor, constant: -60).isActive = true
        part4.delegate = self

        part8.bottomAnchor.constraint(equalTo: machineImageDisplayView.bottomAnchor, constant: -170).isActive = true
        part8.leftAnchor.constraint(equalTo: machineImageDisplayView.leftAnchor, constant: 300).isActive = true
        part8.delegate = self*/
        }

        @objc func handleShowCart() {
            let controller = ShoppingCartCollectionViewController()
            present(NavigationController(rootViewController: controller), animated: true, completion: nil)
        }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
