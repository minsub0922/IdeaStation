//
//  MandaralartViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MandalartViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    // MARK:- 기본 변수들 선언
    let cellIdentifier: String = "mandalartCell"
    var mandalartItems: [MandalartItem] = []
    @IBOutlet weak var mandalartCollectionView: UICollectionView!
    
    // MARK: 8방향 버튼 선언 : Outlet
    @IBOutlet weak var leftUpButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var rightUpButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftDownButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var rightDownButton: UIButton!
    
    // MARK: 8방향 버튼 선언 : Action
    @IBAction func touchUpLeftUpButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        mandalartBounds.origin.x -= UIScreen.main.bounds.width
        mandalartBounds.origin.y -= UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpUpButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        //mandalartBounds.origin.x += UIScreen.main.bounds.width
        mandalartBounds.origin.y -= UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpRightUpButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        mandalartBounds.origin.x += UIScreen.main.bounds.width
        mandalartBounds.origin.y -= UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpLeftButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        mandalartBounds.origin.x -= UIScreen.main.bounds.width
        //mandalartBounds.origin.y += UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpRightButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        mandalartBounds.origin.x += UIScreen.main.bounds.width
        //mandalartBounds.origin.y += UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpLeftDownButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        mandalartBounds.origin.x -= UIScreen.main.bounds.width
        mandalartBounds.origin.y += UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpDownButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        //mandalartBounds.origin.x += UIScreen.main.bounds.width
        mandalartBounds.origin.y += UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    @IBAction func touchUpRightDownButton(_ sender: UIButton){
        var mandalartBounds: CGRect = self.mandalartCollectionView.bounds
        mandalartBounds.origin.x += UIScreen.main.bounds.width
        mandalartBounds.origin.y += UIScreen.main.bounds.height
        self.mandalartCollectionView.bounds = mandalartBounds
    }
    
    // MARK:- 영역 밖 탭해주면 키보드 내려주는거
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        print("tap tap!")
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    // MARK:- collectionView 필수구현함수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: MandalartCollectionViewCell = mandalartCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! MandalartCollectionViewCell
        
        let mandalartItem: MandalartItem = self.mandalartItems[indexPath.item]
        
        
        
        // MARK: just nogada? 다른 방법이 있을 것 같음. 리스트라던지
        cell.textField1.text = mandalartItem.mandalartText1
        cell.textField2.text = mandalartItem.mandalartText2
        cell.textField3.text = mandalartItem.mandalartText3
        cell.textField4.text = mandalartItem.mandalartText4
        cell.textField5.text = mandalartItem.mandalartText5
        cell.textField6.text = mandalartItem.mandalartText6
        cell.textField7.text = mandalartItem.mandalartText7
        cell.textField8.text = mandalartItem.mandalartText8
        cell.textField9.text = mandalartItem.mandalartText9
        
        
        
        // MARK: delegate 선언 : done누르면 키보드 내려가게 하기 위해.
        cell.textField1.delegate = self
        cell.textField2.delegate = self
        cell.textField3.delegate = self
        cell.textField4.delegate = self
        cell.textField5.delegate = self
        cell.textField6.delegate = self
        cell.textField7.delegate = self
        cell.textField8.delegate = self
        cell.textField9.delegate = self
        
        return cell
    }
    
    // MARK:- mandalartCollectionView 기본 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // MARK: textfield delegate 설정
        
        
        // MARK: mandalartCollectionView 크기 조절
        //self.mandalartCollectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        // MARK: mandalart컬렉션 뷰에 flowLayout 적용
        let mandalartFlowLayout: UICollectionViewFlowLayout
        mandalartFlowLayout = UICollectionViewFlowLayout()
        mandalartFlowLayout.sectionInset = UIEdgeInsets.zero
        mandalartFlowLayout.minimumInteritemSpacing = 10
        mandalartFlowLayout.minimumLineSpacing = 10
        mandalartFlowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width/3-10, height: UIScreen.main.bounds.height/3-10)
        print(view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        
        self.mandalartCollectionView.collectionViewLayout = mandalartFlowLayout
        
        // MARK: JSON 데이터 가져오기(에셋 폴더 안에 import해놓음)
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "mandalartItems") else{
            return
        }
        
        do{
            self.mandalartItems = try jsonDecoder.decode([MandalartItem].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.mandalartCollectionView.reloadData()
    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        var topSafeArea: CGFloat
//        var bottomSafeArea: CGFloat
//
//        let guide = view.safeAreaLayoutGuide
//        let height = guide.layoutFrame.size.height
//
//        if #available(iOS 11.0, *) {
//            topSafeArea = view.safeAreaInsets.top
//            bottomSafeArea = view.safeAreaInsets.bottom
//        } else {
//            topSafeArea = topLayoutGuide.length
//            bottomSafeArea = bottomLayoutGuide.length
//        }
//
//        // safe area values are now available to use
//        print(topSafeArea, bottomSafeArea, height)
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
