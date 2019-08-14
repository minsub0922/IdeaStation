//
//  CategoryViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit
class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let array = ["gkgkgk", "hohoo", "hihihi", "1231245", "gkgkgk", "hohoo", "hihihi", "1231245"]
        let view = ExpandableBubbleLabel( superView: self.view)
        self.view.addSubview(view)
    }
}
