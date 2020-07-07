//
//  MachineOptionEditViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 10/30/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol MachineOptionEditViewControllerDelegate {
    func machineOptionEditViewController(_ controller: MachineOptionEditViewController, edited machineOption: MACHINE_OPTION)
    func machineOptionEditViewController(_ controller: MachineOptionEditViewController, removed option: MACHINE_OPTION, indexPath: IndexPath)
}

class MachineOptionEditViewController: UIViewController, PickerViewDelegate {

    func pickerViewRowSelected(_ pickerView: UIPickerView, row: Int, inComponent component: Int, pickerViewModel: PickerViewModel) {
        let pickerViewValue: Double = pickerViewModel.value as! Double
        listPriceTextField.text = pickerViewValue.formatted()
    }

    var showPickerViewModel: Bool = false {
        didSet {
            pickerView.display(showPickerViewModel)
        }
    }

    var delegate: MachineOptionEditViewControllerDelegate?

    var optionIndex: IndexPath = IndexPath(row: 0, section: 0)

    var machineOption: MACHINE_OPTION = MACHINE_OPTION() {
        didSet {
            optionTextLabel.text = machineOption.MachineType
            modelTextLabel.text = machineOption.Model
            descTextLabel.text = machineOption.OptionDesc
            listPriceTextField.text = machineOption.ListPrice.formatted()

            if let image = UIImage(named: machineOption.Option) {
                imageView.image = image
            }

            let machineOptionBulletModels = MACHINE_OPTION_BULLET_DESCRIPTION().getMachineOptionBulletDescrptionList().filter({ $0.Option == machineOption.Option })
            machineOptionBullets = machineOptionBulletModels
        }
    }

    var machineOptionBullets: [MACHINE_OPTION_BULLET_DESCRIPTION] = [] {
        didSet {
            let count: Int = machineOptionBullets.count

            if count >= 1 {
                optionBulletView1.labelText = machineOptionBullets[0].Description
            }

            if count >= 2 {
                optionBulletView2.labelText = machineOptionBullets[1].Description
            }

            if count >= 3 {
                optionBulletView3.labelText = machineOptionBullets[2].Description
            }

            if count >= 4 {
                optionBulletView4.labelText = machineOptionBullets[3].Description
            }

            if count >= 5 {
                optionBulletView5.labelText = machineOptionBullets[4].Description
            }
        }
    }

    var machineOptionSelected: Bool = false {
        didSet {
            addButton.backgroundColor = machineOptionSelected ? UIColor.MainColors.red : UIColor.MainColors.green

            let addButtonTitle = machineOptionSelected ? "Remove Option" : "Add Option"
            addButton.setTitle(addButtonTitle, for: .normal)
        }
    }

    let scrollView: ScrollView = {
        return ScrollView()
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let titleView: TitleView = {
        let titleView = TitleView("Option Edit", subtitle: "")
        return titleView
    }()

    let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .black
        label.text = "Option:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let optionTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let modelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .black
        label.text = "Model:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let modelTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.textColor = .black
        label.text = "Description:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let listPriceTextField: LabeledTextField = {
        let textField = LabeledTextField("List Price (Enter a List Price)", tag: 5, placeholder: "")
        textField.field.keyboardType = .numberPad
        return textField
    }()

    let pickerView: PickerView = {
        let pickerViewModels: [PickerViewModel] = [
            PickerViewModel(description: "2nd Year", value: 6600.00),
            PickerViewModel(description: "3rd Year", value: 13200.00),
            PickerViewModel(description: "4th Year", value: 19800.00),
            PickerViewModel(description: "5th Year", value: 26400.00),
        ]
        let pickerView = PickerView(text: "Service Contract Length (Select a Contract Length)", models: pickerViewModels)
        pickerView.setPickerValue(index: 0)
        pickerView.toolbarDoneButton.action = #selector(endEditing)
        pickerView.display(false)
        return pickerView
    }()

    let optionBulletView1: BulletListItemView = {
        return BulletListItemView()
    }()

    let optionBulletView2: BulletListItemView = {
        return BulletListItemView()
    }()

    let optionBulletView3: BulletListItemView = {
        return BulletListItemView()
    }()

    let optionBulletView4: BulletListItemView = {
        return BulletListItemView()
    }()

    let optionBulletView5: BulletListItemView = {
        return BulletListItemView()
    }()

    let border: BorderView = {
        return BorderView()
    }()

    lazy var addButton: Button = {
        let button = Button("Add Option")
        button.backgroundColor = UIColor.MainColors.green
        button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        return button
    }()

