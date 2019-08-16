//
//  didSelectViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class DidSelectViewController: UIViewController {
    @IBOutlet weak var numberOfSelectedItemsLabel: UILabel!
    @IBOutlet weak var selectedItemsLabel: UILabel!
    
    var numberOfSelectedItems: Int = 0
    var selectedItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.numberOfSelectedItemsLabel.text = "\(numberOfSelectedItems)"
        self.selectedItemsLabel.text = "\(selectedItems)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
