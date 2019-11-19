//
//  Mandalart.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class Mandalart: UIView {
    override var bounds: CGRect {
        didSet {
            let width = bounds.width
            let maxWidthOfLabel = width/3
            self.cellSize = width/3 - 2
            self.radius = width*1/2 - maxWidthOfLabel*1/2
            self.maxWidthOfLabel = maxWidthOfLabel - 10
            self.fontSize = self.maxWidthOfLabel/3
            self.setupLabelSize()
            self.setupCells()
        }
    }
    /*
     also can be Max Size of both Label width and height
     */
    private var cellSize: CGFloat = 0.0
    private var fontSize: CGFloat = 0.0
    private var maxWidthOfLabel: CGFloat = 0.0
    private var radius: CGFloat = 0.0
    private var centerLabel: UILabel = UILabel()
    private let childCount = 8
    private var children: [UITextField] = []
    private var containers: [UIView] = {
        var containers: [UIView] = []
        for i in 0..<9 {
            let view = UIView()
            let blue = UIColor.blue.withAlphaComponent(0.6)
            view.backgroundColor = blue
            containers.append(view)
        }
        return containers
    }()
    /*
    Parameters for Memorizing
     */
    
    // MARK:- init
    init(frame: CGRect, centerText: String, childTexts: [String]) {
        super.init(frame: frame)
        
        initLabels(centerText: centerText, childTexts: childTexts)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- SetupView
extension Mandalart {
    fileprivate func initLabels(centerText: String, childTexts: [String]) {
        centerLabel.text = centerText
        centerLabel.textAlignment = .center

        for i in 0..<childCount {
            let label = UITextField()
            label.text = childTexts[i]
            label.textColor = .black
            label.textAlignment = .center
            children.append(label)
        }
    }
    
    fileprivate func setupCells() {
        addSubViews()
        addConstraintsForLabels()
    }
    
    private func addSubViews() {
        for container in containers {
            addSubview(container)
        }
        addSubview(centerLabel)
        for child in children {
            addSubview(child)
        }
    }
    
    private func setupLabelSize() {
        centerLabel.font = centerLabel.font.withSize(fontSize)
        for child in children {
            //child.font = child.font.withSize(fontSize)
            child.font = child.font?.withSize(fontSize)
        }
    }
    
    private func addConstraintsForLabels() {
        containers[8].translatesAutoresizingMaskIntoConstraints = false
        containers[8].centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        containers[8].centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containers[8].widthAnchor.constraint(equalToConstant: cellSize).isActive = true
        containers[8].heightAnchor.constraint(equalToConstant: cellSize).isActive = true
        
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        centerLabel.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
        centerLabel.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
        
        
        let thetaStatus = 2 * Float.pi / Float(childCount)
        for i in 0..<childCount {
            let child = children[i]
            let theta = (thetaStatus * Float(i+1)).truncatingRemainder(dividingBy: 2 * Float.pi)
            
            let x = radius * adjustedValueForTF(value: cos(theta))
            let y = radius * adjustedValueForTF(value: sin(theta))
            let container = containers[i]
            container.translatesAutoresizingMaskIntoConstraints = false
            container.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x).isActive = true
            container.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y).isActive = true
            container.widthAnchor.constraint(equalToConstant: cellSize).isActive = true
            container.heightAnchor.constraint(equalToConstant: cellSize).isActive = true
            
            child.translatesAutoresizingMaskIntoConstraints = false
            child.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x).isActive = true
            child.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y).isActive = true
            child.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
            child.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
            
            //Adjust Font Size with LabelSize
            centerLabel.lineBreakMode = .byClipping
            centerLabel.numberOfLines = 0
            centerLabel.adjustsFontSizeToFitWidth = true
//            child.lineBreakMode = .byClipping
//            child.numberOfLines = 0
            child.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func adjustedValueForTF(value: Float) -> CGFloat {
        return CGFloat(round(value))
    }
}
