//
//  MainSeedCollectionViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/10/31.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainSeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var todaySeedTitleLabel: UILabel!
    @IBOutlet weak var seedSaveButton: UIButton!
    @IBOutlet weak var seedDescription: UITextView!
    
    @IBAction func feedSeedSave(_ sender: UIButton) {
        print(SharingData.shared.postResponseArray)
    }
}
