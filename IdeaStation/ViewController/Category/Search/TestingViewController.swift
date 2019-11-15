//
//  TestingViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/14.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {
    private let testLabel = UILabel()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    } ()
    fileprivate var selectedTexts: [String] = []
    fileprivate var subject = "사랑"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomTexts(subject: subject) { (strings) in
            self.setupBubbleContainer(subject: self.subject, strings: strings)
        }
        
        setupCollectionView()
    }
    
    private func setupBubbleContainer(subject: String, strings: [String]) {
        let container = BubbleContainer(frame: .zero, centerText: subject, childTextArray: strings)
        container.delegate = self
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            container.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.registerNib(SearchPathCell.self)
        collectionView.registerNib(HorizontalArrowCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

// APIS
extension TestingViewController {
    fileprivate func getRandomTexts(subject: String, completion: @escaping ([String]) -> Void) {
        let param = [
            "word": subject
        ]
        
        APISource.shared.getRandomText(params: param) { res in
            completion(res[0...8].dropLast())
        }
    }
}

extension TestingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedTexts.count * 2 - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 2 == 0 {
            return CGSize(width: 70, height: collectionView.bounds.height)
        } else {
            return CGSize(width: 15, height: 15)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCell(SearchPathCell.self, for: indexPath)
            cell.label.text = selectedTexts[indexPath.row / 2]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(HorizontalArrowCell.self, for: indexPath)
            return cell
        }
    }
}

extension TestingViewController: BubbleContainerDelegate {
    func expanded() {
        
    }
    
    func collapsed() {
        
    }
    
    func childSelected(selectedText: String, completion: @escaping ([String]) -> Void) {
        selectedTexts.append(selectedText)
        collectionView.reloadSection(section: 0)
        getRandomTexts(subject: selectedText, completion: completion)
    }
}
