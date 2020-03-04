//
//  TestingViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/14.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    // MARK:- Parameters
    private let testLabel = UILabel()
    private var confirmBarButton = UIBarButtonItem()
    
    private lazy var keyWordsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.registerNib(SearchPathCell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.allowsSelection = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.isMultipleTouchEnabled = false
        return cv
    } ()
    private lazy var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.alpha = 0
        cv.allowsSelection = true
        cv.registerNib(SearchImagecell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    } ()
    
    private lazy var mandalartButton: UIButton =  {
        let button = UIButton(frame: .zero)
        let iv = UIImageView(image: #imageLiteral(resourceName: "ic-mandalart"))
        button.addSubview(iv)
        iv.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.width.equalTo(iv.snp.height)
            $0.center.equalToSuperview()
        }
        button.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
        button.alpha = 0
        return button
    } ()
    
    private let countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.alpha = 0
        label.textColor = .gray
        label.font = label.font.withSize(9)
        label.textAlignment = .center
        return label
    } ()
    
    private lazy var mandalartBarButton: UIBarButtonItem = {
        let sv = UIStackView(arrangedSubviews: [mandalartButton])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        let bb = UIBarButtonItem()
        bb.customView = sv
        return bb
    }()
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        return label
    } ()
    
    private lazy var bubbleContainer: BubbleContainer = {
        let bc = BubbleContainer(frame: .zero, centerText: self.keyWordsFromParent[0])
        bc.delegate = self
        bc.translatesAutoresizingMaskIntoConstraints = false
        return bc
    }()
    
    fileprivate var selectedKeywords: [MDKeyword] = []
    fileprivate var pictures: [Hit] = []
    fileprivate var clusters: Clusters?
    public var keyWordsFromParent: [String] = ["하늘"] {
        didSet {
            selectedKeywords.append(contentsOf: keyWordsFromParent.map { MDKeyword(keyword: $0) } )
        }
    }
    fileprivate var centerImageURL: String = String()
        
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "탐색"
        
        displaySpinner(text: "연관단어 추론중")
        
        setLayout()
        
        getClusters(subjects: keyWordsFromParent) { clusters in
            self.clusters = clusters
            let children = clusters.related8ClustersMDKeywords(subject: MDKeyword(keyword: self.keyWordsFromParent[0]))
            self.removeSpinner()
            self.bubbleContainer.children = children
            self.imagesCollectionView.fadeIn()
        }
        
        getPixaPictures(subject: keyWordsFromParent[0])
    }
}

// MARK:- SetupView
extension SearchViewController {
    private func setLayout() {
        view.addSubview(bubbleContainer)
        view.addSubview(keyWordsCollectionView)
        view.addSubview(imagesCollectionView)
        view.addSubview(historyLabel)
     
        navigationItem.setRightBarButton(mandalartBarButton, animated: true)
        
        keyWordsCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        imagesCollectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        
        bubbleContainer.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(keyWordsCollectionView.snp.bottom).offset(15)
            $0.bottom.greaterThanOrEqualTo(imagesCollectionView.snp.top).offset(-15)
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(bubbleContainer.snp.width)
        }
        
        historyLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(bubbleContainer).offset(-30)
        }
    }
}

