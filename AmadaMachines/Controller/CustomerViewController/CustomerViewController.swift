//
//  CustomerViewController.swift
//  AmadaMachines
//
//  Created by IT Support on 8/29/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

protocol CustomerViewControllerDelegate {
    func customerViewController(_ controller: CustomerViewController, created customer: ProspectCore)
    func customerViewController(_ controller: CustomerViewController, updated customer: ProspectCore)
}

class CustomerViewController: UIViewController, SalesNumberSearchViewDelegate, QRScannerViewControllerDelegate, UINavigationBarDelegate {

    var delegate: CustomerViewControllerDelegate?

    var prospectCore: ProspectCore? {
        didSet {
            guard let prospectCore = prospectCore else {
                return
            }

            let prospectSalesNumber: Int = Int(prospectCore.salesnumber)

            if let salesman = AS400_SALESMAN().getSalesman().first(where: { $0.SalesmanNumber == prospectSalesNumber }) {
                salesNumberSearchView.model = salesman 
            }

            if let companyName = prospectCore.companyName {
                companyNameLabeledTextField.text = companyName
            }

            if let email = prospectCore.email {
                customerEmailLabeledTextField.text = email
            }

            if let phoneNumber = prospectCore.phoneNumber {
                customerPhoneLabeledTextField.text = phoneNumber
            }

            if let notes = prospectCore.notes {
                notesLabeledTextView.text = notes
            }
        }
    }

    func qrScannerViewController(didFail: Bool, str: String?) {
        guard let str = str else {
            return
        }
        if !didFail {
            scanButton.title = str
            qrCode = str
        }
    }

    var qrCode: String = ""

    func salesNumberSearchViewDelegate(_ view: SalesNumberSearchView, present controller: NavigationController, tag: Int) {
        present(controller, animated: true, completion: nil)
    }

