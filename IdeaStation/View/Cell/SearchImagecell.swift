//
//  SearchImagecell.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/19.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchImagecell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    } ()
    
    override var bounds: CGRect {
        didSet {
            setupImageView()
            self.addShadow()
            layer.shadowOpacity = isSelected ? 3 : 0.2
        }
    }
    
    public func applyShadow() {
        layer.shadowOpacity = isSelected ? 3 : 0.2
    }
    
    private func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        imageView.addRounded()
    }
    
    public func setupView(imagePath: String) {
        imageView.image = UIImage()
        imageView.loadImageAsyc(url: imagePath)
        layer.shadowOpacity = isSelected ? 5 : 0.2
    }
}