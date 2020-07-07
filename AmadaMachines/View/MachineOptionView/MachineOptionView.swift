//
//  MachineOptionView.swift
//  AmadaMachines
//
//  Created by IT Support on 9/16/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit
import WebKit

protocol MachineOptionViewDelegate {
    func machineOptionView(_ view: MachineOptionView, addOptionClicked machineOption: MACHINE_OPTION)
    func machineOptionView(_ view: MachineOptionView, removeOptionClicked machineOption: MACHINE_OPTION)
}

class MachineOptionView: UIView {

    var delegate: MachineOptionViewDelegate?

    var machineOption: MACHINE_OPTION = MACHINE_OPTION() {
        didSet {
            reset()
            self.title = machineOption.Option

            if let optionImage = UIImage(named: machineOption.Option) {
                image = optionImage
            }

            self.desc = machineOption.OptionDesc
            self.listPriceLabel.text = machineOption.ListPrice.currencyFormatted()

            let optionBulletDescriptionList: [MACHINE_OPTION_BULLET_DESCRIPTION] = MACHINE_OPTION_BULLET_DESCRIPTION()
                .getMachineOptionBulletDescrptionList()
                .filter({
                    $0.Option == machineOption.Option
                        && $0.Description != ""
                })

            for (index, optionDescription) in optionBulletDescriptionList.enumerated() {
                if let bulletDescriptionLabel = optionDescriptionListView.subviews.first(where: { $0.tag == (index + 1) }) as? UILabel {
                    bulletDescriptionLabel.text = "\u{2022} \(optionDescription.Description)"
                }
            }

            scrollToTop()
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

    var index: String = "" {
        didSet {
            indexLabel.text = index
        }
    }

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var desc: String = "" {
        didSet {
            descriptionTextView.text = desc
        }
    }

    var contentSize: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            scrollView.contentSize = contentSize
        }
    }

    let scrollView: ScrollView = {
        let scrollView = ScrollView()
        return scrollView
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

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.font = UIFont(name: "HelveticaNeue", size: 14)
        textView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5)
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let border1: BorderView = {
        return BorderView()
    }()

    let descriptionListTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        label.text = "Description"
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let optionDescriptionListView: UIView = {
        let view = UIView()
        let optionDescriptionList: [String] = [
            "110-ton press brake with exceptional price/performance ratio",
            "Large open height allows deep box bending and easier retraction of parts with large down flanges",
            "Fast multilple axis backgauge",
            "AMNC touchscreen control with graphical interface",
            "Dr.ABE_Bend Software allows parts to be verified offline — eliminating guesswork and significantly reducing setup times"
        ]

        let labelFont = UIFont(name: "HelveticaNeue", size: 18)
        let labelHeight: CGFloat = 50
        let label1  = UILabel()
        label1.font = labelFont
        label1.translatesAutoresizingMaskIntoConstraints = false
        //label1.text = "· \(optionDescriptionList[0])"
        label1.numberOfLines = 2
        label1.textColor = .black
        label1.tag = 1

        let label2 = UILabel()
        label2.font = labelFont
        label2.translatesAutoresizingMaskIntoConstraints = false
        //label2.text = "· \(optionDescriptionList[1])"
        label2.numberOfLines = 2
        label2.textColor = .black
        label2.tag = 2

        let label3  = UILabel()
        label3.font = labelFont
        label3.translatesAutoresizingMaskIntoConstraints = false
        //label3.text = "· \(optionDescriptionList[2])"
        label3.numberOfLines = 2
        label3.textColor = .black
        label3.tag = 3

        let label4  = UILabel()
        label4.font = labelFont
        label4.translatesAutoresizingMaskIntoConstraints = false
        //label4.text = "· \(optionDescriptionList[3])"
        label4.numberOfLines = 2
        label4.textColor = .black
        label4.tag = 4

        let label5  = UILabel()
        label5.font = labelFont
        label5.translatesAutoresizingMaskIntoConstraints = false
        //label5.text = "· \(optionDescriptionList[4])"
        label5.numberOfLines = 2
        label5.textColor = .black
        label5.tag = 1

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

        label1.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label1.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label1.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true

        label2.topAnchor.constraint(equalTo: label1.bottomAnchor).isActive = true
        label2.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label2.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true

        label3.topAnchor.constraint(equalTo: label2.bottomAnchor).isActive = true
        label3.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label3.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true

        label4.topAnchor.constraint(equalTo: label3.bottomAnchor).isActive = true
        label4.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label4.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label4.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true

        label5.topAnchor.constraint(equalTo: label4.bottomAnchor).isActive = true
        label5.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label5.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label5.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true

        view.translatesAutoresizingMaskIntoConstraints = false

        view.bottomAnchor.constraint(equalTo: label5.bottomAnchor, constant: 10).isActive = true
        return view
    }()

