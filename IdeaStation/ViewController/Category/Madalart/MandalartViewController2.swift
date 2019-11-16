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
    private let scrollView: UIScrollView = UIScrollView(frame: .zero)
    private let container: UIView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        container.addSubview(collectionView)
        scrollView.addSubview(container)
        view.addSubview(scrollView)
        
        setupCollectionView()
        setupScrollView()
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
        scrollView.widthAnchor.constraint(equalTo: sizeAnchor, constant: -20).isActive = true
        scrollView.heightAnchor.constraint(equalTo: sizeAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        container.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.registerNib(MandalartCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    }
}

extension MandalartViewController2: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return container
    }
}

extension MandalartViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width / 3 - 10
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
