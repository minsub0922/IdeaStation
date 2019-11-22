//
//  MainSeedCollectionViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/20.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainSeedCollectionViewCell: UICollectionViewCell {
    // MARK:- view들 정의
    // titleView
    private var titleView: UIView = {
        return UIView(frame: .zero)
    } ()
    
    private var titleImageView: UIImageView = {
        let image = UIImage(named: "idea-seed")
        let imageView = UIImageView(image: image)
        return imageView
    } ()
    
    private var titleLabel: UILabel = {
        return UILabel(frame: .zero)
    } ()
    
    // bodyView
    private var bodyView: UIView = {
        return UIView(frame: .zero)
    } ()
    
    
    var bodyLabel: UILabel = {
        return UILabel(frame: .zero)
    } ()
    
    //MARK:- start
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setView()
    }

    //MARK:- set views
    private func setView(){
        addSubviews()
        backgroundColor = .white
        setTitleView()
        setBodyView()
    }
    
    private func addSubviews(){
        addSubview(titleView)
        titleView.addSubview(titleImageView)
        titleView.addSubview(titleLabel)
        addSubview(bodyView)
        bodyView.addSubview(bodyLabel)
    }
    
    private func setTitleView(){
        addConstraintsForTitleView()
        titleView.backgroundColor = .white
        setTitleImageView()
        setTitleLabelView()
    }
    
    private func setTitleImageView(){
        addConstraintsForTitleImageView()
    }
    
    private func setTitleLabelView(){
        titleLabel.text = "오늘의 추천 시드"
        titleLabel.textColor = .black
        titleLabel.font = titleLabel.font.withSize(20)
        addConstraintsForTitleLabel()
    }
    
    private func setBodyView(){
        addConstraintsForBodyView()
        bodyView.backgroundColor = .white
        setBodyLabelView()
    }
    
    
    private func setBodyLabelView(){
        bodyLabel.text = "testtextfortests"
        bodyLabel.textColor = .black
        bodyLabel.font = bodyLabel.font.withSize(17)
        addConstraintsForBodyLabel()
    }
    
    
    //MARK:- addConstraints
    //titleView
    private func addConstraintsForTitleView(){
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.leftAnchor.constraint(equalTo: super.safeAreaLayoutGuide.leftAnchor),
            titleView.rightAnchor.constraint(equalTo: super.safeAreaLayoutGuide.rightAnchor),
            titleView.topAnchor.constraint(equalTo: super.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addConstraintsForTitleImageView(){
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 10),
            titleImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleImageView.widthAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            titleImageView.heightAnchor.constraint(equalTo: titleView.heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func addConstraintsForTitleLabel(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: titleImageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: titleView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor)
        ])
    }
    
    //bodyView
    private func addConstraintsForBodyView(){
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            bodyView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            bodyView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            bodyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addConstraintsForBodyLabel(){
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 10),
            bodyLabel.rightAnchor.constraint(equalTo: bodyView.rightAnchor),
            bodyLabel.topAnchor.constraint(equalTo: bodyView.topAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
        ])
    }
}
