//
//  MandalartViewController2.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MandalartViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = .init(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let ideaButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("조합하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchupIdeaButton(_:)), for: .touchUpInside)
        return button
    }()
    private let scrollView: UIScrollView = UIScrollView(frame: .zero)
    private let container: UIView = UIView(frame: .zero)
    private var selectedTexts: [MDKeyword] = []
    private var centerKeyword: String = String()
    private var centerImageURL: String = String()
    private var keywords: [MDKeyword] {
        //if selectedTexts.count == 0 { return ["이게사랑인가요","이제다시","사랑에연습이있었다면"]}
        var keywords: [MDKeyword] = []
        keywords.append(MDKeyword(keyword: centerKeyword))
        keywords.append(contentsOf: selectedTexts)
        return keywords
    }
    
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
        setupView()
    }
    
    private func setupView() {
        view.addSubview(UIView(frame: .zero))
        container.addSubview(collectionView)
        scrollView.addSubview(container)
        view.addSubview(scrollView)
        
        setupCollectionView()
        setupScrollView()
        setupButtons()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    private func setupButtons() {
        ExitButton(on: navigationController!.navigationBar, target: self)
        view.addSubview(ideaButton)
        
        ideaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        ideaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ideaButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7).isActive = true
        ideaButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2.4
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let sizeAnchor = view.bounds.width > view.bounds.height ? view.heightAnchor : view.widthAnchor
        scrollView.widthAnchor.constraint(equalTo: sizeAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: sizeAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        container.isUserInteractionEnabled = true
    }
    
    private func setupCollectionView() {
        collectionView.registerNib(MandalartCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
    
    @objc private func touchupIdeaButton(_ button: UIButton) {
        
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MandalartCell.self, for: indexPath)
        let section = indexPath.section
        let centerIndex = section * 9 % keywords.count
        var children: [MDKeyword] = []
        for i in 1...8 {
            children.append(keywords[(centerIndex+i) % keywords.count])
        }
        cell.setupView(center: MDKeyword(keyword: keywords[centerIndex].keyword, imagePath: centerImageURL), children: children)
        cell.delegate = self
        return cell
    }
}

extension MandalartViewController: MandalartCellDelegate {
    func touchupCell(isSelected: Bool, category: String, children: [String]) {
        print(children)
    }
}
