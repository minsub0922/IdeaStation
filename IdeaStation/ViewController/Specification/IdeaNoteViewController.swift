//
//  IdeaNoteViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/09/25.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class IdeaNoteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ideaNoteCollectionView: UICollectionView!
    @IBOutlet weak var ideaTitle: UILabel!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        
        ideaNoteCollectionView.delegate = self
        ideaNoteCollectionView.dataSource = self
        ideaTitle.text = UserSharingData.shared.ideaTitle
        ideaNoteCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.ideaNoteCollectionView.bounds.width
        let height = self.ideaNoteCollectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = ideaNoteCollectionView.dequeueReusableCell(withReuseIdentifier: "idea-explain", for: indexPath) as! ExplainCollectionViewCell
            
            cell.inputTextView.text = UserSharingData.shared.userIdeaExplain
            return cell
        case 1:
            let cell = ideaNoteCollectionView.dequeueReusableCell(withReuseIdentifier: "user-analysis", for: indexPath) as! UserAnalysisCollectionViewCell
            
            cell.targetUserTextField.text = UserSharingData.shared.userAnalysisTarget
            cell.customerActivity.text = UserSharingData.shared.userAnalysisCustomer
            cell.uncomfortableThings.text = UserSharingData.shared.userAnalysisUncomfortable
            cell.gainThings.text = UserSharingData.shared.userAnalysisGain
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.view.endEditing(true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
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
