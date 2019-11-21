//
//  MainSeedCollectionViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/20.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainSeedCollectionViewCell: UICollectionViewCell {
    
    private var titleView: UIView = {
        return UIView(frame: .zero)
    } ()
    
    private var titleImageView: UIImageView = {
        let image = UIImage(named: "idea-seed")
        let imageView = UIImageView(image: image)
        return imageView
    } ()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setView()
    }

    private func setView(){
        setTitleView()
    }
    
    private func setTitleView(){
        super.addSubview(titleView)
        addConstraintForTitleView(uiView: titleView)
        let titleImageView: UIImageView = {
            let image = UIImage(named: "idea-seed")
            let imageView = UIImageView(image: image)
            return imageView
        } ()
        super.addSubview(titleImageView)
        addConstraintsForTitleImageView(imageView: titleImageView)
    }
    
    private func addConstraintsForTitleImageView(imageView: UIImageView){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.leftAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func addConstraintForTitleView(uiView: UIView){
        uiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiView.leftAnchor.constraint(equalTo: super.safeAreaLayoutGuide.leftAnchor),
            uiView.rightAnchor.constraint(equalTo: super.safeAreaLayoutGuide.rightAnchor),
            uiView.topAnchor.constraint(equalTo: super.safeAreaLayoutGuide.topAnchor),
            uiView.heightAnchor.constraint(equalTo: super.safeAreaLayoutGuide.heightAnchor, multiplier: 2/5)
        ])
    }
}
