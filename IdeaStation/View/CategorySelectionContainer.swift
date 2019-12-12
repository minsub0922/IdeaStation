//
//  CategorySelectionContainer.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/12/12.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

enum CategoryType {
    case userFavor
    case dataSet
}

class CategorySelectionContainer: UIView {
    private var categories: [String] = []
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    public var selectedCategories: [String] = []
    
    public func setupView(type: CategoryType) {
        switch type {
        case .userFavor:
            self.categories = ["정치", "경제", "사회", "생활", "문화", "과학", "공학"]
        case .dataSet:
            self.categories = ["Wiki","News","Kipris"]
        }
        
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(CategorySelectionContainerCell.self)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension CategorySelectionContainer: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CategorySelectionContainerCell.self, for: indexPath)
        cell.label.text = self.categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2 - 5
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCategories.append(self.categories[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.selectedCategories.removeAll { $0 == self.categories[indexPath.row] }
    }
}