// MARK:- Actions
extension SearchViewController {
    @objc private func touchupButton(_ sender: UIButton) {
        guard
            let navigationController = UIStoryboard(name: "MandalartStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MandalartNavigationController") as? UINavigationController,
            let target = navigationController.viewControllers.first as? MandalartViewController
        else { return }
        target.setKeywords(centerKeyword: self.keyWordsFromParent[0], centerImageURL: self.centerImageURL, selectedTexts: self.selectedKeywords)
        navigationController.modalTransitionStyle = .crossDissolve
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

// APIS
extension SearchViewController {
    fileprivate func refreshDatas(keyword: MDKeyword, completion: @escaping ([MDKeyword]) -> Void) {
//        guard let clusters = clusters else { return }
//
//        if clusters.isCategory(word: keyword.keyword) {
//            completion(clusters.related8WordsMDKeywords(word: keyword))
//        } else {
//            getClusters(subjects: [keyword.keyword]) { clusters in
//                // 이전 클러스터에 있던 애를
//                self.clusters = clusters
//                completion(clusters.related8ClustersMDKeywords(subject: keyword))
//            }
//        }
        
        getClusters(subjects: [keyword.keyword]) { clusters in
            // 이전 클러스터에 있던 애를
            self.clusters = clusters
            completion(clusters.related8ClustersMDKeywords(subject: keyword))
        }
        
        getPixaPictures(subject: keyword.keyword)
        updateHistoryLabel(selectedKeyword: keyword)
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
        //set Mock data
        Mock.getMockClusters { res in
            switch res {
            case .value(let value) :
                completion(value)
            case .error(let err):
                print(err)
            }
        }
        
//        var subjects = subjects
//        subjects.append(subjects.first!)
//        subjects.append(contentsOf:  UserDatas.shared.selectedCategory)
//        APISource.shared.getCluster(words: subjects,
//                                    dataSet: UserDatas.shared.dataSetIndex,
//                                    completion: completion)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.isEqual(keyWordsCollectionView) {
            return selectedKeywords.count
        } else {
            return pictures.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(keyWordsCollectionView) {
            //let width: CGFloat = 70
            let height: CGFloat = 40
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = selectedKeywords[indexPath.row].keyword
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: height)
        } else {
            let height = collectionView.bounds.height * 0.8
            return CGSize(width: height * 1.5, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.isEqual(keyWordsCollectionView) {
            return 10
        } else {
            return collectionView.bounds.width / 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(keyWordsCollectionView) {
            let cell = collectionView.dequeueReusableCell(SearchPathCell.self, for: indexPath)
            let selectedKeyword = selectedKeywords[indexPath.row]
            cell.label.text = "# \(selectedKeyword.keyword)"
            cell.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longpressCellRecognizer(_:))))
            if cell.isSelected {
                cell.activate()
            } else {
                cell.inActivate()
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(SearchImagecell.self, for: indexPath)
            cell.setupView(imagePath: pictures[indexPath.row].previewURL)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(keyWordsCollectionView) {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            bubbleContainer.exploreSelectedKeyword(keyword: selectedKeywords[indexPath.row])
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? SearchPathCell else { return }
            cell.activate()
        } else {    // Select Image
            guard let cell = collectionView.cellForItem(at: indexPath) as? SearchImagecell else { return }
            cell.applyShadow()
            let imageURL = self.pictures[indexPath.row].previewURL
            let subject = bubbleContainer.getSubject()
            if keyWordsFromParent[0].elementsEqual(subject) { self.centerImageURL = imageURL; return}
            
            self.selectedKeywords = self.selectedKeywords.map{
                return $0.keyword.elementsEqual(subject) ? MDKeyword(keyword: $0.keyword, imagePath: imageURL) : $0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(imagesCollectionView) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SearchImagecell else { return }
            cell.applyShadow()
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SearchPathCell else { return }
            cell.inActivate()
        }
    }
    
    // Delete Selected Text With Cell
    @objc private func longpressCellRecognizer(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            let p = sender.location(in: self.keyWordsCollectionView)
            guard let indexPath = self.keyWordsCollectionView.indexPathForItem(at: p) else { return }
            self.selectedKeywords.remove(at: indexPath.row)
            self.keyWordsCollectionView.deleteItems(at: [indexPath])
            self.countLabel.text = "\(selectedKeywords.count) / 70"
        }
    }
}

// MARK:- Functions
extension SearchViewController {
    private func updateHistoryLabel(selectedKeyword: MDKeyword?) {
        UIView.transition(with: self.historyLabel,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.historyLabel.text = selectedKeyword?.history.trim.replacingOccurrences(of: " ",
                                                                                         with: " > ",
                                                                                         options: NSString.CompareOptions.literal, range:nil)
            }, completion: nil)
    }
}

extension SearchViewController: BubbleContainerDelegate {
    func gotoExplore(selectedMDKeyword: MDKeyword, completion: @escaping ([MDKeyword]) -> Void) {
        refreshDatas(keyword: selectedMDKeyword, completion: completion)
    }
    
    func childSelected(selectedMDKeyword: MDKeyword) {
        selectedKeywords.append(selectedMDKeyword)
        let indexPath = IndexPath(row: self.selectedKeywords.count-1, section: 0)
        keyWordsCollectionView.insertItems(at: [indexPath])
        keyWordsCollectionView.reloadItems(at: [indexPath])
        keyWordsCollectionView.scrollToItem(at: indexPath,
                                            at: .left,
                                            animated: true)
        self.mandalartButton.fadeIn()
        self.mandalartButton.bounce()
        self.countLabel.fadeIn()
        self.countLabel.text = "\(selectedKeywords.count) / 70"
        //self.updateHistoryLabel(selectedKeyword: selectedKeywords.last)
    }
    
    func childDeSelected(selectedMDKeyword: MDKeyword) {
        let selectedKeywords = self.selectedKeywords.map {$0.keyword}
        guard let index = selectedKeywords.firstIndex(of: selectedMDKeyword.keyword) else {return}
        self.selectedKeywords.remove(at: index)
        self.countLabel.text = "\(self.selectedKeywords.count) / 70"
        let indexPath = IndexPath(row: index, section: 0)
        self.keyWordsCollectionView.performBatchUpdates({
            self.keyWordsCollectionView.deleteItems(at:[indexPath])
        }, completion: nil)
        
        if self.selectedKeywords.count == 0 {
            self.mandalartButton.fadeOut(until: 0)
            self.countLabel.fadeOut(until: 0)
        }
    }
    
    func expanded() {
        self.imagesCollectionView.fadeOut(until: 0.0)
        self.historyLabel.fadeOut(until: 0.0)
    }
    
    func collapsed() {
        self.imagesCollectionView.fadeIn(during: 0.5)
        self.historyLabel.fadeIn(during: 0.5)
    }
}
