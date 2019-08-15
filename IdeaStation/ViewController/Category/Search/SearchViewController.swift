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
    var array = ["gkgkgk", "hohoo", "hihihi", "1231245", "gkgkgk", "hohoo", "hihihi", "1231245"]
    var pictures: [Hit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExpandableBubbleLabel()
    }
    
    private func setupExpandableBubbleLabel() {
        bubbleLabel = ExpandableBubbleLabel(superView: self.view, text: "연관 단어")
        bubbleLabel.childArray = array
        bubbleLabel.childDelegate = self
        self.view.addSubview(bubbleLabel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getPixaPictures()
    }
    
    private func getPixaPictures() {
        let params = [
            "key": API.pixabayKey,
            "q": "flower"
        ]
        
        APISource.shared.getPicturesPixay(params: params) { res in
            self.pictures = res.hits
            self.collectionView.reloadData {
                
            }
        }
    }
}

extension SearchViewController: ExpandableBubbleLabelChildDelegate {
    func childLabelTouchBegan(text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.bubbleLabel.childArray = self.array.compactMap { $0+text }
        }
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
//        var url:NSURL? = NSURL(string: imageString)
//        var data:NSData? = NSData(contentsOfURL : url!)
//        var image = UIImage(data : data!)
//        cell.imageView.image = image
        return cell
    }
    
    
}

class PixabayImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}
