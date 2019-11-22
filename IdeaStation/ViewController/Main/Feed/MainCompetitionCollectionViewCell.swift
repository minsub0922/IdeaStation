//
//  MainCompetitionCollectionViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/23.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MainCompetitionCollectionViewCell: UICollectionViewCell {
        // MARK:- view들 정의
        // titleView
        private var titleView: UIView = {
            return UIView(frame: .zero)
        } ()
        
        private var titleImageView: UIImageView = {
            let image = UIImage(named: "idea-competition")
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
        
        var bodyImageView: UIImageView = {
            let image = UIImage(named: "petfoodPackageDesignCompetition")
            let imageView = UIImageView(image: image)
            return imageView
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
            backgroundColor = .white
            addSubviews()
            setTitleView()
            setBodyView()
        }
        
        private func addSubviews() {
            addSubview(titleView)
            addSubview(bodyView)
            titleView.addSubview(titleImageView)
            titleView.addSubview(titleLabel)
            bodyView.addSubview(bodyImageView)
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
            titleLabel.text = "오늘의 공모전"
            titleLabel.textColor = .black
            titleLabel.font = titleLabel.font.withSize(20)
            addConstraintsForTitleLabel()
        }
        
        private func setBodyView(){
            addConstraintsForBodyView()
            bodyView.backgroundColor = .white
            setBodyImageView()
            setBodyLabelView()
        }
        
        private func setBodyImageView(){
            addConstraintsForBodyImageView()
        }
        
        private func setBodyLabelView(){
            bodyLabel.text = "testtextfortestsforcompetition"
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
                titleImageView.leftAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.leftAnchor, constant: 10),
                titleImageView.centerYAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.centerYAnchor),
                titleImageView.widthAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
                titleImageView.heightAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)
            ])
        }
        
        private func addConstraintsForTitleLabel(){
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: titleImageView.safeAreaLayoutGuide.rightAnchor, constant: 10),
                titleLabel.rightAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.rightAnchor),
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
                bodyView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 15),
                bodyView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        private func addConstraintsForBodyImageView(){
            bodyImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bodyImageView.topAnchor.constraint(equalTo: bodyView.safeAreaLayoutGuide.topAnchor),
                bodyImageView.leftAnchor.constraint(equalTo: bodyView.safeAreaLayoutGuide.leftAnchor),
                bodyImageView.rightAnchor.constraint(equalTo: bodyView.safeAreaLayoutGuide.rightAnchor),
                bodyImageView.widthAnchor.constraint(equalTo: bodyView.safeAreaLayoutGuide.widthAnchor),
                bodyImageView.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -10)
            ])
        }
        
        private func addConstraintsForBodyLabel(){
            bodyLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                bodyLabel.leftAnchor.constraint(equalTo: bodyView.safeAreaLayoutGuide.leftAnchor, constant: 10),
                bodyLabel.rightAnchor.constraint(equalTo: bodyView.safeAreaLayoutGuide.rightAnchor),
                bodyLabel.topAnchor.constraint(equalTo: bodyImageView.safeAreaLayoutGuide.bottomAnchor),
                bodyLabel.heightAnchor.constraint(equalToConstant: 30),
                bodyLabel.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -15)
            ])
        }
    }

