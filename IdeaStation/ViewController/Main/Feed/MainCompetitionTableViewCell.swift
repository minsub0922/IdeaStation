//
//  MainCompetitionTableViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/18.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainCompetitionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todayCompetition: UILabel!
    @IBOutlet weak var competitionDescription: UILabel!
    @IBOutlet weak var competitionImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
