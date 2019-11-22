//
//  MandalartCell.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol MandalartCellDelegate: class {
    func touchupCell(isSelected: Bool, category: String, children: [String])
}

class MandalartCell: UICollectionViewCell {
    weak var delegate: MandalartCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
    }
    
    override var bounds: CGRect {
        didSet {
            addShadow(type: .small)
        }
    }
    
    private var category: String = String()
    private var children: [String] = []

    public func setupView(center: String, children: [String]) {
        self.category = center
        self.children = children
        
        let mandalart = Mandalart(frame: .zero, centerText: center, childTexts: children)
        mandalart.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:))))
        addSubview(mandalart)
        
        mandalart.translatesAutoresizingMaskIntoConstraints = false
        mandalart.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mandalart.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mandalart.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mandalart.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    @objc private func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        isSelected = !isSelected
        delegate?.touchupCell(isSelected: isSelected, category: self.category, children: self.children)
        layer.shadowOpacity = isSelected ? 3 : 0.2
        layer.shadowRadius = isSelected ? 4.0 : 2.0
    }
}