    func salesNumberSearchViewDelegate(_ view: SalesNumberSearchView, controller: NavigationController, selected salesman: AS400_SALESMAN, tag: Int) {
        controller.dismiss(animated: true, completion: nil)
        salesNumberSearchView.model = salesman
        print("Selected salesman: \(salesman.SalesmanNumber)")
    }

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
    }()

    let titleView: TitleView = {
        let titleView = TitleView("Company Information", subtitle: "")
        return titleView
    }()

    var salesNumberSearchView: SalesNumberSearchView = {
        let view = SalesNumberSearchView("Amada Salesman",
                                         tag: 0,
                                         placeholder: "Search for using your name or email")
        return view
    }()

    @objc func handleCustomerNameTap() {
        let controller = NavigationController(rootViewController: SalesNumberSearchViewController())
        present(controller, animated: true, completion: nil)
    }

    let companyNameLabeledTextField: LabeledTextField = {
        let labeledTextField = LabeledTextField("Company Name",
                                                tag: 0,
                                                placeholder: "Enter the company's name")
        return labeledTextField
    }()

    let customerEmailLabeledTextField: LabeledTextField = {
        let labeledTextField = LabeledTextField("Email",
                                                tag: 0,
                                                placeholder: "Enter the company's email")
        labeledTextField.field.keyboardType = UIKeyboardType.emailAddress
        return labeledTextField
    }()

    let customerPhoneLabeledTextField: LabeledTextField = {
        let labeledTextField = LabeledTextField("Phone Number",
                                                tag: 0,
                                                placeholder: "Enter the company's phone number")
        labeledTextField.field.keyboardType = .numberPad
        return labeledTextField
    }()

    let notesLabeledTextView: LabeledTextView = {
        let labeledTextView = LabeledTextView("Notes", tag: 0, placeholder: "Enter any important information")
        return labeledTextView
    }()

    lazy var scanButton: Button = {
        let button = Button("Scan QRCode")
        button.backgroundColor = .white
        button.titleColor = UIColor.MainColors.mainColor
        button.addTarget(self, action: #selector(startScan), for: .touchUpInside)
        return button
    }()

    @objc func startScan() {
        let controller = QRScannerViewController()
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }

    lazy var continueButton: Button = {
        let button = Button("Save Company")
        button.addTarget(self, action: #selector(selectMachine), for: .touchUpInside)
        return button
    }()

    /*
     */
    @objc func selectMachine() {
        if let _ = prospectCore {
            updateProspect()
        } else {
            saveProspect()
        }
        storeSalesman()
        dismiss(animated: true, completion: nil)
    }

    func updateProspect() {
        guard let prospectCore = prospectCore else {
            return
        }
        prospectCore.qrCode = qrCode
        prospectCore.companyName = companyNameLabeledTextField.field.text ?? ""
        prospectCore.salesnumber = Int32(salesNumberSearchView.model?.SalesmanNumber ?? 0)
        prospectCore.email = customerEmailLabeledTextField.field.text ?? ""
        prospectCore.phoneNumber = customerPhoneLabeledTextField.field.text ?? ""
        prospectCore.notes = notesLabeledTextView.getText()

        CoreDataManager.shared.update(model: prospectCore) { (true, error) in
            if let _ = error {
                return
            }

            if let delegate = self.delegate {
                delegate.customerViewController(self, updated: prospectCore)
            }
        }
    }

    func saveProspect() {
        var prospect = Prospect()
        prospect.qrCode = qrCode
        prospect.companyName = companyNameLabeledTextField.field.text ?? ""
        prospect.salesnumber = salesNumberSearchView.model?.SalesmanNumber ?? 0
        prospect.email = customerEmailLabeledTextField.field.text ?? ""
        prospect.phoneNumber = customerPhoneLabeledTextField.field.text ?? ""
        prospect.notes = notesLabeledTextView.getText()
        prospect.createdDate = Date()
        let noProspectEntered = qrCode.count == 0 && prospect.companyName.count == 0 && prospect.email.count == 0 && prospect.phoneNumber.count == 0 && prospect.notes.count == 0
        if !noProspectEntered {
            CoreDataManager.shared.save(model: prospect) { (prospectCore, error) in
                if let _ = error {
                    return
                }
                guard let prospectCore = prospectCore else {
                    return
                }
                if let delegate = self.delegate {
                    delegate.customerViewController(self, created: prospectCore)
                }
            }
        }
    }

    func storeSalesman() {
        let userWantsToStoreSalesmanRecord = storeSalesmanCheckbox.isChecked

        if !userWantsToStoreSalesmanRecord {
            CoreDataManager.shared.deleteAllSalesmanCores()
            return
        }

        guard let selectedSalesmanRecord = salesNumberSearchView.model else { return }

        CoreDataManager.shared.get { (coreModels: [SalesmanCore], error) in
            if let _ = error {
                return
            }
            let salesmanRecordAlreadyStored = coreModels.count > 0
            if !salesmanRecordAlreadyStored { return }
            guard let storedSalesmanRecord = coreModels.first else {
                return
            }
            let storedSalesmanIsSameAsSelected = storedSalesmanRecord.salesmanNumber == selectedSalesmanRecord.SalesmanNumber
            if !storedSalesmanIsSameAsSelected {
                CoreDataManager.shared.deleteAllSalesmanCores()
            }
        }

        CoreDataManager.shared.save(model: selectedSalesmanRecord, nil)
    }

    let storeSalesmanCheckbox: Checkbox = {
        let checkbox = Checkbox()
        checkbox.isChecked = true
        return checkbox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()

        CoreDataManager.shared.get { (coreModels: [SalesmanCore], error) in
            if let _ = error {
                return
            }
            if let firstCoreModel = coreModels.first {
                let salesman = AS400_SALESMAN(firstCoreModel)
                self.salesNumberSearchView.model = salesman
            }
        }
    }

    /*
     */

    private func resetFields() {
        companyNameLabeledTextField.text = ""
        customerEmailLabeledTextField.text = ""
        customerPhoneLabeledTextField.text = ""
        notesLabeledTextView.text = ""
        qrCode = ""
        scanButton.setTitle("Scan QRCode", for: .normal)
    }

    func setup() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleView)
        scrollView.addSubview(salesNumberSearchView)
        scrollView.addSubview(storeSalesmanCheckbox)
        scrollView.addSubview(companyNameLabeledTextField)
        scrollView.addSubview(customerEmailLabeledTextField)
        scrollView.addSubview(customerPhoneLabeledTextField)
        scrollView.addSubview(notesLabeledTextView)
        scrollView.addSubview(scanButton)
        scrollView.addSubview(continueButton)

        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: 20, height: 1300)

        titleView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        titleView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true

        salesNumberSearchView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        salesNumberSearchView.leftAnchor.constraint(equalTo: titleView.leftAnchor).isActive = true
        salesNumberSearchView.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: -50).isActive = true
        salesNumberSearchView.delegate = self

        storeSalesmanCheckbox.leftAnchor.constraint(equalTo: salesNumberSearchView.rightAnchor, constant: 10).isActive = true
        storeSalesmanCheckbox.topAnchor.constraint(equalTo: salesNumberSearchView.topAnchor, constant: 50).isActive = true

        companyNameLabeledTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        companyNameLabeledTextField.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        companyNameLabeledTextField.topAnchor.constraint(equalTo: salesNumberSearchView.bottomAnchor, constant: 5).isActive = true

        customerEmailLabeledTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        customerEmailLabeledTextField.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        customerEmailLabeledTextField.topAnchor.constraint(equalTo: companyNameLabeledTextField.bottomAnchor, constant: 5).isActive = true

        customerPhoneLabeledTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        customerPhoneLabeledTextField.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        customerPhoneLabeledTextField.topAnchor.constraint(equalTo: customerEmailLabeledTextField.bottomAnchor, constant: 5).isActive = true

        notesLabeledTextView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        notesLabeledTextView.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        notesLabeledTextView.topAnchor.constraint(equalTo: customerPhoneLabeledTextField.bottomAnchor, constant: 5).isActive = true

        scanButton.topAnchor.constraint(equalTo: notesLabeledTextView.bottomAnchor, constant: 20).isActive = true
        scanButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        scanButton.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true

        continueButton.topAnchor.constraint(equalTo: scanButton.bottomAnchor, constant: 20).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        continueButton.width = view.bounds.width - 40

        // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Delete All Cores", style: .plain, target: self, action: #selector(handleDeleteAllCores))

        if let _ = prospectCore {
            continueButton.title = "Update"
        } else {
            continueButton.title = "Create"
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(handleClose))
        }

    }

    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }

    @objc func handleDeleteAllCores() {
        CoreDataManager.shared.deleteAllMachineCores()
        CoreDataManager.shared.deleteAllProspectCores()
        CoreDataManager.shared.deleteAllMachineOptionCores()
        CoreDataManager.shared.deleteAllPriceToggleCores()
    }

    @objc func handleShowCart() {
        let controller = ShoppingCartCollectionViewController()
        present(NavigationController(rootViewController: controller), animated: true, completion: nil)
    }

    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}
