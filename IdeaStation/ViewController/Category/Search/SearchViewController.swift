//
//  SearchViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var bubbleLabel: ExpandableBubbleLabel!
    var array = ["gkgkgk", "hohoo", "hihihi", "1231245", "gkgkgk", "hohoo", "hihihi", "1231245"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = [
            "key": API.pixabayKey,
            "q": "flower"
        ]
        
        APISource.shared.getPicturesPixay(params: params) { res in
            print(res)
        }
        
        
        bubbleLabel = ExpandableBubbleLabel(superView: self.view)
        bubbleLabel.childArray = array
        bubbleLabel.childDelegate = self
        self.view.addSubview(bubbleLabel)
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PixaPictures.self, for: <#T##IndexPath#>)
    }
    
    
}

class PixabayImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}
