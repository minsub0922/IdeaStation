//
//  MandalartViewController2.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import BubbleTransition

class MandalartViewController: BaseViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerNib(MandalartCell.self)
        cv.isScrollEnabled = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    } ()
    
    private let ideaButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "ic-logo"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchupIdeaButton(_:)), for: .touchUpInside)
        button.backgroundColor = .white
//        button.isHidden = true
        button.addRounded(radius: idealButtonSize / 2)
        return button
    } ()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.delegate = self
        sv.minimumZoomScale = 1
        sv.maximumZoomScale = 2.4
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.alwaysBounceHorizontal = false
        sv.alwaysBounceVertical = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    private let container: UIView = {
        let v = UIView(frame: .zero)
        v.isUserInteractionEnabled = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let transition = BubbleTransition()
    private let interactiveTransition = BubbleInteractiveTransition()
    private var selectedTexts: [MDKeyword] = []
    private var centerKeyword: String = String()
    private var centerImageURL: String = String()
    private var keywords: [MDKeyword] {
        var keywords: [MDKeyword] = []
        keywords.append(contentsOf: selectedTexts)
        return keywords
    }
    private var mandalartKeywords: [String] = []
    private var cellCount = 0
    private var keywordsForIdea: [String] = []
    
    @IBAction func tapbackgroundAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    public func setKeywords(centerKeyword: String, centerImageURL: String, selectedTexts: [MDKeyword]) {
        self.centerKeyword = centerKeyword
        self.selectedTexts = selectedTexts
        self.centerImageURL = centerImageURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        title = "만달아트"
        setLayout()
        getMandalartKeywords()
    }
    
    
    private func getMandalartKeywords() {
        displaySpinner(text: "단어를 받아오고 있습니다.")
        getDummy()
        //getRealData()
    }
    
    private func getRealData() {
        APISource.shared.getMandalart(words: keywords.map { $0.keyword },
                                      dataSet: UserDatas.shared.dataSetIndex,
                                      completion: { mandalartKeywords in
                                        self.removeSpinner()//loading finish
                                        self.mandalartKeywords = mandalartKeywords
                                        self.cellCount = 9
                                        self.collectionView.reloadSection(section: 0)
        },
                                      failure: { code, msg in
                                        self.getDummy()
        })
    }
    
    private func getDummy() {
        self.cellCount = 9
        let words = keywords.map { $0.keyword }
        
        for i in 0..<81 {
            self.mandalartKeywords.append(words[i%words.count])
        }
        self.cellCount = 9
        self.collectionView.reloadSection(section: 0)
        
        self.removeSpinner()
    }
    
    private func setLayout() {
        view.addSubview(UIView(frame: .zero))
        view.addSubview(scrollView)
        view.addSubview(ideaButton)
    
        container.addSubview(collectionView)
        scrollView.addSubview(container)
        
        // scrollview ) container ) collectionview
       
        collectionView.snp.makeConstraints {
            $0.size.equalTo(container.snp.size)
            $0.center.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.size.equalTo(min(view.bounds.width, view.bounds.height))
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
        
        container.snp.makeConstraints {
            $0.size.equalTo(scrollView.snp.size)
            $0.center.equalToSuperview()
        }

        ideaButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-idealButtonBottomSpace)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(idealButtonSize)
        }
    }
    
    @objc private func touchupIdeaButton(_ button: UIButton) {
        let ideaVC = CreateIdeaViewController()
        ideaVC.transitioningDelegate = self
        ideaVC.modalPresentationStyle = .custom
        ideaVC.view.backgroundColor = button.backgroundColor!
        ideaVC.selectedKeywords = mandalartKeywords
        ideaVC.interactiveTransition = interactiveTransition
        interactiveTransition.attach(to: ideaVC)
        present(ideaVC, animated: true, completion: nil)
    }
}

extension MandalartViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return container
    }
}

extension MandalartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 3 - 10
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MandalartCell.self, for: indexPath)
        var centerIndex = 0
        
        switch indexPath.row {
        case 0: centerIndex = 1
        case 1: centerIndex = 2
        case 2: centerIndex = 3
        case 3: centerIndex = 8
        case 4: centerIndex = 0
        case 5: centerIndex = 4
        case 6: centerIndex = 7
        case 7: centerIndex = 6
        case 8: centerIndex = 5
        default: break
        }
        
        let centerKeyword = mandalartKeywords[centerIndex]
        let hasKeyword = keywords.filter {$0.keyword.elementsEqual(centerKeyword)}
        let centerImagePath = hasKeyword.count > 0 ? hasKeyword[0].imagePath : ""
        
        var children: [MDKeyword] = []
        
        for i in 1...8 {
            let target = mandalartKeywords[centerIndex*8+i]
            let hasKeyword = keywords.filter {$0.keyword.elementsEqual(target)}
            let imagePath = hasKeyword.count > 0 ? hasKeyword[0].imagePath : ""
            children.append(MDKeyword(keyword: target, imagePath: imagePath))
        }
        cell.setupView(center: MDKeyword(keyword: centerKeyword, imagePath: centerImagePath), children: children)
        
        cell.delegate = self
        return cell
    }
}

extension MandalartViewController: MandalartCellDelegate {
    func touchupCell(isSelected: Bool, category: String, children: [String]) {
        keywordsForIdea.append(category)
        keywordsForIdea.append(contentsOf: children)
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension MandalartViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = ideaButton.center
        transition.bubbleColor = .white
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = ideaButton.center
        transition.bubbleColor = .white
        return transition
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       return interactiveTransition
     }
}
