//
//  MainViewController2.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/20.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainViewController2: UIViewController {
    
    private let upperView: UIView = {
        let uiview = UIView(frame: .zero)
        uiview.translatesAutoresizingMaskIntoConstraints = false
        return uiview
    } ()
    
    private let feedLabel: UILabel = UILabel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView_ = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView_.backgroundColor = .white
        collectionView_.translatesAutoresizingMaskIntoConstraints = false
        return collectionView_
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView() {
        setupUpperView()
        setupCollectionView()
    }
    
    private func setupUpperView(){ // 피드 들어있는거도 뷰긴 뷰니깐,,
        view.addSubview(upperView)
        upperView.addSubview(feedLabel)
        feedLabel.translatesAutoresizingMaskIntoConstraints = false
        feedLabel.text = "피드"
        feedLabel.textColor = .black
        feedLabel.backgroundColor = .white
        NSLayoutConstraint.activate([
            upperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            upperView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            upperView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            upperView.heightAnchor.constraint(equalToConstant: 70),
            
            feedLabel.leftAnchor.constraint(equalTo: upperView.safeAreaLayoutGuide.leftAnchor),
            feedLabel.rightAnchor.constraint(equalTo: upperView.safeAreaLayoutGuide.rightAnchor),
            feedLabel.topAnchor.constraint(equalTo: upperView.safeAreaLayoutGuide.topAnchor),
            feedLabel.bottomAnchor.constraint(equalTo: upperView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        //Register Nib
        collectionView.registerNib(MainSeedCollectionViewCell.self) // 이런식으로 Register Nib해주면 바로 쓸 수 있음.
        
        //Set Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: upperView.safeAreaLayoutGuide.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func calculateHeight(titleHeight: CGFloat, descriptionHeight: CGFloat, imageHeight: CGFloat) -> CGFloat{
        let space: CGFloat = 20 // 여백
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

extension MainViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MainSeedCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = calculateHeight(titleHeight: 40, descriptionHeight: 25, imageHeight: 0)
        if UIDevice().userInterfaceIdiom == .phone {    // Case .phone
            return CGSize(width: self.collectionView.bounds.width, height: height)
        } else {    // Case .pad
            return CGSize(width: self.collectionView.bounds.width / 3 - 10, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}
