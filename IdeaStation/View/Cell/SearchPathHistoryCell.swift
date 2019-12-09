//
//  SearchPathHistoryCell.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/12/07.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchPathHistoryCell: UICollectionViewCell {
    let historiesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font.withSize(8)
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSubview(historiesLabel)
        addSubview(wordLabel)
        
        NSLayoutConstraint.activate([
            wordLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            wordLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            wordLabel.heightAnchor.constraint(equalToConstant: 20),
            historiesLabel.topAnchor.constraint(equalTo: topAnchor),
            historiesLabel.bottomAnchor.constraint(equalTo: wordLabel.topAnchor),
            historiesLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func setupView(_ keyword: MDKeyword) {
        wordLabel.text = keyword.keyword
        historiesLabel.text = keyword.history
    }
}
