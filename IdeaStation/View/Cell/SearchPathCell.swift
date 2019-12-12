//
//  SearchPathCell.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/15.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchPathCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        inActivate()
        historyLabel.adjustsFontSizeToFitWidth = true
        historyLabel.lineBreakMode = .byClipping
        historyLabel.isHidden = true
        
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressGetureRecognizer(_:))))
    }
    
    @objc private func longPressGetureRecognizer(_ recognizer: UILongPressGestureRecognizer) {
        
    }
    
    public func activate() {
        label.alpha = 1
        label.font = .boldSystemFont(ofSize: 20)
    }
    
    public func inActivate() {
        label.alpha = 0.6
        label.font = .italicSystemFont(ofSize: 15)
    }
}
