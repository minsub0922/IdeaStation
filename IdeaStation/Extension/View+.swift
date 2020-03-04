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
    
    func addCircularRounded() {
        let radius = self.bounds.width / 2
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
    
    enum ShadowType {
        case normal
        case small
    }
    
    func addShadow(type: ShadowType = ShadowType.normal) {
        switch type {
        case .normal:
            self.layer.cornerRadius = 8.0
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 8.0
            self.layer.shadowOpacity = 0.2
        case .small:
            self.layer.cornerRadius = 2.0
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = 2.0
            self.layer.shadowOpacity = 0.2
        }
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 3, height: 2)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
    }
    
    func addCircularShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0)
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.15
        layer.cornerRadius = frame.width / 2
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
extension UITextView {
    func moveToVerticalCenter() {
        let topCorrection = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2.0
        self.contentInset = UIEdgeInsets(top: topCorrection, left: 0, bottom: 0, right: 0)
    }
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        
        contentOffset.y = -positiveTopOffset
        
    }
}

extension UIFont {
    var bold: UIFont {
        return with(traits: .traitBold)
    } // bold
    
    var italic: UIFont {
        return with(traits: .traitItalic)
    } // italic
    
    var boldItalic: UIFont {
        return with(traits: [.traitBold, .traitItalic])
    } // boldItalic
    
    var normal: UIFont {
        return with(traits: [])
    }
    
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        } // guard
        
        return UIFont(descriptor: descriptor, size: 0)
    } // with(traits:)
} // extension

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

extension UIViewController {
    class func displaySpinner(onView: UIView, text: String) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = text
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = textLabel.font.withSize(15)
        
        spinnerView.addSubview(ai)
        spinnerView.addSubview(textLabel)
        onView.addSubview(spinnerView)
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: spinnerView.leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: spinnerView.rightAnchor),
            textLabel.topAnchor.constraint(equalTo: ai.bottomAnchor, constant: 15),
            textLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return spinnerView
    }
    
    class func removeSpinner(spinner : UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension NSLayoutConstraint {
    func withPriority(_ p: CGFloat) -> NSLayoutConstraint {
        priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(p))
        return self
    }
}
