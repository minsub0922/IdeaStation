//
//  View+.swift
//  IdeaStation
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIView {
    func rotate(to angle: CGFloat) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.toValue = CGFloat(angle)
        rotateAnimation.duration = 0.5
        rotateAnimation.isCumulative = true
        layer.add(rotateAnimation, forKey: "rotationAnimation")
    }
    
    func pulse() {
        UIView.animate(withDuration: 1.0, animations: {
            let center = self.center
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width * 0.8, height: self.frame.height * 0.8)
            self.center = center
        })
    }
}

