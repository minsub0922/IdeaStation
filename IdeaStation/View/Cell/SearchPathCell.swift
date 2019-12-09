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
        historyLabel.adjustsFontSizeToFitWidth = true
        historyLabel.lineBreakMode = .byClipping
        historyLabel.isHidden = true
    }
}
