//
//  Colors+.swift
//  IdeaStation
//
//  Created by 최민섭 on 2020/03/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// MARK: Custom Colors
extension UIColor {
    open class var defaultText: UIColor {
        return .init(red: 34/255, green: 43/255, blue: 69/255, alpha: 1)
    }
    
    open class var contentText: UIColor {
        return .init(red: 15/255, green: 21/255, blue: 37/255, alpha: 1)
    }
    
    open class var defaultShadow: UIColor {
        return .init(red: 185/255, green: 185/255, blue: 185/255, alpha: 0.5)
    }
    
    open class var accentColor: UIColor {
        return .init(red: 255/255, green: 61/255, blue: 113/255, alpha: 1)
    }
}
