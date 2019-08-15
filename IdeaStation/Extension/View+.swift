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
    func addShadow() {
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 16.0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addRounded() {
        self.layer.cornerRadius = 16.0
        self.clipsToBounds = true
    }
    
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
    
    func fadeOut(until alpha: CGFloat = 0.3) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = alpha
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
