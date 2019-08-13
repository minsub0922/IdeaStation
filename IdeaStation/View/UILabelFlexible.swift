//
//  UILabelFlexible.swift
//  IdeaStation
//
//  Created by 최민섭 on 13/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class UILabelFlexible: UILabel {
    
    var isFirst = true
    
    init(text: String, fontSize: CGFloat, center: CGPoint) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 0)))
        self.text = text
        self.center = center
        font = font.withSize(fontSize)
        minimumScaleFactor = 0.1    //or whatever suits your need
        adjustsFontSizeToFitWidth = true
        lineBreakMode = .byClipping
        numberOfLines = 0
        textColor = .black
        textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

