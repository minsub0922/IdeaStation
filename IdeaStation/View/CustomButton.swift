//
//  CustomButton.swift
//  IdeaStation
//
//  Created by 최민섭 on 13/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    var radius: CGFloat = 50.0
    var childArray: [String]!
    var superView: UIView!
    var timer = Timer()
    var time = 0.0
    var buttonState = ButtonState.collapse
    
    init(size: CGSize, childArray: [String], superView: UIView) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.center = CGPoint(x: superView.frame.size.width/2 , y: superView.frame.size.height/2 )
        self.childArray = childArray
        self.setTitle("연관 단어", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.sizeToFit()
        self.superView = superView
        setupLabels()
    }
    
    private func setupLabels() {
        radius = self.frame.width * 1.5
        let thetaStatus = 2 * Float.pi / Float(childArray.count)
        for i in 0..<childArray.count {
            let theta = thetaStatus * Float(i+1)
            let x = self.center.x + radius * CGFloat(cos(theta))
            let y = self.center.y + radius * CGFloat(sin(theta))
            
            let label = UILabelFlexible(text: childArray[i], fontSize: 40, center: CGPoint(x: x, y: y))
            self.superView.addSubview(label)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if time > 0.0 && time < 0.5 {
            return
        }
        let selector = (buttonState == .collapse) ? #selector(timerUpcase) : #selector(timerDowncase)
        time = (buttonState == .collapse) ? 0.0 : 0.5
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: selector, userInfo: nil, repeats: true)
        //self.rotate(to: 2 * CGFloat.pi)
        //self.pulse()
    }
    
   
    @objc private func timerUpcase() {
        if time < 0.15 {
            time += 0.01
            for i in superView.subviews {
                if i is UILabelFlexible {
                    let center = i.center
                    i.frame = CGRect(x: 0, y: 0, width: i.frame.width, height: i.frame.height + CGFloat(time*25))
                    i.center = center
                }
            }
            self.alpha = CGFloat(1 - time * 3)
        }
        else if time < 0.5 {
            time += 0.01
            for i in superView.subviews {
                if i is UILabelFlexible {
                    let center = i.center
                    i.frame = CGRect(x: 0, y: 0, width: i.frame.width, height: i.frame.height - (0.5-CGFloat(time)))
                    i.center = center
                }
            }
        }
        else {
            timer.invalidate()
            buttonState = .expanded
        }
    }
    
    @objc private func timerDowncase() {
        if time > 0 {
            time -= 0.01
            for i in superView.subviews {
                if i is UILabelFlexible {
                    let center = i.center
                    let height = i.frame.height - CGFloat((0.5-time)*20) > 0 ? i.frame.height - CGFloat((0.5-time)*20) : 0
                    i.frame = CGRect(x: 0, y: 0, width: i.frame.width, height: height)
                    i.center = center
                }
            }
            self.alpha = CGFloat((1 - time * 7/5 ))
        } else {
            timer.invalidate()
            buttonState = .collapse
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ButtonState {
        case collapse
        case expanded
    }
}

