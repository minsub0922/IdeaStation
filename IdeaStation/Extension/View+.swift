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
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width;
        let aspectHeight = size.height / self.size.height;
        
        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
}

extension UIView {
    func onCenter() {
        self.center = CGPoint(x: frame.origin.x, y: frame.origin.y)
    }
    
    func addShadowOnLabel(shadowColor: CGColor = UIColor.black.cgColor) {
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addRounded(radius: CGFloat = 16.0) {
        self.layer.cornerRadius = radius
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
    
    func bounce(completion: @escaping() -> Void = {}) {
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
    
    func fadeOut(until alpha: CGFloat = 0.3, during: Double = 0.5) {
        UIView.animate(withDuration: during, animations: {
            self.alpha = alpha
        })
    }
    
    func fadeIn(during: Double = 1) {
        UIView.animate(withDuration: during, animations: {
            self.alpha = 1
        })
    }
    
    func changeAlphaWithAnimation(alpha: CGFloat) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = alpha
        })
    }
    
    func blink(onNext: (() -> Void)? = nil ) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.3
        }, completion: { res in
            onNext == nil ? nil : onNext!()
            UIView.animate(withDuration: 0.15, animations: {
                self.alpha = 1
            })
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

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    private static var _url = [String:String]()
    
    var url: String {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIImageView._url[tmpAddress] ?? ""
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIImageView._url[tmpAddress] = newValue
        }
    }
    
    func loadImageAsyc(url stringUrl : String) {
        guard let url = URL(string: stringUrl) else { return }

        self.url = stringUrl
        
        if let imageFromCache = imageCache.object(forKey: stringUrl as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data:Data?, res:URLResponse?, error:Error?) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            DispatchQueue.global().async {
                guard let data = data, let imageToCache = UIImage(data: data) else {
                    print("Image Data Error")
                    return
                }
                
                if self.url == stringUrl {
                    DispatchQueue.main.async {
                        self.image = imageToCache
                        imageCache.setObject(imageToCache, forKey: stringUrl as AnyObject)
                    }
                }
            }
        }.resume()
    }
}
