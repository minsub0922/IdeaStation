//
//  SearchViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var bubbleLabel: ExpandableBubbleLabel!
    var array = ["발톱", "똥", "강아지", "여우", "여자", "사료", "병원", "수의사"]
    var pictures: [Hit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupExpandableBubbleLabel()
    }
    
    private func setupExpandableBubbleLabel() {
        bubbleLabel = ExpandableBubbleLabel(superView: self.view, text: "고양이")
        bubbleLabel.childArray = array
        bubbleLabel.expandableDelegate = self
        self.view.addSubview(bubbleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let subject = bubbleLabel.text {
            getPixaPictures(subject: subject)
        }
    }
    
    private func getPixaPictures(subject: String) {
        self.collectionView.isHidden = true
        
        let params = [
            "key": API.pixabayKey,
            "q": subject
        ]
        
        APISource.shared.getPicturesPixay(params: params) { res in
            self.pictures = res.hits
            self.collectionView.performBatchUpdates({
                self.collectionView.isHidden = false
                self.collectionView.reloadSections(IndexSet(0...0))
            }, completion: nil)
        }
        
        let param = [
            "word": "고양이"
        ]
        
        APISource.shared.getRandomText(params: param) { res in
            
        }
    }
}

extension SearchViewController: ExpandableBubbleLabelDelegate {
    func updateChildArray(coreText: String) {
        getPixaPictures(subject: coreText)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.bubbleLabel.childArray = self.array.compactMap { $0+coreText }
//        }
    }
    
    func beganExpanded() {
        self.collectionView.fadeOut(until: 0.0)
    }
    
    func beganCollapsed() {
        self.collectionView.fadeIn()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(PixabayImageCell.self, for: indexPath) as? PixabayImageCell else {
            return UICollectionViewCell()
        }
        
        let picture = pictures[indexPath.row]
        cell.imageView.loadImageAsyc(url: picture.previewURL)
        cell.imageView.addRounded()
        return cell
    }
}

class PixabayImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: FasterImageView!
    override var bounds: CGRect {
        didSet {
            self.setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 16.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 16.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 3, height: 2)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
    }
}
