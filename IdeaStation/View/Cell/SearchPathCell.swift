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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        layer.cornerRadius = 15
        inActivate()
    }
    
    public func activate() {
        label.alpha = 1
        label.font = .boldSystemFont(ofSize: 15)
        backgroundColor = UIColor.defaultText.withAlphaComponent(1)
    }
    
    public func inActivate() {
        label.alpha = 0.6
        label.font = .italicSystemFont(ofSize: 15)
        backgroundColor = UIColor.defaultText.withAlphaComponent(0.5)
    }
}
