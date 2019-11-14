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
            self.hideChildren()
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
    private var selectedChildText: String = String()
    
    // MARK:- init
    init(frame: CGRect, centerText: String, childTextArray: [String]) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
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
}

// MARK:- Setup Views
extension BubbleContainer {
    // MARK:- SetupView
    private func setupBubbles() {
        addGestureRecognizer()
        addSubViews()
        addConstraintsForBubbles()
    }
    
    private func addSubViews() {
        addSubview(centerLabel)
        for child in childArray {
            addSubview(child)
        }
    }
    
    private func addGestureRecognizer() {
        centerLabel.isUserInteractionEnabled = true
        centerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:))))
        for child in childArray {
            child.isUserInteractionEnabled = true
            child.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:))))
        }
    }
    
    private func addConstraintsForBubbles() {
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        centerLabel.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
        
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
            child.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
            //Adjust Font Size with LabelSize
            child.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
            child.lineBreakMode = .byClipping
            child.numberOfLines = 0
            child.adjustsFontSizeToFitWidth = true
        }
    }
}

// MARK:- Actions
extension BubbleContainer {
    @objc fileprivate func tapGestureRecognizer(_ bubble: UITapGestureRecognizer) {
        print("what the fuct !")
//         if bubble.isEqual(centerLabel) {
//            // case. Center
//            childArray[0].isHidden ? showChildren() : hideChildren()
//         } else {
//            // case. Child
//            selectedChildText = bubble.text ?? ""
//            bubble.bounce {
//                //TODO
//            }
//         }
     }
}

// MARK:- Animations
extension BubbleContainer {
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
    private func changeLabelSize(target: [UILabel], multiplyTo: CGFloat, willBeDisappear: Bool) {
        UIView.animate(withDuration: 1.0, animations: {
            target[0].transform = CGAffineTransform(scaleX: multiplyTo, y: multiplyTo)
        }) { _ in
            if willBeDisappear {
                target[0].transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }
    }
    private func resetLabelSize(target: [UILabel], backTo: CGFloat) {
        UIView.animate(withDuration: 1.0) {
            target[0].transform = CGAffineTransform(scaleX: backTo, y: backTo)
        }
    }
}

// Simple Fucs
extension BubbleContainer {
    // MARK:- Set Visibillity
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
