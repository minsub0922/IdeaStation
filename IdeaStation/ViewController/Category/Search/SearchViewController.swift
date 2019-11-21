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
        collectionView.alpha = 0
        return collectionView
    } ()
    private let mandalartButton: UIButton =  {
        return UIButton(frame: CGRect(origin: .zero,
                                      size: CGSize(width: 25, height: 25)))
    } ()
    private let countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.alpha = 0
        label.textColor = .lightGray
        label.font = label.font.withSize(12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    private var bubbleContainer: BubbleContainer!
    
    fileprivate var selectedTexts: [String] = []
    fileprivate var pictures: [Hit] = []
    fileprivate var clusters: Clusters?
    public var keywords: [String] = []
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(countLabel)
        setupCollectionView()
        setupButtons()
        setupAutolayouts()
        
        getClusters(subjects: keywords) { clusters in
            self.clusters = clusters
            let children = clusters.related8ClustersMDKeywords()
            self.setupBubbleContainer(subject: self.keywords[0], childs: children)
            self.imagesCollectionView.fadeIn()
        }
        getPixaPictures(subject: keywords[0])
    }
}

// MARK:- SetupView
extension SearchViewController {
    private func setupBubbleContainer(subject: String, childs: [MDKeyword]) {
        bubbleContainer = BubbleContainer(frame: .zero, centerText: subject, childTextArray: childs)
        bubbleContainer.alpha = 0
        bubbleContainer.delegate = self
        bubbleContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bubbleContainer)
        let topConstraints = bubbleContainer.topAnchor.constraint(equalTo: keyWordsCollectionView.bottomAnchor, constant: 15)
        let bottomConstraint = bubbleContainer.bottomAnchor.constraint(equalTo: imagesCollectionView.topAnchor, constant: -15)
        topConstraints.priority = .defaultHigh
        bottomConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            topConstraints,
            bottomConstraint,
            bubbleContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bubbleContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bubbleContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            bubbleContainer.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        bubbleContainer.fadeIn()
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
        ExitButton(on: navigationBar, target: self)
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
        keyWordsCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor,
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
        
        countLabel.centerXAnchor.constraint(equalTo: mandalartButton.centerXAnchor).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: mandalartButton.topAnchor, constant: -5).isActive = true
    }
    
   
}

// MARK:- Actions
extension SearchViewController {
    @objc private func touchupButton(_ sender: UIButton) {
        weak var ghost = self.presentingViewController
        //self.dismiss(animated: true, completion: {
            guard
                let navigationController = UIStoryboard(name: "MandalartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MandalartNavigationController") as? UINavigationController,
                let target = navigationController.viewControllers.first as? MandalartViewController
            else {return}
            target.setKeywords(centerKeyword: self.keywords[0], selectedTexts: self.selectedTexts)
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        //})
    }
}

// APIS
extension SearchViewController {
    fileprivate func refreshDatas(keyword: String, completion: @escaping ([MDKeyword]) -> Void) {
        guard let clusters = clusters else { return }
        if clusters.isCategory(word: keyword) {
            completion(clusters.related8WordsMDKeywords(word: keyword))
        } else {
            getClusters(subjects: [keyword]) { clusters in
                self.clusters = clusters
                completion(clusters.related8ClustersMDKeywords())
            }
        }
        
        getPixaPictures(subject: keyword)
    }
    
    fileprivate func getPixaPictures(subject: String) {
        APISource.shared.getPicturesPixay(word: subject) { res in
            self.pictures = res.hits
            self.imagesCollectionView.performBatchUpdates({
                self.imagesCollectionView.reloadSections(IndexSet(0...0))
            }, completion: nil)
        }
    }
    
    fileprivate func getClusters(subjects: [String], completion: @escaping (Clusters) -> Void) {
        let words = subjects.reduce("") { $0 + $1 + " "}.trim
        APISource.shared.getCluster(words: words, completion: completion)
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
    func gotoExplore(selectedText: String, completion: @escaping ([MDKeyword]) -> Void) {
        refreshDatas(keyword: selectedText, completion: completion)
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
        self.countLabel.fadeIn()
        self.countLabel.text = "\(selectedTexts.count) / 70"
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
            self.countLabel.fadeOut(until: 0)
        }
    }
    
    func expanded() {
        self.imagesCollectionView.fadeOut(until: 0.0)
    }
    
    func collapsed() {
        self.imagesCollectionView.fadeIn(during: 0.5)
    }
}
