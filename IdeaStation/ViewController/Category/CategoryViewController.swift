//
//  CategoryViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

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
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    } ()
    let plusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "plus-sign"), for: .normal)
        button.tintColor = .black
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private var keywords: [String] = []
    
    @IBAction func tapBackgroundAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    private func setupView() {
        textField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(SearchPathCell.self)
        plusButton.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
            
        addSubview()
        addConstraints()
    }
    
    @objc private func touchupButton(_ button: UIButton) {
        guard let text = textField.text else {return}
        keywords.append(text)
        textField.text = nil
        self.view.endEditing(true)
        self.collectionView.reloadSection(section: 0)
        
    }
    
    private func addSubview() {
        //ExitButton(on: self)
        view.addSubview(plusButton)
        view.addSubview(textField)
        view.addSubview(underline)
        view.addSubview(collectionView)
        
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
            collectionView.topAnchor.constraint(equalTo: underline.bottomAnchor, constant: 30),
            collectionView.centerXAnchor.constraint(equalTo: underline.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension CategoryViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        underline.fadeIn()
        plusButton.fadeIn()
        moveView(to: -150)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        underline.fadeOut(until: 0.3)
        plusButton.fadeOut(until: 0)
        moveView(to: 150)
        return true
    }
    
    private func moveView(to: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            for subview in self.view.subviews {
                subview.frame.origin.y = subview.frame.origin.y + to
            }
        }
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
