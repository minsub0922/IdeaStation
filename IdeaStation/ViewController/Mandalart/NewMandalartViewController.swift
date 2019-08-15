//
//  NewMandalartViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class NewMandalartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate {
    let cellIdentifier: String = "newMandalartCell"
    var newMandalartItems: [MandalartItem] = []
    //var moveToThisArea: Int = 5
    @IBOutlet weak var newMandalartCollectionView: UICollectionView!
    @IBAction func tapInvisibleButton(_ sender: UIButton) {
        print("taptap")
        //self.collectionView(newMandalartCollectionView, didSelectItemAt: [0, sender.tag])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewMandalartCollectionViewCell = newMandalartCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! NewMandalartCollectionViewCell
        
        let newMandalartItem: MandalartItem = self.newMandalartItems[indexPath.item]
        
        cell.textView1.text = newMandalartItem.mandalartText1
        cell.textView2.text = newMandalartItem.mandalartText2
        cell.textView3.text = newMandalartItem.mandalartText3
        cell.textView4.text = newMandalartItem.mandalartText4
        cell.textView5.text = newMandalartItem.mandalartText5
        cell.textView6.text = newMandalartItem.mandalartText6
        cell.textView7.text = newMandalartItem.mandalartText7
        cell.textView8.text = newMandalartItem.mandalartText8
        cell.textView9.text = newMandalartItem.mandalartText9
        cell.button1.tag = indexPath.item
        
        let xStart: Int = 8
        let yStart: Int = 8
        
        let xSpace: Int = 4
        let ySpace: Int = 5
        
        let xWidth: Int = 414
        let yWidth: Int = 800
        
        let oneTextViewWidth: Int = (xWidth - xSpace*25 - xStart)/9
        let oneTextViewHeight: Int = (yWidth - ySpace*25 - yStart)/9
        
        cell.textView1.frame = CGRect(
            x: xStart + xSpace,
            y: yStart + ySpace,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView2.frame = CGRect(
            x: xStart + xSpace + (oneTextViewWidth + xSpace) * 1,
            y: yStart + ySpace,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView3.frame = CGRect(
            x: xStart + xSpace + (oneTextViewWidth + xSpace) * 2,
            y: yStart + ySpace,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView4.frame = CGRect(
            x: xStart + xSpace,
            y: yStart + ySpace + (oneTextViewHeight + ySpace) * 1,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView5.frame = CGRect(
            x: xStart + xSpace + (oneTextViewWidth + xSpace) * 1,
            y: yStart + ySpace + (oneTextViewHeight + ySpace) * 1,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView6.frame = CGRect(
            x: xStart + xSpace + (oneTextViewWidth + xSpace) * 2,
            y: yStart + ySpace + (oneTextViewHeight + ySpace) * 1,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView7.frame = CGRect(
            x: xStart + xSpace,
            y: yStart + ySpace + (oneTextViewHeight + ySpace) * 2,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView8.frame = CGRect(
            x: xStart + xSpace + (oneTextViewWidth + xSpace) * 1,
            y: yStart + ySpace + (oneTextViewHeight + ySpace) * 2,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        cell.textView9.frame = CGRect(
            x: xStart + xSpace + (oneTextViewWidth + xSpace) * 2,
            y: yStart + ySpace + (oneTextViewHeight + ySpace) * 2,
            width: oneTextViewWidth,
            height: oneTextViewHeight
        )
        
        return cell
    }
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("indexPath.item : \(indexPath.item)")
        //self.moveToThisArea = indexPath.row
    }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: mandalart컬렉션 뷰에 flowLayout 적용
        let newMandalartFlowLayout: UICollectionViewFlowLayout
        newMandalartFlowLayout = UICollectionViewFlowLayout()
        newMandalartFlowLayout.sectionInset = UIEdgeInsets.zero
        newMandalartFlowLayout.minimumInteritemSpacing = 5
        newMandalartFlowLayout.minimumLineSpacing = 5
        newMandalartFlowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width/3-5, height: 750/3)
        // height에서 818은 아이폰 XR기준이므로, 방법 강구.
        
        self.newMandalartCollectionView.collectionViewLayout = newMandalartFlowLayout
        
        
        // MARK: JSON 데이터 가져오기(에셋 폴더 안에 import해놓음)
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "mandalartItems") else{
            return
        }
        
        do{
            self.newMandalartItems = try jsonDecoder.decode([MandalartItem].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.newMandalartCollectionView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewController: NewMandalartCellDetailViewController = segue.destination as? NewMandalartCellDetailViewController else {
            print("another one. not this view controller")
            return
        }
        
        guard let button: UIButton = sender as? UIButton else{
            return
        }
        let newMandalartItem: MandalartItem = self.newMandalartItems[button.tag]
        
        nextViewController.textToSet1 = newMandalartItem.mandalartText1
        nextViewController.textToSet2 = newMandalartItem.mandalartText2
        nextViewController.textToSet3 = newMandalartItem.mandalartText3
        nextViewController.textToSet4 = newMandalartItem.mandalartText4
        nextViewController.textToSet5 = newMandalartItem.mandalartText5
        nextViewController.textToSet6 = newMandalartItem.mandalartText6
        nextViewController.textToSet7 = newMandalartItem.mandalartText7
        nextViewController.textToSet8 = newMandalartItem.mandalartText8
        nextViewController.textToSet9 = newMandalartItem.mandalartText9
        nextViewController.currentArea = button.tag + 1
        
        /*
        guard let cell: NewMandalartCollectionViewCell = sender as? NewMandalartCollectionViewCell else {
            print("not this. I want cell")
            return
        }
        
        print("prepare..ing")
        nextViewController.textToSet1 = cell.textView1?.text
        nextViewController.textToSet2 = cell.textView2?.text
        nextViewController.textToSet3 = cell.textView3?.text
        nextViewController.textToSet4 = cell.textView4?.text
        nextViewController.textToSet5 = cell.textView5?.text
        nextViewController.textToSet6 = cell.textView6?.text
        nextViewController.textToSet7 = cell.textView7?.text
        nextViewController.textToSet8 = cell.textView8?.text
        nextViewController.textToSet9 = cell.textView9?.text
        
//        nextViewController.currentArea = moveToThisArea
         */
    }
    

}
