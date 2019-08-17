//
//  InterestViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 16/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class InterestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let cellIdentifier: String = "interestCell"
    var interestItems: [InterestItem] = []
    var selectedItemsSet = Set<String>()
    
    @IBOutlet weak var interestCollectionView: UICollectionView!
    
    @IBAction func touchUpDoneButton(_ sender: UIBarButtonItem) {
        //navigationController?.pushViewController(DidSelectViewController, animated: true)
    }
    func selectCell(_ sender: Any?) -> Void {
        guard let cell: InterestCollectionViewCell = sender as? InterestCollectionViewCell else {
            print("another cell to select")
            return
        }
        if cell.checked == false {
            cell.backgroundColor = UIColor.gray
            cell.checked = true
            guard let interestLabelText: String = cell.interestLabel.text else {
                return
            }
            
            self.selectedItemsSet.insert(interestLabelText)
        }
        else {
            cell.backgroundColor = UIColor.clear
            cell.checked = false
            guard let interestLabelText: String = cell.interestLabel.text else {
                return
            }
            
            if selectedItemsSet.contains(interestLabelText) {
                guard let interestLabelTextToRemove: String = cell.interestLabel.text else {
                    return
                }
                
                self.selectedItemsSet.remove(interestLabelTextToRemove)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: InterestCollectionViewCell = interestCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        let interestItem: InterestItem = self.interestItems[indexPath.item]
        
        cell.interestLabel.text = interestItem.interestItem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectCell(interestCollectionView.cellForItem(at: indexPath))
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interestFlowLayout: UICollectionViewFlowLayout
        interestFlowLayout = UICollectionViewFlowLayout()
        interestFlowLayout.sectionInset = UIEdgeInsets.zero
        interestFlowLayout.minimumInteritemSpacing = 10
        interestFlowLayout.minimumLineSpacing = 15
        interestFlowLayout.estimatedItemSize = CGSize(width : UIScreen.main.bounds.width/2-10, height: UIScreen.main.bounds.width/2-10)
        
        self.interestCollectionView.collectionViewLayout = interestFlowLayout
        
        // MARK: JSON 데이터 가져오기(에셋 폴더 안에 import해놓음)
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "interestItems") else{
            return
        }
        
        do{
            self.interestItems = try jsonDecoder.decode([InterestItem].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.interestCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewController: DidSelectViewController = segue.destination as? DidSelectViewController else {
            return
        }
        nextViewController.numberOfSelectedItems = self.selectedItemsSet.count
        
        for i in selectedItemsSet.sorted() {
            nextViewController.selectedItems.append(i)
        }
    }
    
}
