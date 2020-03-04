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
    func childSelected(selectedMDKeyword: MDKeyword)
    func childDeSelected(selectedMDKeyword: MDKeyword)
    func gotoExplore(selectedMDKeyword: MDKeyword, completion: @escaping (_ childArray: [MDKeyword]) -> Void)
}

class BubbleContainer: UIView {
    /*
     Set FontSize Depends on Bunds Size
     */
    var delegate: BubbleContainerDelegate?
    var children: [MDKeyword] = [] {
        didSet {
            childCount = children.count
            initChildLabels(children: children)
        }
    }
    
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
    private var minFonSize: CGFloat {
        return fontSize * 0.5
    }
    private var maxFontSize: CGFloat {
        return fontSize * 1.3
    }
    private var maxWidthOfLabel: CGFloat = 0.0
    private var radius: CGFloat = 0.0
    private var centerLabel: UILabel = UILabel()
    private var childArray: [UILabel] = []
    private var selectedChild: MDKeyword
    fileprivate var keywords: [MDKeyword] = []
    fileprivate var childCount: Int = 0
    fileprivate var isCollapse = true
    fileprivate var isPossibleExplore: Bool = true
    
    // MARK:- init
    init(frame: CGRect, centerText: String) {
        selectedChild = MDKeyword(keyword: centerText)
        super.init(frame: frame)
        
        updateCenterLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func updateCenterLabel() {
        UIView.transition(with: self.centerLabel,
        duration: 0.25,
        options: .transitionCrossDissolve,
        animations: { [weak self] in
            self?.centerLabel.text = self?.selectedChild.keyword
          })
    }
    
    fileprivate func initChildLabels(children: [MDKeyword]) {
        centerLabel.text = selectedChild.keyword
        let children = children.shuffled()
        for child in children {
            let text = child.keyword
            let label = UILabel()
            label.alpha = 0.0
            label.text = text
            label.alpha = 0.5
            childArray.append(label)
        }
        keywords.append(contentsOf: children)
    }
    
    fileprivate func updateChildLabels() {
        for i in 0..<self.childCount {
            self.childArray[i].text = self.keywords[self.keywords.count-self.childCount+i].keyword
        }
        self.setAdjustedFontSizeForChildren()
    }
    
    public func getSubject() -> String {
        return centerLabel.text!
    }
}

// MARK:- Setup Views
extension BubbleContainer {
    // MARK:- SetupView
    private func setupBubbles() {
        addGestureRecognizer()
        addSubViews()
        addConstraintsForBubbles()
        setAdjustedFontSizeForChildren()
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
            child.font = child.font.withSize(minFonSize)
            child.transform = CGAffineTransform(scaleX: 0, y: 0)
            child.addShadowOnLabel()
        }
     }
    
    private func addGestureRecognizer() {
        centerLabel.isUserInteractionEnabled = true
        centerLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(collapseContainer(_:))))
        for child in childArray {
            child.isUserInteractionEnabled = true
            child.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectKeyword(_:))))
            child.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(exploreKeyword(_:))))
        }
    }
    
    private func addConstraintsForBubbles() {
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        centerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        centerLabel.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
        centerLabel.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
        centerLabel.lineBreakMode = .byClipping
        centerLabel.numberOfLines = 0
        centerLabel.adjustsFontSizeToFitWidth = true
        
        let startTheta = Float.pi / 2
        let thetaStatus = 2 * Float.pi / Float(childArray.count)
        for i in 0..<childArray.count {
            let childLabel = childArray[i]
            let theta = (startTheta + thetaStatus * Float(i+1)).truncatingRemainder(dividingBy: 2 * Float.pi)
            let x = center.x + radius * CGFloat(cos(theta))
            let y = center.y + radius * CGFloat(sin(theta))
            childLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x).isActive = true
            childLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y).isActive = true
            childLabel.translatesAutoresizingMaskIntoConstraints = false
            childLabel.widthAnchor.constraint(equalToConstant: maxWidthOfLabel).isActive = true
            //Adjust Font Size with LabelSize
            childLabel.heightAnchor.constraint(equalToConstant: fontSize*2).isActive = true
            childLabel.lineBreakMode = .byClipping
            childLabel.numberOfLines = 0
            childLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func setAdjustedFontSizeForChildren() {
        let gap = (maxFontSize - minFonSize) / CGFloat(childCount)
        for i in 0..<childArray.count {
            let childLabel = childArray[i]
            let rank = 8 - self.keywords[self.keywords.count - childCount + i].rank
            childLabel.font = childLabel.font.withSize(minFonSize + gap * CGFloat(rank))
        }
    }
}

