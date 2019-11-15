//
//  BubbleContainer.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/14.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

protocol BubbleContainerDelegate {
    func expanded()
    func collapsed()
    func childSelected(selectedText: String, completion: @escaping (_ childArray: [String]) -> Void)
}

class BubbleContainer: UIView {
    /*
     Set FontSize Depends on Bunds Size
     */
    public var delegate: BubbleContainerDelegate?
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
    private var selectedChildText: String = String()
    fileprivate var strings: [String] = []
    fileprivate let childCount: Int
    fileprivate var isCollapse = true
    
    // MARK:- init
    init(frame: CGRect, centerText: String, childTextArray: [String]) {
        childCount = childTextArray.count
        
        super.init(frame: frame)
        isUserInteractionEnabled = true
        centerLabel.text = centerText
        selectedChildText = centerText
        for text in childTextArray {
            let label = UILabel()
            label.alpha = 0.0
            label.text = text
            strings.append(text)
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
    
    private func setupBubblesLabelSize() {
        centerLabel.font = centerLabel.font.withSize(fontSize)
        centerLabel.addShadowOnLabel()
        for child in childArray {
            child.font = child.font.withSize(fontSize)
            child.transform = CGAffineTransform(scaleX: 0, y: 0)
            child.addShadowOnLabel()
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
            centerLabel.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
            centerLabel.lineBreakMode = .byClipping
            centerLabel.numberOfLines = 0
            centerLabel.adjustsFontSizeToFitWidth = true
            child.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
            child.lineBreakMode = .byClipping
            child.numberOfLines = 0
            child.adjustsFontSizeToFitWidth = true
        }
    }
}

// MARK:- Actions
extension BubbleContainer {
    @objc fileprivate func tapGestureRecognizer(_ recognizer: UITapGestureRecognizer) {
        guard let bubble = recognizer.view as? UILabel else {return}
        if bubble.isEqual(centerLabel) {
            // case. Center
            isCollapse ? expanded() : collapsed()
            isCollapse = !isCollapse
        } else {
            // case. Child
            selectedChildText = bubble.text ?? ""
            bubble.bounce {
                self.collapsed()
                self.delegate?.childSelected(selectedText: self.selectedChildText, completion: {(strings : [String]) in
                    UIView.animate(withDuration: 0, delay: 3, animations: {
                        for index in 0..<strings.count {
                            //let child = self.childArray[index]
                            self.strings.append(strings[index])
                            //child.text = strings[index]
                        }
                    })
                })
            }
        }
     }
}

// MARK:- Animations
extension BubbleContainer {
    // MARK:- Perform Animation
    /*
     Change Label Size (with Animation)
     */
    private func collapsed() {
        //self.layer.removeAllAnimations()
        
        UIView.transition(with: self.centerLabel,
        duration: 0.25,
        options: .transitionCrossDissolve,
        animations: { [weak self] in
              self?.centerLabel.text = self?.selectedChildText
          })
        fadeInCenter()
        fadeOutChildren() {
            for i in 0..<self.childCount {
                self.childArray[i].text = self.strings[self.strings.count-1-i]
            }
        }
    }
    private func expanded() {
        fadeOutCenter()
        fadeInChildren()
    }
    private func fadeOutCenter() {
        UIView.animate(withDuration: 0.7) {
            self.centerLabel.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            self.centerLabel.alpha = 0.3
        }
    }
    private func fadeInCenter(completion: @escaping () -> Void = {}) {
        UIView.animate(withDuration: 0.7, animations: {
            self.centerLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.centerLabel.alpha = 1
        }, completion: { _ in
            completion()
        })
    }
    private func fadeOutChildren(completion: @escaping () -> Void) {
        let wholeDuration: Double = 1.3
        UIView.animateKeyframes(withDuration: wholeDuration, delay: 0, options: [.calculationModeCubic], animations: {
            for index in 0..<self.childCount {
                let child = self.childArray[self.childCount - 1 - index]
                let startTime = Double(index)/Double(self.childCount)
                let duration = wholeDuration/Double(self.childCount) * (1 - 0.1 * Double(index))
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration) {
                    child.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    child.alpha = 0
                }
            }
        }, completion: { _ in
            completion()
        })
    }
    private func fadeInChildren() {
        let wholeDuration: Double = 1.5
        let bounceTime: Double = 0.1
        UIView.animateKeyframes(withDuration: wholeDuration+bounceTime, delay: 0, options: [.calculationModeCubic], animations: {
            for index in 0..<self.childCount {
                let child = self.childArray[index]
                let startTime = Double(index)/Double(self.childCount)
                let duration = wholeDuration/Double(self.childCount) * (1 - 0.1 * Double(index))
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration) {
                    child.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    child.alpha = 1
                }
                UIView.addKeyframe(withRelativeStartTime: startTime+duration, relativeDuration: bounceTime) {
                    child.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        })
    }
    private func hoveringChildren() {
        let wholeDuration: Double = 1
        let numberOfSeqeunce: Double = 4
        UIView.animateKeyframes(withDuration: wholeDuration, delay: 0, options: [.repeat, .autoreverse], animations: {
//            for child in self.childArray {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0/numberOfSeqeunce) {
//
//                }
//            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                
            }
        })
    }
}
