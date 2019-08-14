//
//  CustomButton.swift
//  IdeaStation
//
//  Created by 최민섭 on 13/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CustomButton: UILabelFlexible {
    var radius: CGFloat = 20
    var childArray: [String]!
    var superView: UIView!
    var timer = Timer()
    var time = 0.0
    var buttonState = ButtonState.collapse
    let startTime = 0.0
    var endTime: Double {
        return 0.5 + 0.07 * Double(self.superView.subviews.count-1)
    };
    let changeTime = 0.15
    let bounceTime = 0.5
    
    init(size: CGSize, childArray: [String], superView: UIView) {
        let center = CGPoint(x: superView.frame.size.width/2 , y: superView.frame.size.height * 0.4 )
        super.init(text: "연관단어", fontSize: 35, center: center)
        self.childArray = childArray
        self.textColor = .black
        self.changeHeight(by: 35)
        self.minimumScaleFactor = 0.6
        self.superView = superView
        setupLabels()
    }
    
    private func setupLabels() {
        radius = self.frame.height * 3
        let thetaStatus = 2 * Float.pi / Float(childArray.count)
        for i in 0..<childArray.count {
            let theta = thetaStatus * Float(i+1)
            let x = self.center.x + radius * CGFloat(cos(theta))
            let y = self.center.y + radius * CGFloat(sin(theta))
            let label = UILabelFlexible(text: childArray[i], fontSize: 35, center: CGPoint(x: x, y: y))
            label.delegate = self
            self.superView.addSubview(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomButton: ChildLabelTouchActionDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if time > startTime && time < endTime {
            return
        }
        
        let isCollapse = (buttonState == .collapse)
        time = isCollapse ? startTime : endTime
        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: isCollapse ? #selector(timerUpcase) : #selector(timerDowncase),
            userInfo: nil, repeats: true)
        isCollapse ? self.fadeOut() : self.fadeIn()
    }
    
    @objc private func timerUpcase() {
        time += 0.01
        if time <= endTime/2 {
            self.changeHeight(by: -0.3)
        }
        
        for i in 0..<superView.subviews.count - 1 {
            repectiveUpperCase(index: i)
        }
    }
    
    @objc private func timerDowncase() {
        time -= 0.015
        if time >= endTime/2 {
            self.changeHeight(by: 0.45)
        }
        for i in 0..<superView.subviews.count - 1 {
            respectiveLowerCase(index: i)
        }
    }
    
    private func repectiveUpperCase(index: Int) {
        let item = superView.subviews[index]
        let timeGap = 0.07 * Double(index)
        if time < changeTime + timeGap && time > timeGap {    // Get Bigger
            item.changeHeight(by: (time - timeGap) * 30)
        }else if time < bounceTime + timeGap && time >= changeTime + timeGap {   // Get Smaller, Bounce
            item.changeHeight(by: -(bounceTime - time + timeGap))
        }else if time > endTime {
            timer.invalidate()
            buttonState = .expanded
        }
    }
    
    private func respectiveLowerCase(index: Int) {
        let item = superView.subviews[index]
        let timeGap = 0.06 * Double(superView.subviews.count - index)
        if time < endTime - timeGap && time > endTime - timeGap - changeTime * 0.6 {
            item.changeHeight(by: -(time+timeGap) * 6 )
        }else if time < 0 {
            timer.invalidate()
            buttonState = .collapse
        }
    }
    
    func childLabelTouchBegan(text: String) {
        
    }
}

extension CustomButton {
    func changeFontColor(animation: Bool, color: UIColor) {
        UIView.animate(withDuration: animation ? 0.5 : 0.0) {
             self.textColor = color
        }
    }
    enum ButtonState {
        case collapse
        case expanded
    }
}

