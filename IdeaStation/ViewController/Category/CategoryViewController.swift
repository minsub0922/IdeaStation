//
//  CategoryViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit
import BubbleTransition

class CategoryViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.borderStyle = .none
        let border = CALayer()
        textField.placeholder = "키워드를 입력해주세요.."
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    } ()
    let underline: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        return view
    } ()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    let plusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "plus-sign"), for: .normal)
        button.tintColor = .black
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
        return button
    } ()
    private let closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        let inset: CGFloat = 17
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right:inset)
        button.addTarget(self, action: #selector(touchupCloseButton(_:)), for: .touchUpInside)
        button.backgroundColor = .lightGray
        return button
    } ()
    private let searchButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic-search"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(touchupSearchButton(_:)), for: .touchUpInside)
        return button
    } ()

    private var keywords: [String] = []
    public weak var interactiveTransition: BubbleInteractiveTransition?
    
    public func setupCloseButton(center: CGPoint, width: CGFloat) {
        closeButton.frame = CGRect(origin: center,
                                   size: CGSize(width: width, height: width))
        closeButton.center = center
    }
    
    @IBAction func tapBackgroundAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.addCircularRounded()
        closeButton.addCircularShadow()
        searchButton.addShadow()
    }
    
    private func setupView() {
        textField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(SearchPathCell.self)
        
        addSubview()
        addConstraints()
    }

    
    private func addSubview() {
        //ExitButton(on: self)
        view.addSubview(plusButton)
        view.addSubview(textField)
        view.addSubview(underline)
        view.addSubview(collectionView)
        view.addSubview(searchButton)
        view.addSubview(closeButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            underline.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            underline.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            underline.heightAnchor.constraint(equalToConstant: 2),
            underline.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plusButton.rightAnchor.constraint(equalTo: underline.rightAnchor),
            plusButton.bottomAnchor.constraint(equalTo: underline.topAnchor, constant: -10),
            plusButton.widthAnchor.constraint(equalToConstant: 20),
            plusButton.heightAnchor.constraint(equalToConstant: 20),
            textField.bottomAnchor.constraint(equalTo: underline.topAnchor, constant: -10),
            textField.leftAnchor.constraint(equalTo: underline.leftAnchor),
            textField.rightAnchor.constraint(equalTo: plusButton.leftAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 20),
            searchButton.rightAnchor.constraint(equalTo: underline.rightAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 25),
            searchButton.heightAnchor.constraint(equalToConstant: 25),
            collectionView.topAnchor.constraint(equalTo: underline.bottomAnchor, constant: 15),
            collectionView.leftAnchor.constraint(equalTo: underline.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -15),
            collectionView.heightAnchor.constraint(equalToConstant: 50),
            searchButton.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
}

// MARK: Actions
extension CategoryViewController {
    @objc private func touchupButton(_ button: UIButton) {
        guard let text = textField.text else {return}
        keywords.append(text)
        textField.text = nil
        self.view.endEditing(true)
        self.collectionView.reloadSection(section: 0)
        self.searchButton.fadeIn()
        self.searchButton.bounce()
    }
    
    @objc private func touchupCloseButton(_ button: UIButton) {
          self.dismiss(animated: true, completion: nil)
          interactiveTransition?.finish()
    }
    
    @objc private func touchupSearchButton(_ button: UIButton) {
        guard let target = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {return}
        target.modalPresentationStyle = .fullScreen
        target.modalTransitionStyle = .crossDissolve
        target.keyWordsFromParent = self.keywords
        
        weak var ghost = self.presentingViewController
        //dismiss(animated: true) {
            present(target, animated: true, completion: nil)
        //}
    }
}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        underline.fadeIn()
        plusButton.fadeIn()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text?.isEmpty ?? true {
            plusButton.fadeOut(until: 0)
        }
        underline.fadeOut(until: 0.3)
        return true
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SearchPathCell.self, for: indexPath)
        if indexPath.row == 0 {
            cell.label.font = cell.label.font.boldItalic
        } else {
            cell.label.font = cell.label.font.normal
        }
        
        cell.label.text = "#"+keywords[indexPath.row]
        return cell
    }
}