    let border2: BorderView = {
        return BorderView()
    }()

    let videoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 23)
        label.numberOfLines = 1
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let youtubePlayer: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        webConfig.allowsInlineMediaPlayback = false
        let view = WKWebView(frame: .zero, configuration: webConfig)
        let myURL = URL(string: "https://www.youtube.com/embed/2IyBdyKruUQ?playsinline=1")
        //let myURL = URL(string: "https://www.youtube.com/embed/BY-aB72nONA?playsinline=1")
        let youtubeRequest = URLRequest(url: myURL!)
        view.load(youtubeRequest)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var addButton : Button = {
        let button = Button("Add Option")
        button.backgroundColor = UIColor.MainColors.green
        button.height = 50
        button.width = 150
        button.fontSize = 16
        button.addTarget(self, action: #selector(handleAddOption), for: .touchUpInside)
        return button
    }()

    @objc func handleAddOption() {
        guard let delegate = self.delegate else {
            return
        }
        if machineOptionSelected {
            delegate.machineOptionView(self, removeOptionClicked: machineOption)
        } else {
            delegate.machineOptionView(self, addOptionClicked: machineOption)
        }

        machineOptionSelected = !machineOptionSelected
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 10

        addSubview(indexLabel)
        addSubview(titleLabel)
        addSubview(listPriceLabel)
        addSubview(descriptionTextView)
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(addButton)
        scrollView.addSubview(border1)
        scrollView.addSubview(descriptionListTitleLabel)
        scrollView.addSubview(optionDescriptionListView)
        /*
        scrollView.addSubview(border2)
        scrollView.addSubview(videoTitleLabel)
        scrollView.addSubview(youtubePlayer)
        */
        
        indexLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        indexLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true

        titleLabel.topAnchor.constraint(equalTo: indexLabel.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: indexLabel.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

        descriptionTextView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 25).isActive = true

        addButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        addButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        addButton.backgroundColor = .red

        listPriceLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5).isActive = true
        listPriceLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        listPriceLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        listPriceLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

        scrollView.topAnchor.constraint(equalTo: listPriceLabel.bottomAnchor, constant: 10).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 800).isActive = true
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

//        addButton.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 40).isActive = true
//        addButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40).isActive = true

        border1.topAnchor.constraint(equalTo: imageView
            .bottomAnchor, constant: 50).isActive = true
        border1.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        border1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        descriptionListTitleLabel.topAnchor.constraint(equalTo: border1.bottomAnchor, constant: 40).isActive = true
        descriptionListTitleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -60).isActive = true
        descriptionListTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        descriptionListTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        optionDescriptionListView.topAnchor.constraint(equalTo: descriptionListTitleLabel.bottomAnchor, constant: 10).isActive = true
        optionDescriptionListView.widthAnchor.constraint(equalTo: descriptionListTitleLabel.widthAnchor, constant: 0).isActive = true
        optionDescriptionListView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        /*
        border2.topAnchor.constraint(equalTo: optionDescriptionListView
            .bottomAnchor, constant: 50).isActive = true
        border2.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        border2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        let videoWidth: CGFloat = 600
        let videoHeight: CGFloat = videoWidth * (9/16)
        videoTitleLabel.text = "Videos"
        videoTitleLabel.topAnchor.constraint(equalTo: border2.bottomAnchor, constant: 40).isActive = true
        videoTitleLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        videoTitleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        videoTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        youtubePlayer.topAnchor.constraint(equalTo: videoTitleLabel.topAnchor, constant: 0).isActive = true
        youtubePlayer.widthAnchor.constraint(equalToConstant: videoWidth).isActive = true
        youtubePlayer.heightAnchor.constraint(equalToConstant: videoHeight).isActive = true
        youtubePlayer.leftAnchor.constraint(equalTo: videoTitleLabel.rightAnchor).isActive = true
         */
    }

    func scrollToTop() {
        scrollView.scrollToTop(false)
    }

    func reset() {
        titleLabel.text = ""
        listPriceLabel.text = ""
        descriptionTextView.text = ""
        imageView.image = UIImage()
        descriptionListTitleLabel.text = ""
        optionDescriptionListView.subviews.forEach { (view) in
            if let label = view as? UILabel {
                label.text = ""
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
