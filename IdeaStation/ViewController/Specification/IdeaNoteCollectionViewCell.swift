//
//  IdeaNoteCollectionViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/09/30.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class IdeaNoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