// MARK:- Actions
extension BubbleContainer {
    // Explore With LongClickGesture
    @objc fileprivate func exploreKeyword(_ recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == .ended || !isPossibleExplore { return }
        isPossibleExplore = false
        guard
            let bubble = recognizer.view as? UILabel,
            let text = bubble.text
            else { return }
        selectedChild = self.keywords.filter { $0.keyword.elementsEqual(text) }.last!
        self.delegate?.gotoExplore(selectedMDKeyword: selectedChild, completion: { keywords in
            //self.keywords.append(contentsOf: keywords.shuffled())
            self.keywords = keywords.shuffled()
            self.collapsed()
        })
    }
    
    //Explore From View Controller
    public func exploreSelectedKeyword(keyword: MDKeyword) {
        self.delegate?.gotoExplore(selectedMDKeyword: keyword, completion: { keywords in
            self.selectedChild = keyword
            self.keywords.append(contentsOf: keywords.shuffled())
            self.collapsed()
        })
    }
    
    @objc fileprivate func selectKeyword(_ recognizer: UITapGestureRecognizer) {
        guard
            let bubble = recognizer.view as? UILabel,
            let index = childArray.firstIndex(of: bubble),
            let selectedText = bubble.text
            else { return }
        
        let isSelected = isBubbleSelected(index: index)
        print("index: \(index)  isSelected: \(isSelected)")
        bubble.bounce()
        bubble.changeAlphaWithAnimation(alpha: !isSelected ? 1 : 0.4)
        
        !isSelected ?
            selectBubble(text: selectedText, index: index) :
            deSelectBubble(text: selectedText, index: index)
    }
    
    @objc fileprivate func collapseContainer(_ recognizer: UITapGestureRecognizer) {
        isCollapse ? expanded() : collapsed()
        isCollapse = !isCollapse
    }
}

// MARK:- Animations
extension BubbleContainer {
    // MARK:- Perform Animation
    /*
     Change Label Size (with Animation)
     */
    private func collapsed() {
        updateCenterLabel()
        fadeInCenter()
        fadeOutChildren() {
            self.updateChildLabels()
            self.delegate?.collapsed()
            self.isPossibleExplore = true
        }
    }
    private func expanded() {
        self.delegate?.expanded()
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
        let wholeDuration: Double = 0.7
        UIView.animateKeyframes(withDuration: wholeDuration, delay: 0, options: [.calculationModeCubic], animations: {
            for index in 0..<self.childCount {
                let child = self.childArray[self.childCount-1-index]
                let startTime = Double(index)/Double(self.childCount)
                let duration = wholeDuration/Double(self.childCount) * (1 - 0.1 * Double(index))
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration) {
                    child.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    child.alpha = 0
                }
            }
        }, completion: { res in
            completion()
        })
    }
    private func fadeInChildren() {
        let wholeDuration: Double = 1
        let bounceTime: Double = 0.1
        UIView.animateKeyframes(withDuration: wholeDuration+bounceTime, delay: 0, options: [.calculationModeCubic], animations: {
            for index in 0..<self.childCount {
                let child = self.childArray[index]
                let startTime = Double(index)/Double(self.childCount)
                let duration = wholeDuration/Double(self.childCount) * (1 - 0.1 * Double(index))
                UIView.addKeyframe(withRelativeStartTime: startTime, relativeDuration: duration) {
                    child.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    //TODO
                    child.alpha = self.isBubbleSelected(index: index) ? 1 : 0.4
                }
                UIView.addKeyframe(withRelativeStartTime: startTime+duration, relativeDuration: bounceTime) {
                    child.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        })
    }
    
    private func isBubbleSelected(index: Int) -> Bool {
        return self.keywords[index].isSelected
    }
    
    private func selectBubble(text: String, index: Int) {
        self.keywords[index].isSelected = true
        self.delegate?.childSelected(selectedMDKeyword: self.keywords[index])
    }
    
    private func deSelectBubble(text: String, index: Int) {
        self.keywords[index].isSelected = false
        self.delegate?.childDeSelected(selectedMDKeyword: self.keywords[index])
    }
    
    // MARK: TODO
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
