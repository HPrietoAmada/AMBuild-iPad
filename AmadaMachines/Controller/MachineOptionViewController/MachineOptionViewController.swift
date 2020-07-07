//
//  MachineOptionViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 9/16/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol MachineOptionViewControllerDelegate {
    func machineOptionViewController(_ controller: MachineOptionViewController, added option: MACHINE_OPTION)
    func machineOptionViewController(_ controller: MachineOptionViewController, removed option: MACHINE_OPTION, indexPath: IndexPath)
}

class MachineOptionViewController: UIViewController {

    var delegate: MachineOptionViewControllerDelegate?

    var machineOption: MACHINE_OPTION = MACHINE_OPTION() {
        didSet {
            titleView.title = machineOption.Option
            titleView.subtitle = machineOption.OptionDesc
            listPriceLabel.text = machineOption.ListPrice.currencyFormatted()

            let machineBulletOptions = MACHINE_OPTION_BULLET_DESCRIPTION().getMachineOptionBulletDescrptionList().filter({
                $0.Option == machineOption.Option
            })
            machineOptionBullets = machineBulletOptions

            if let image = UIImage(named: machineOption.Option) {
                imageView.image = image
            }
        }
    }

    var optionIndex: IndexPath = IndexPath(row: 0, section: 0)

    var machineOptionBullets: [MACHINE_OPTION_BULLET_DESCRIPTION] = [] {
        didSet {
            reset()
            let count: Int = machineOptionBullets.count

            if count >= 1 {
                let bullet = machineOptionBullets[0]
                let desc = bullet.Description
                bulletView1.labelText = desc
            }

            if count >= 2 {
                let bullet = machineOptionBullets[1]
                bulletView2.labelText = bullet.Description
                print("\(bullet.Description)")
            }

            if count >= 3 {
                let bullet = machineOptionBullets[2]
                bulletView3.labelText = bullet.Description
                print("\(bullet.Description)")
            }

            if count >= 4 {
                let bullet = machineOptionBullets[3]
                bulletView4.labelText = bullet.Description
                print("\(bullet.Description)")
            }

            if count >= 5 {
                let bullet = machineOptionBullets[4]
                bulletView5.labelText = bullet.Description
                print("\(bullet.Description)")
            }

            setScrollViewHeight()
        }
    }

    var machineOptionSelected: Bool = false {
        didSet {
            addButton.backgroundColor = machineOptionSelected ? UIColor.MainColors.red : UIColor.MainColors.green

            let addButtonTitle = machineOptionSelected ? "Remove Option" : "Add Option"
            addButton.setTitle(addButtonTitle, for: .normal)
        }
    }

    var image: UIImage? {
        didSet {
            guard let image = image else {
                return
            }
            imageView.image = image
        }
    }

    var contentSize: CGSize = CGSize(width: 0, height: 0) {
        didSet {

        }
    }

    let scrollView: ScrollView = {
        return ScrollView()
    }()

    let indexLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.MainColors.mainColor
        label.font = UIFont(name: "HelveticaNeue", size: 23)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false

        let labelDims: CGFloat = 50
        label.layer.cornerRadius = labelDims / 2
        label.heightAnchor.constraint(equalToConstant: labelDims).isActive = true
        label.widthAnchor.constraint(equalToConstant: labelDims).isActive = true
        return label
    }()

    let titleView: TitleView = {
        return TitleView("", subtitle: "")
    }()

    let listPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.numberOfLines = 1
        label.textColor = UIColor.MainColors.red
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tag = 1
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let bulletView1: BulletListItemView = {
        let bulletView = BulletListItemView()
        return bulletView
    }()

    let bulletView2: BulletListItemView = {
        let bulletView = BulletListItemView()
        return bulletView
    }()

    let bulletView3: BulletListItemView = {
        let bulletView = BulletListItemView()
        return bulletView
    }()

    let bulletView4: BulletListItemView = {
        let bulletView = BulletListItemView()
        return bulletView
    }()

    let bulletView5: BulletListItemView = {
        let bulletView = BulletListItemView()
        return bulletView
    }()

    lazy var addButton : Button = {
        let button = Button("Add Option")
        button.backgroundColor = UIColor.MainColors.green
        button.addTarget(self, action: #selector(handleAddOption), for: .touchUpInside)
        return button
    }()

    @objc func handleAddOption() {
        if let delegate = delegate {
            if machineOptionSelected {
                delegate.machineOptionViewController(self, removed: machineOption, indexPath: optionIndex)
            } else {
                delegate.machineOptionViewController(self, added: machineOption)
            }
        }
        machineOptionSelected = !machineOptionSelected
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }

    func setup() {
        view.backgroundColor = .white

        view.addSubview(titleView)
        view.addSubview(listPriceLabel)
        view.addSubview(scrollView)
        view.addSubview(addButton)

        let viewWidth: CGFloat = view.bounds.width - 40

        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        addButton.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        addButton.width = 150

        listPriceLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        listPriceLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        listPriceLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true

        scrollView.topAnchor.constraint(equalTo: listPriceLabel.bottomAnchor, constant: 10).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        setScrollViewHeight()

        scrollView.addSubview(imageView)
        scrollView.addSubview(bulletView1)
        scrollView.addSubview(bulletView2)
        scrollView.addSubview(bulletView3)
        scrollView.addSubview(bulletView4)
        scrollView.addSubview(bulletView5)

        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: viewWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: viewWidth * (6/9)).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletView1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        bulletView1.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        bulletView1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletView2.topAnchor.constraint(equalTo: bulletView1.bottomAnchor, constant: 5).isActive = true
        bulletView2.widthAnchor.constraint(equalTo: bulletView1.widthAnchor).isActive = true
        bulletView2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletView3.topAnchor.constraint(equalTo: bulletView2.bottomAnchor, constant: 5).isActive = true
        bulletView3.widthAnchor.constraint(equalTo: bulletView1.widthAnchor).isActive = true
        bulletView3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletView4.topAnchor.constraint(equalTo: bulletView3.bottomAnchor, constant: 5).isActive = true
        bulletView4.widthAnchor.constraint(equalTo: bulletView1.widthAnchor).isActive = true
        bulletView4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        bulletView5.topAnchor.constraint(equalTo: bulletView4.bottomAnchor, constant: 5).isActive = true
        bulletView5.widthAnchor.constraint(equalTo: bulletView1.widthAnchor).isActive = true
        bulletView5.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close")!, style: .plain, target: self, action: #selector(handleClose))
    }

    func setScrollViewHeight() {
        let imageViewHeight: CGFloat = (view.bounds.width - 40) * (6/9)
        let height: CGFloat = 150 + imageViewHeight + CGFloat(machineOptionBullets.count * 50)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: height)
    }

    func reset() {
        bulletView1.labelText = ""
        bulletView2.labelText = ""
        bulletView3.labelText = ""
        bulletView4.labelText = ""
        bulletView5.labelText = ""
    }

    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
}
