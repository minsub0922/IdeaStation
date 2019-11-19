//
//  MainViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/10/31.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let userEmail: String = "guest@naver.com"
    private let userEmailPasswd: String = "111111"
    
    @IBOutlet weak var mainTableView: UITableView!
    
    private var feed_seed: String = "feed-seed"
    private var feed_sprout: String = "feed-sprout"
    private var feed_competition: String = "feed-competition"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SharingData.shared.postResponseArray.count == 0 {
            readPostDatabase()
            print("postdataarray.count :  \(SharingData.shared.postResponseArray.count)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        goLogin()

        // Do any additional setup after loading the view.
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.rowHeight = UITableView.automaticDimension
        
        // MARK:- guest@naver.com  111111
        
        //writePost(title: "test3", type: 1, description: "test3333333333333")
        
        //readPostDatabase()
            
        self.mainTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SharingData.shared.postResponseArray[indexPath.item].type {
        case 1:
            return 200
        case 2:
            return 350
        case 3:
            return 500
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SharingData.shared.postResponseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SharingData.shared.postResponseArray[indexPath.item].type{
        case 1:
            let cell: MainSeedTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: feed_seed, for: indexPath) as! MainSeedTableViewCell
            cell.seedDescription.text = SharingData.shared.postResponseArray[indexPath.item].description
            
            return cell
        
        case 2:
            let cell: MainSproutTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: feed_sprout, for: indexPath) as! MainSproutTableViewCell
            
            cell.sproutDescription.text = SharingData.shared.postResponseArray[indexPath.item].description
            
            return cell
            
        case 3:
            let cell: MainCompetitionTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: feed_competition, for: indexPath) as! MainCompetitionTableViewCell
            
            cell.competitionDescription.text = SharingData.shared.postResponseArray[indexPath.item].description
            
            
            return cell
            
        default:
            print("error in switch~case");
            return UITableViewCell()
        }
    }
    
    func goLogin(){
        if let user = Auth.auth().currentUser {
            print("이미 로그인 됨")
        }
        else{
            Auth.auth().signIn(withEmail: userEmail, password: userEmailPasswd) { (user, error) in
                if user != nil {
                    print("login success")
                }
                else {
                    print("login fail")
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
                    print(postData.description, postData.title, postData.type)
                    postResponseArray.append(postData)
                }
            }
            
            SharingData.shared.postResponseArray = postResponseArray
            self.mainTableView.reloadData()
            
        })
        
        print("postDataArray : \(SharingData.shared.postResponseArray.count)")
    }
    
    func writePost(title: String, type: Int, description: String){
        print("write POst")
        let postRef = SharingData.shared.FIRref.child("Post/").childByAutoId()
        let postData = PostResponse(description: "desc", title: "title", type: 1)
        postRef.setValue(postData.getDictionary())
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
