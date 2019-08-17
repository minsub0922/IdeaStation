//
//  NewMandalartCellDetailViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import QuartzCore


class NewMandalartCellDetailViewController: UIViewController {
    @IBOutlet weak var detailTextView1: UITextView!
    @IBOutlet weak var detailTextView2: UITextView!
    @IBOutlet weak var detailTextView3: UITextView!
    @IBOutlet weak var detailTextView4: UITextView!
    @IBOutlet weak var detailTextView5: UITextView!
    @IBOutlet weak var detailTextView6: UITextView!
    @IBOutlet weak var detailTextView7: UITextView!
    @IBOutlet weak var detailTextView8: UITextView!
    @IBOutlet weak var detailTextView9: UITextView!
    
    @IBOutlet weak var leftUpButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var rightUpButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftDownButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var rightDownButton: UIButton!
    
    @IBOutlet weak var returnToBackButton: UIButton!
    
    @objc func popBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func popToArea(moveTo: Int) {
        navigationController?.popViewController(animated: true)
        //let tempBut: UIButton
        //tempBut.tag = 3
        //navigationController?.topViewController?.prepare(for: AnyClass, sender: tempBut)
    }
    
    @IBAction func touchUpLeftUpButton(_ sender: UIButton) {
        self.popBack()
        //presentingViewController.
    }
    @IBAction func touchUpUpButton(_ sender: UIButton) {
        
    }
    @IBAction func touchUpRightUpButton(_ sender: UIButton) {
        
    }
    @IBAction func touchUpLeftButton(_ sender: UIButton) {
        
    }
    @IBAction func touchUpRightButton(_ sender: UIButton) {
        
    }
    @IBAction func touchUpLeftDownButton(_ sender: UIButton) {
        
    }
    @IBAction func touchUpDownButton(_ sender: UIButton) {
        
    }
    @IBAction func touchUpRightDownButton(_ sender: UIButton) {
        
    }
    
    
    public var currentArea: Int = 5 // 1부터 9까지 값을 가짐. button tag + 1

    var textToSet1: String?
    var textToSet2: String?
    var textToSet3: String?
    var textToSet4: String?
    var textToSet5: String?
    var textToSet6: String?
    var textToSet7: String?
    var textToSet8: String?
    var textToSet9: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(navigationController?.viewControllers.count ?? 0)
        
        self.detailTextView1.text = textToSet1
        self.detailTextView2.text = textToSet2
        self.detailTextView3.text = textToSet3
        self.detailTextView4.text = textToSet4
        self.detailTextView5.text = textToSet5
        self.detailTextView6.text = textToSet6
        self.detailTextView7.text = textToSet7
        self.detailTextView8.text = textToSet8
        self.detailTextView9.text = textToSet9
        
        var detailTextViews: [UITextView] = []
        detailTextViews.append(self.detailTextView1)
        detailTextViews.append(self.detailTextView2)
        detailTextViews.append(self.detailTextView3)
        detailTextViews.append(self.detailTextView4)
        detailTextViews.append(self.detailTextView5)
        detailTextViews.append(self.detailTextView6)
        detailTextViews.append(self.detailTextView7)
        detailTextViews.append(self.detailTextView8)
        detailTextViews.append(self.detailTextView9)
        
        for i in detailTextViews {
            i.layer.borderWidth = 1.0
            i.layer.borderColor = UIColor.black.cgColor
            i.addRounded()
        }
        // Do any additional setup after loading the view.
        
        var buttons: [UIButton] = []
        buttons.append(self.leftUpButton)
        buttons.append(self.upButton)
        buttons.append(self.rightUpButton)
        buttons.append(self.leftButton)
        buttons.append(self.rightButton)
        buttons.append(self.leftDownButton)
        buttons.append(self.downButton)
        buttons.append(self.rightDownButton)
        
        if currentArea != 5 {
            for i in 0...7 {
                buttons[i].isHidden = true
            }
            if currentArea < 5 {
                buttons[8 - currentArea].isHidden = false
            }
            else {
                buttons[9 - currentArea].isHidden = false
            }
        }
        
        
        for i in 0...7 {
            //buttons[i].addTarget(self, action: #selector(popBack), for: .touchUpInside)
        }
        self.returnToBackButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        
        
        /*
         currentArea -> buttons[i]
         1 -> 7
         2 -> 6
         3 -> 5
         4 -> 4
         6 -> 3
         7 -> 2
         8 -> 1
         9 -> 0
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
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
