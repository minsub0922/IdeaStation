//
//  IdeaNoteViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/09/25.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class IdeaNoteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var ideaNoteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        ideaNoteCollectionView.delegate = self
        ideaNoteCollectionView.dataSource = self

        super.viewDidLoad()

        let nibName = UINib(nibName: "IdeaNoteCollectionViewCell", bundle: nil)
        let nibName1 = UINib(nibName: "IdeaNoteCollectionViewCell1", bundle: nil)
        
        ideaNoteCollectionView.register(nibName, forCellWithReuseIdentifier: IdeaNoteCollectionViewCell.className)
        ideaNoteCollectionView.register(nibName1, forCellWithReuseIdentifier: IdeaNoteCollectionViewCell1.className)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        
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
            let cell = ideaNoteCollectionView.dequeueReusableCell(withReuseIdentifier: IdeaNoteCollectionViewCell.className, for: indexPath) as! IdeaNoteCollectionViewCell
            
            cell.titleLabel.text = "아이디어 설명"
//            cell.titleLabel.sizeToFit()
            cell.subtitleLabel.text = "아이디어의 이점을 포함하여 간단하게\n설명해주세요!"
//            cell.subtitleLabel.sizeToFit()
            cell.inputTextView.text = "원격으로 반려견에게 사료를 주거나 카메라를 통해 실시간으로 반려견의 상태를 확인할 수 있는 IoT 토탈케어 서비스"
            cell.inputTextView.centerVertically()
//            cell.inputTextView.sizeToFit()
            return cell
        case 1...4:
            let cell = ideaNoteCollectionView.dequeueReusableCell(withReuseIdentifier: IdeaNoteCollectionViewCell1.className, for: indexPath) as! IdeaNoteCollectionViewCell1
                        
            cell.titleLabel1.text = "5W"
//                        cell.titleLabel.sizeToFit()
            cell.subtitleLabel1.text = "육하원칙에 의거하여 아이디어를 구체화 시켜보세요!"
            //            cell.subtitleLabel.sizeToFit()
            cell.inputTextView1.text = "원격으로 반려견에게 사료를 주거나 카메라를 통해 실시간으로 반려견의 상태를 확인할 수 있는 IoT 토탈케어 서비스2222"
            cell.inputTextView1.centerVertically()
            //            cell.inputTextView.sizeToFit()
                        return cell
        default:
            return UICollectionViewCell()
        }
        
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
