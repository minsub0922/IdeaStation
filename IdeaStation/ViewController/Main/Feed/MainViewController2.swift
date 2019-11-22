//
//  MainViewController2.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/20.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Firebase

class MainViewController2: UIViewController {
    
    private let userEmail: String = "guest@naver.com"
    private let userEmailPasswd: String = "111111"
    private var feedLabel: UILabel = UILabel()
    
    var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView_ = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView_.backgroundColor = .white
        collectionView_.translatesAutoresizingMaskIntoConstraints = false
        return collectionView_
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SharingData.shared.postResponseArray.count == 0 {
            readPostDatabase()
        }
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        goLogin()
        setupView()
        mainCollectionView.reloadData()
    }
    
    private func setupView() {
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "피드", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "피드"
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        //Register Nib
        mainCollectionView.registerNib(MainSeedCollectionViewCell.self) // 이런식으로 Register Nib해주면 바로 쓸 수 있음. extension참고
        mainCollectionView.registerNib(MainSproutCollectionViewCell.self)
        mainCollectionView.registerNib(MainCompetitionCollectionViewCell.self)
        
        //Set Delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        view.addSubview(mainCollectionView)
        NSLayoutConstraint.activate([
            mainCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func calculateHeight(titleHeight: CGFloat, descriptionHeight: CGFloat, imageHeight: CGFloat) -> CGFloat{
        let space: CGFloat = 30 // 여백
        let height = titleHeight + descriptionHeight + imageHeight + space
        return height
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

extension MainViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SharingData.shared.postResponseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SharingData.shared.postResponseArray[indexPath.item].type {
        case 1:
            let cell: MainSeedCollectionViewCell = mainCollectionView.dequeueReusableCell(MainSeedCollectionViewCell.self, for: indexPath)
            cell.bodyLabel.text = SharingData.shared.postResponseArray[indexPath.item].description
            return cell
        case 2:
            let cell: MainSproutCollectionViewCell = mainCollectionView.dequeueReusableCell(MainSproutCollectionViewCell.self, for: indexPath)
            cell.bodyLabel.text = SharingData.shared.postResponseArray[indexPath.item].description
            return cell
        case 3:
            let cell: MainCompetitionCollectionViewCell = mainCollectionView.dequeueReusableCell(MainCompetitionCollectionViewCell.self, for: indexPath)
            cell.bodyLabel.text = SharingData.shared.postResponseArray[indexPath.item].description
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch SharingData.shared.postResponseArray[indexPath.item].type {
        case 1:
            if UIDevice().userInterfaceIdiom == .phone {    // Case .phone
                let width = self.mainCollectionView.bounds.width
                return CGSize(width: width, height: width * 0.32)
            } else {    // Case .pad
                let width = self.mainCollectionView.bounds.width / 3 - 10
                return CGSize(width: width / 3 - 10, height: width * 0.32)
            }
        case 2:
            if UIDevice().userInterfaceIdiom == .phone {    // Case .phone
                let width = self.mainCollectionView.bounds.width
                return CGSize(width: width, height: width*0.8)
            } else {    // Case .pad
                let width = self.mainCollectionView.bounds.width / 3 - 10
                return CGSize(width: width, height: width*0.8)
            }
        case 3:
            if UIDevice().userInterfaceIdiom == .phone {    // Case .phone
                let width = self.mainCollectionView.bounds.width
                return CGSize(width: width, height: width*1.4)
            } else {    // Case .pad
                let width = self.mainCollectionView.bounds.width / 3 - 10
                return CGSize(width: width, height: width*1.4)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch SharingData.shared.postResponseArray[indexPath.item].type {
        case 1:
            let target = UIStoryboard(name: "MainFeedPage", bundle: nil).instantiateViewController(withIdentifier: SeedDetailViewController.className) as! SeedDetailViewController
            target.seedLabel.text = SharingData.shared.postResponseArray[indexPath.item].description
            //self.navigationController?.pushViewController(target, animated: true)
            present(target, animated: true, completion: nil)
        case 2:
            let target = UIStoryboard(name: "MainFeedPage", bundle: nil).instantiateViewController(withIdentifier: SproutDetailViewController.className) as! SproutDetailViewController
            target.titleTextView.text = SharingData.shared.postResponseArray[indexPath.item].description
            //self.navigationController?.pushViewController(target, animated: true)
            present(target, animated: true, completion: nil)
        case 3:
            let target = UIStoryboard(name: "MainFeedPage", bundle: nil).instantiateViewController(withIdentifier: CompetitionDetailViewController.className) as! CompetitionDetailViewController
            target.titleTextView.text = SharingData.shared.postResponseArray[indexPath.item].description
            //self.navigationController?.pushViewController(target, animated: true)
            present(target, animated: true, completion: nil)
        default :
            print("error")
        }
    }
}

extension MainViewController2 {
    func goLogin(){
        if let _ = Auth.auth().currentUser {
//            print("이미 로그인 됨")
        }
        else{
            Auth.auth().signIn(withEmail: userEmail, password: userEmailPasswd) { (user, error) in
                if user != nil {
//                    print("login success")
                }
                else {
//                    print("login fail")
                }
            }
        }
    }
    
    func readPostDatabase(){
        
        let postRef = SharingData.shared.FIRref.child("Post")
        
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var postResponseArray = [PostResponse]()
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot  else { return }
                let value = snap.value as? NSDictionary
                if
                    let description = value?["description"] as? String,
                    let title = value?["title"] as? String,
                    let type = value?["type"] as? Int {
                    let postData = PostResponse(description: description, title: title, type: type)
//                    print(postData.description, postData.title, postData.type)
                    postResponseArray.append(postData)
                }
            }
            
            SharingData.shared.postResponseArray = postResponseArray
            self.mainCollectionView.reloadData()
        })
        
//        print("postDataArray : \(SharingData.shared.postResponseArray.count)")
    }
    
    func writePost(title: String, type: Int, description: String){
//        print("write POst")
        let postRef = SharingData.shared.FIRref.child("Post/").childByAutoId()
        let postData = PostResponse(description: "desc", title: "title", type: 1)
        postRef.setValue(postData.getDictionary())
    }
}
