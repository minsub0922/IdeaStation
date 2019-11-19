//
//  MandalartCell.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MandalartCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setupView(center: String, children: [String]) {
        let mandalart = Mandalart(frame: .zero, centerText: center, childTexts: children)
        addSubview(mandalart)
        
        mandalart.translatesAutoresizingMaskIntoConstraints = false
        mandalart.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mandalart.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mandalart.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mandalart.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