    @objc func handleUpdate() {
        let model = machineOption
        model.ListPrice = Double(listPriceTextField.field.text ?? "0.0") ?? machineOption.ListPrice

        if showPickerViewModel {
            if let pickerModel = pickerView.selectedModel, let desc = pickerModel.description {
                if let optionRecord = MACHINE_OPTION().getMachineOptions().first(where: { $0.Option == machineOption.Option && $0.Model == machineOption.Model }) {
                    model.OptionDesc = "\(optionRecord.OptionDesc) (\(desc))"
                }
            }
        }

        if let delegate = delegate {
            if machineOptionSelected {
                delegate.machineOptionEditViewController(self, removed: model, indexPath: optionIndex)
            } else {
                delegate.machineOptionEditViewController(self, edited: model)
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //listPriceTextField.field.becomeFirstResponder()
    }

    func setup() {
        let imageViewWidth: CGFloat = view.bounds.width - 40
        let imageViewHeight: CGFloat = imageViewWidth * (6/9)
        let scrollViewHeight: CGFloat = 700 + imageViewHeight

        view.backgroundColor = .white

        view.addSubview(scrollView)
        view.addSubview(border)
        view.addSubview(titleView)
        view.addSubview(addButton)
        view.addSubview(optionLabel)
        view.addSubview(optionTextLabel)
        view.addSubview(modelLabel)
        view.addSubview(modelTextLabel)
        view.addSubview(descLabel)
        view.addSubview(descTextLabel)
        scrollView.addSubview(listPriceTextField)
        scrollView.addSubview(pickerView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(optionBulletView1)
        scrollView.addSubview(optionBulletView2)
        scrollView.addSubview(optionBulletView3)
        scrollView.addSubview(optionBulletView4)
        scrollView.addSubview(optionBulletView5)

        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // Option Constraints

        optionLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        optionLabel.rightAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -100).isActive = true
        optionLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true

        optionTextLabel.topAnchor.constraint(equalTo: optionLabel.topAnchor).isActive = true
        optionTextLabel.leftAnchor.constraint(equalTo: optionLabel.rightAnchor).isActive = true
        optionTextLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true

        // addButton constraints
        addButton.rightAnchor.constraint(equalTo: optionTextLabel.rightAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        addButton.width = 150

        // Model Constraints
        modelLabel.topAnchor.constraint(equalTo: optionLabel.bottomAnchor).isActive = true
        modelLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -100).isActive = true
        modelLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true

        modelTextLabel.topAnchor.constraint(equalTo: modelLabel.topAnchor).isActive = true
        modelTextLabel.leftAnchor.constraint(equalTo: modelLabel.rightAnchor).isActive = true
        modelTextLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true

        // Description Constraints
        descLabel.topAnchor.constraint(equalTo: modelLabel.bottomAnchor).isActive = true
        descLabel.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -100).isActive = true
        descLabel.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true

        descTextLabel.topAnchor.constraint(equalTo: descLabel.topAnchor).isActive = true
        descTextLabel.leftAnchor.constraint(equalTo: modelLabel.rightAnchor).isActive = true
        descTextLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor).isActive = true

        scrollView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.bounds.width, height: scrollViewHeight)

        // List Price Constraints

        listPriceTextField.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        listPriceTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        listPriceTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true

        pickerView.topAnchor.constraint(equalTo: listPriceTextField.bottomAnchor).isActive = true
        pickerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        pickerView.widthAnchor.constraint(equalTo: listPriceTextField.widthAnchor).isActive = true
        pickerView.delegate = self

        imageView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageViewWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        optionBulletView1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        optionBulletView1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionBulletView1.widthAnchor.constraint(equalTo: listPriceTextField.widthAnchor).isActive = true

        optionBulletView2.topAnchor.constraint(equalTo: optionBulletView1.bottomAnchor).isActive = true
        optionBulletView2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionBulletView2.widthAnchor.constraint(equalTo: listPriceTextField.widthAnchor).isActive = true

        optionBulletView3.topAnchor.constraint(equalTo: optionBulletView2.bottomAnchor).isActive = true
        optionBulletView3.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionBulletView3.widthAnchor.constraint(equalTo: listPriceTextField.widthAnchor).isActive = true

        optionBulletView4.topAnchor.constraint(equalTo: optionBulletView3.bottomAnchor).isActive = true
        optionBulletView4.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionBulletView4.widthAnchor.constraint(equalTo: listPriceTextField.widthAnchor).isActive = true

        optionBulletView5.topAnchor.constraint(equalTo: optionBulletView4.bottomAnchor).isActive = true
        optionBulletView5.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        optionBulletView5.widthAnchor.constraint(equalTo: listPriceTextField.widthAnchor).isActive = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close")!, style: .plain, target: self, action: #selector(handleClose))
    }

    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }

    @objc func endEditing() {
        view.endEditing(true)
    }
}
