//
//  MainSeedTableViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/18.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainSeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todaySeedTitle: UILabel!
    @IBOutlet weak var seedDescription: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.seedDescription.text = "asdfasdf"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
