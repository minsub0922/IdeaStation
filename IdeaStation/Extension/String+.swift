//
//  String+.swift
//  IdeaStation
//
//  Created by 최민섭 on 2020/03/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

extension String {
    func getAttributedString(range: ClosedRange<Int>, color: UIColor) -> NSMutableAttributedString {
        let myMutableString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font :UIFont(name: "Georgia", size: 25.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length: self.count))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location: range.lowerBound, length: range.count))
        return myMutableString
    }
}
