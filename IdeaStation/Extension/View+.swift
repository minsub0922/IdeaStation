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
    func bounce(completion: @escaping() -> Void) {
        var targetFrame = self.frame
        targetFrame.origin.y -= 5
        self.frame = targetFrame
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseOut, animations: {
            targetFrame.origin.y += 5
            self.frame = targetFrame
        }) { res in
            completion()
        }
    }
    func fadeOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.3
        })
    }
    func fadeIn() {
        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 1
        })
    }
    func changeHeight(by dHeight: Double) {
        let center = self.center
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height + CGFloat(dHeight) < 0 ? 0 : self.frame.height + CGFloat(dHeight))
        self.center = center
    }
    func changeWidth(by dWidth: Double) {
        print(self.frame.width)
        let center = self.center
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + CGFloat(dWidth) < 0 ? 0 : self.frame.width + CGFloat(dWidth), height: self.frame.height)
        self.center = center
    }
    func moveTo(x: CGFloat, y: CGFloat) {
        self.center = CGPoint(x: self.center.x + x, y: self.center.y + y)
    }
}
