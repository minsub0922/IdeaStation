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
    private var containers: [UIImageView] = {
        var containers: [UIImageView] = []
        for i in 0..<9 {
            let view = UIImageView()
            let blue = UIColor.blue.withAlphaComponent(0.6)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.alpha = 0.3
            containers.append(view)
        }
        return containers
    }()
    /*
    Parameters for Memorizing
     */
    
    // MARK:- init
    init(frame: CGRect, centerText: MDKeyword, childTexts: [MDKeyword]) {
        super.init(frame: frame)
        
        initLabels(centerText: centerText, childTexts: childTexts)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- SetupView
extension Mandalart {
    fileprivate func initLabels(centerText: MDKeyword, childTexts: [MDKeyword]) {
        centerLabel.text = centerText.keyword
        centerLabel.textAlignment = .center

        for i in 0..<childCount {
            let label = UITextField()
            label.text = childTexts[i].keyword
            label.textColor = .black
            label.textAlignment = .center
            children.append(label)
            containers[i].loadImageAsyc(url: childTexts[i].imagePath)
        }
        
        containers[8].loadImageAsyc(url: centerText.imagePath)
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
            
            //container
            container.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x).isActive = true
            container.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y).isActive = true
            container.widthAnchor.constraint(equalToConstant: cellSize).isActive = true
            container.heightAnchor.constraint(equalToConstant: cellSize).isActive = true
            
            //child
            child.translatesAutoresizingMaskIntoConstraints = false
            child.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x).isActive = true
            child.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y).isActive = true
            child.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
            child.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
            
            //Adjust Font Size with LabelSize
            centerLabel.lineBreakMode = .byClipping
            centerLabel.numberOfLines = 0
            centerLabel.adjustsFontSizeToFitWidth = true
            child.adjustsFontSizeToFitWidth = true
            child.minimumFontSize = 5.0
        }
    }
    
    private func adjustedValueForTF(value: Float) -> CGFloat {
        return CGFloat(round(value))
    }
}

// Draw BezierPath
extension Mandalart {
    override func draw(_ rect: CGRect) {
        setStartPointsForDrawing(center: self.center, radius: cellSize / 2)
    }
    
    private func setStartPointsForDrawing(center: CGPoint, radius: CGFloat) {
        let startPointsDirections: [[CGFloat]] = [[1,-1],[1,1],[-1,1],[-1,-1]]
        let drawingPathDirections: [[CGFloat]] = [[0,1],[0,-1],[1,0],[-1,0]]
        let length = radius
        for pointDirection in startPointsDirections {
            let startPoint = CGPoint(x: center.x + radius * pointDirection[0],
                                     y: center.y + radius * pointDirection[1])
            for pathDirection in drawingPathDirections {
                let endPoint = CGPoint(x: startPoint.x + length * pathDirection[0],
                                       y: startPoint.y + length * pathDirection[1])
                drawPath(from: startPoint, to: endPoint)
            }
        }
        
    }
    
    private func drawPath(from: CGPoint, to: CGPoint) {
        let path = UIBezierPath()
        let arcLayer = CAShapeLayer()
        //path.lineJoinStyle = .round
        //path.usesEvenOddFillRule = true
        //시작점
        path.move(to: from)
        //path 지정
        path.addLine(to: to)
        
        arcLayer.path = path.cgPath
        arcLayer.lineWidth = 0.3
        //arcLayer.fillColor = UIColor.black.cgColor
        arcLayer.strokeColor = UIColor.black.withAlphaComponent(0.4).cgColor
        layer.addSublayer(arcLayer)
        
//        //선들을잇는작업
//        path.close()
//        //다각형을 그리는게 아니라 선분이니까 !
//        UIColor.systemGray.set()
//        path.stroke()
    }
}
