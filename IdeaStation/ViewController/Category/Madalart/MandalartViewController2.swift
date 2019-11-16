//
//  MandalartViewController2.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/16.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MandalartViewController2: UIViewController {
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.registerNib(MandalartCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let sizeAnchor = view.bounds.width > view.bounds.height ? view.heightAnchor : view.widthAnchor
        collectionView.widthAnchor.constraint(equalTo: sizeAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: sizeAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension MandalartViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 3 - 5
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
        cell.setupView(center: "hello", children: ["여자","남자","둘이","만나면","싸우기만","더하겠냐","세상살이","다그래"])
        return cell
    }
}
