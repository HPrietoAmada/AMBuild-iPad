//
//  ViewDisplayCollectionView+CollectionView.swift
//  AmadaMachines
//
//  Created by IT Support on 10/15/19.
//  Copyright © 2019 IT Support. All rights reserved.
//

import UIKit

extension ViewDisplayCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let firstImage360Name = image360s.first, let _ = UIImage(named: firstImage360Name) {
            return images.count + 1
        }
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCount: Int = images.count
        let cellRowIndex: Int = indexPath.row
        let displayImage360: Bool = imageCount == cellRowIndex
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-id", for: indexPath) as! ImageViewCollectionViewCell
        if displayImage360 {
            if let firstImage360Name = image360s.first, let firstImage360 = UIImage(named: firstImage360Name) {
                cell.image = firstImage360
                let label360 = UILabel()
                label360.text = "360°"
                label360.textAlignment = .center
                label360.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
                label360.textColor = UIColor.white
                label360.backgroundColor = .lightGray
                label360.alpha = 0.8
                label360.translatesAutoresizingMaskIntoConstraints = false
                cell.addSubview(label360)
                label360.topAnchor.constraint(equalTo: cell.imageView.topAnchor).isActive = true
                label360.bottomAnchor.constraint(equalTo: cell.imageView.bottomAnchor).isActive = true
                label360.leftAnchor.constraint(equalTo: cell.imageView.leftAnchor).isActive = true
                label360.rightAnchor.constraint(equalTo: cell.imageView.rightAnchor).isActive = true
            }
            cell.imageBackgroundColor = .white
        } else {
            if let image = UIImage(named: images[indexPath.row]) {
                cell.image = image
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return imageCellSize
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageCount: Int = images.count
        let cellRowIndex: Int = indexPath.row
        let displayImage360: Bool = imageCount == cellRowIndex

        for subview in displayView.subviews {
            subview.removeFromSuperview()
        }

        if displayImage360 {
            let image360View: Image360View = Image360View()
            image360View.tag = 2
            image360View.backgroundColor = .white
            image360View.images = image360s
            displayView.addSubview(image360View)
            image360View.widthAnchor.constraint(equalTo: displayView.widthAnchor).isActive = true
            image360View.heightAnchor.constraint(equalTo: displayView.heightAnchor).isActive = true
            image360View.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
            image360View.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
            if let delegate = delegate {
                delegate.viewDisplayCollectionView(self, imageSelected: indexPath.row)
            }
            return
        }
        if let image = UIImage(named: images[indexPath.row]) {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.tag = 2
            displayView.addSubview(imageView)
            imageView.widthAnchor.constraint(equalTo: displayView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: displayView.heightAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: displayView.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: displayView.centerYAnchor).isActive = true
        }

        if let delegate = delegate {
            delegate.viewDisplayCollectionView(self, imageSelected: indexPath.row)
        }
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageViewCollectionViewCell.self, forCellWithReuseIdentifier: "cell-id")
    }
}
