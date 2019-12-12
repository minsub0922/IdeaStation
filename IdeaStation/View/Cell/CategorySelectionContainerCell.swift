//
//  CategorySelectionContainerCell.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/12/12.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CategorySelectionContainerCell: UICollectionViewCell {
    @IBOutlet weak var background: UIView! {
        didSet {
//            background.addCircularRounded()
//            background.addCircularShadow()
        }
    }
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textColor = .black
            label.font = label.font.withSize(20)
        }
    }
    
    override var bounds: CGRect {
        didSet {
            addCircularRounded()
            addCircularShadow()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            layer.shadowOpacity = isSelected ? 3 : 0.2
            
            if isSelected {
                UIView.transition(with: self.label,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: { [weak self] in
                    self?.label.font = self?.label.font.bold.withSize(30)
                  })
            } else {                
                UIView.transition(with: self.label,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: { [weak self] in
                    self?.label.font = self?.label.font.withSize(20)
                  })
            }
        }
    }
    
    public func setupView(text: String) {
        label.text = text
    }
}
