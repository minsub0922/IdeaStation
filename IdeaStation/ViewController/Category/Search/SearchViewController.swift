//
//  TestingViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/14.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK:- Parameters
    private let testLabel = UILabel()
    private var confirmBarButton = UIBarButtonItem()
    private let keyWordsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    } ()
    private let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        return collectionView
    } ()
    private let mandalartButton: UIButton =  {
        return UIButton(frame: CGRect(origin: .zero,
                                      size: CGSize(width: 25, height: 25)))
    } ()
    fileprivate var selectedTexts: [String] = []
    fileprivate var subject = "사랑"
    fileprivate var pictures: [Hit] = []
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupButtons()
        setupAutolayouts()
        refreshDatas(subject: subject) { strings in
            self.setupBubbleContainer(subject: self.subject, strings: strings)
            self.imagesCollectionView.isHidden = false
            self.imagesCollectionView.fadeIn()
        }
    }
}

// MARK:- SetupView
extension SearchViewController {
    private func setupBubbleContainer(subject: String, strings: [String]) {
        let container = BubbleContainer(frame: .zero, centerText: subject, childTextArray: strings)
        container.delegate = self
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func setupCollectionView() {
        keyWordsCollectionView.registerNib(SearchPathCell.self)
        keyWordsCollectionView.registerNib(HorizontalArrowCell.self)
        keyWordsCollectionView.delegate = self
        keyWordsCollectionView.dataSource = self
        imagesCollectionView.registerNib(SearchImagecell.self)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        view.addSubview(keyWordsCollectionView)
        view.addSubview(imagesCollectionView)
        
        keyWordsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        keyWordsCollectionView.showsHorizontalScrollIndicator = false
        keyWordsCollectionView.backgroundColor = .white
        
        imagesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        imagesCollectionView.showsHorizontalScrollIndicator = false
        imagesCollectionView.backgroundColor = .white
    }
    
    private func setupButtons() {
        ExitButton(on: navigationController!.navigationBar, target: self)
        mandalartButton.setImage(UIImage(named: "ic-mandalart"), for: .normal)
        mandalartButton.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
        mandalartButton.tintColor = .black
        mandalartButton.alpha = 0
        mandalartButton.addShadow()
        view.addSubview(mandalartButton)
    }
    
    private func setupAutolayouts() {
        mandalartButton.translatesAutoresizingMaskIntoConstraints = false
        mandalartButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                               constant: -15).isActive = true
        mandalartButton.centerYAnchor.constraint(equalTo: keyWordsCollectionView.centerYAnchor).isActive = true
        
        keyWordsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        keyWordsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                    constant: 16).isActive = true
        keyWordsCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        keyWordsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        keyWordsCollectionView.rightAnchor.constraint(equalTo: mandalartButton.leftAnchor,
        constant: -20).isActive = true
    
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imagesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imagesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imagesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        imagesCollectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
    }
    
   
}

// MARK:- Actions
extension SearchViewController {
    @objc private func touchupButton(_ sender: UIButton) {
        weak var ghost = self.presentingViewController
        self.dismiss(animated: true, completion: {
            guard
                let navigationController = UIStoryboard(name: "MandalartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MandalartNavigationController") as? UINavigationController,
                let target = navigationController.viewControllers.first as? MandalartViewController
            else {return}
            target.setKeywords(centerKeyword: self.subject, selectedTexts: self.selectedTexts)
            navigationController.modalPresentationStyle = .fullScreen
            ghost?.present(navigationController, animated: true, completion: nil)
        })
    }
}

// APIS
extension SearchViewController {
    fileprivate func refreshDatas(subject: String, completion: @escaping ([String]) -> Void) {
        getRandomTexts(subject: subject, completion: completion)
        getPixaPictures(subject: subject)
    }
    
    fileprivate func getRandomTexts(subject: String, completion: @escaping ([String]) -> Void) {
        APISource.shared.getRandomText(word: subject) { res in
            completion(res[0...8].dropLast())
        }
    }
    
    fileprivate func getPixaPictures(subject: String) {
        APISource.shared.getPicturesPixay(word: subject) { res in
            self.pictures = res.hits
            self.imagesCollectionView.performBatchUpdates({
                self.imagesCollectionView.reloadSections(IndexSet(0...0))
            }, completion: nil)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(keyWordsCollectionView) {
            return selectedTexts.count * 2 - 1
        } else {
            return pictures.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(keyWordsCollectionView) {
            let isEven = indexPath.row % 2 == 0
            let width: CGFloat = isEven ? 70 : 15
            let height: CGFloat = isEven ? collectionView.bounds.height : 15
            return CGSize(width: width, height: height)
        } else {
            let height = collectionView.bounds.height * 0.8
            return CGSize(width: height * 1.5, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(keyWordsCollectionView) {
            return .leastNonzeroMagnitude
        } else {
            return collectionView.bounds.width / 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(keyWordsCollectionView) {
            if indexPath.row % 2 == 0 {
                let cell = collectionView.dequeueReusableCell(SearchPathCell.self, for: indexPath)
                cell.label.text = selectedTexts[indexPath.row / 2]
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(HorizontalArrowCell.self, for: indexPath)
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(SearchImagecell.self, for: indexPath)
            cell.setupView(imagePath: pictures[indexPath.row].previewURL)
            return cell
        }
    }
}

extension SearchViewController: BubbleContainerDelegate {
    func gotoExplore(selectedText: String, completion: @escaping ([String]) -> Void) {
        refreshDatas(subject: selectedText, completion: completion)
    }
    
    func childSelected(selectedText: String) {
        selectedTexts.append(selectedText)
        keyWordsCollectionView.reloadSection(section: 0)
        let row = keyWordsCollectionView.numberOfItems(inSection: 0)-1
        keyWordsCollectionView.scrollToItem(at: IndexPath(row: row,
                                                  section: 0),
                                    at: .left, animated: true)
        self.mandalartButton.fadeIn()
        self.mandalartButton.bounce()
    }
    
    func childDeSelected(selectedText: String) {
        guard let index = selectedTexts.firstIndex(of: selectedText) else {return}
        selectedTexts.remove(at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        self.keyWordsCollectionView.performBatchUpdates({
            self.keyWordsCollectionView.deleteItems(at:[indexPath])
        }, completion: nil)
        
        if selectedTexts.count == 0 {
            self.mandalartButton.fadeOut(until: 0)
        }
    }
    
    func expanded() {
        self.imagesCollectionView.fadeOut(until: 0.0)
    }
    
    func collapsed() {
        self.imagesCollectionView.isHidden = false
        self.imagesCollectionView.fadeIn(during: 0.5)
    }
}
