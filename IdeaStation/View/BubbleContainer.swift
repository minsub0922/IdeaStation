//
//  BubbleContainer.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/14.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class BubbleContainer: UIView {
    /*
     Set FontSize Depends on Bunds Size
     */
    override var bounds: CGRect {
        didSet {
            let width = bounds.width
            let maxWidthOfLabel = width/4
            let radius = width*1/2 - maxWidthOfLabel*1/2
            self.maxWidthOfLabel = maxWidthOfLabel
            self.fontSize = maxWidthOfLabel/3
            self.radius = radius
            self.setupBubblesLabelSize()
            self.setupBubbles()
        }
    }
    /*
     also can be Max Size of both Label width and height
     */
    private var fontSize: CGFloat = 0.0
    private var maxWidthOfLabel: CGFloat = 0.0
    private var radius: CGFloat = 0.0
    private var centerLabel: UILabel = UILabel()
    private var childArray: [UILabel] = []
    
    // MARK:- init
    init(frame: CGRect, centerText: String, childTextArray: [String]) {
        super.init(frame: frame)
        
        centerLabel.text = centerText
        for text in childTextArray {
            let label = UILabel()
            label.text = text
            childArray.append(label)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- SetupView
    private func setupBubbles() {
        addSubViews()
        addConstraintsForBubbles()
    }
    
    private func addSubViews() {
        addSubview(centerLabel)
        for child in childArray {
            addSubview(child)
        }
    }
    
    private func addConstraintsForBubbles() {
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        // For Adjusting Start Point
        let startTheta = Float.pi / 2
        let thetaStatus = 2 * Float.pi / Float(childArray.count)
        
        for i in 0..<childArray.count {
            let child = childArray[i]
            let theta = (startTheta + thetaStatus * Float(i+1)).truncatingRemainder(dividingBy: 2 * Float.pi)
            let x = center.x + radius * CGFloat(cos(theta))
            let y = center.y + radius * CGFloat(sin(theta))
            child.translatesAutoresizingMaskIntoConstraints = false
            child.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x).isActive = true
            child.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y).isActive = true
        }
    }
    
    // MARK:- Perform Animation
    /*
     Change Label Size (with Animation)
     */
    private func setupBubblesLabelSize() {
        centerLabel.font = centerLabel.font.withSize(fontSize)
        for child in childArray {
            child.font = child.font.withSize(fontSize)
        }
    }
    
    private func changeLabelSize(target: [UILabel], multiplyTo: CGFloat) {
        UIView.animate(withDuration: 1.0) {
            target[0].transform = CGAffineTransform(scaleX: multiplyTo, y: multiplyTo)
        }
    }
    private func resetLabelSize(target: [UILabel], backTo: CGFloat) {
        UIView.animate(withDuration: 1.0) {
            target[0].transform = CGAffineTransform(scaleX: backTo, y: backTo)
        }
    }
    
    private func hideChildren() {
        for child in childArray {
            child.isHidden = true
        }
    }
    private func showChildren() {
        for child in childArray {
            child.isHidden = false
        }
    }
}
