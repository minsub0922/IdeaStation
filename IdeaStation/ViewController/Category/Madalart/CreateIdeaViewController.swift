//
//  CreateIdeaViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/23.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import BubbleTransition

class CreateIdeaViewController: UIViewController {
    private let ideaButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = button.titleLabel?.font.withSize(30)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightText.cgColor
        //demo
        button.setTitle("공기 순환 가로등", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(touchupIdeaLabel(_:)), for: .touchUpInside)
        return button
    } ()
    private let refreshButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "ic-search-refresh"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchupRefreshButton(_:)), for: .touchUpInside)
        return button
    } ()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    private var ideaList: [String] {
        return UserDefaults.standard.stringArray(forKey: "ideaList") ?? []
    }
    private var ideas: [String] = []
    private let closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(named: "close"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        let inset: CGFloat = 17
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func touchupCloseButton(_ button: UIButton) {
          self.dismiss(animated: true, completion: nil)
          interactiveTransition?.finish()
    }
    
    @objc private func touchupRefreshButton(_ button: UIButton) {
        makeIdea(keywords: selectedKeywords)
    }
//
//    @objc private func tapIdeaLabel(_ recognizer: UITapGestureRecognizer) {
//        UserDefaults.standard.set(self.ideaLabel.text!, forKey: "ideaList")
//        print("clci")
//        ideas.append(self.ideaLabel.text!)
//        collectionView.reloadSection(section: 0)
//    }
    @objc private func touchupIdeaLabel(_ recognizer: Any) {
           ideas.append(self.ideaButton.currentTitle!)
           collectionView.reloadSection(section: 0)
       }
    
    public var selectedKeywords: [String] = []
    public weak var interactiveTransition: BubbleInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        collectionView.registerNib(SearchPathCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubviews()
        addConstraints()
        
        makeIdea(keywords: selectedKeywords)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.addCircularRounded()
        closeButton.addCircularShadow()
    }
    
    private func addSubviews() {
        view.addSubview(ideaButton)
        view.addSubview(refreshButton)
        view.addSubview(closeButton)
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            ideaButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -15),
            ideaButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            ideaButton.heightAnchor.constraint(equalToConstant: 50),
            ideaButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            refreshButton.widthAnchor.constraint(equalToConstant: 25),
            refreshButton.heightAnchor.constraint(equalToConstant: 25),
            refreshButton.leftAnchor.constraint(equalTo: ideaButton.rightAnchor, constant: 15),
            refreshButton.bottomAnchor.constraint(equalTo: ideaButton.bottomAnchor),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: idealButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: idealButtonSize),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -idealButtonBottomSpace),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: ideaButton.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: ideaButton.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -30),
        ])
    }
    
    private func makeIdea(keywords: [String]) {
        //TODO
        APISource.shared.getIdea(words: keywords) { idea in
//            self.ideaLabel.text = idea[0]
            self.ideaButton.setTitle(idea[0], for: .normal)
        }
    }
}

extension CreateIdeaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ideas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SearchPathCell.self, for: indexPath)
        cell.label.text = ideas[indexPath.row]
        return cell
    }
}
