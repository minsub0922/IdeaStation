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
