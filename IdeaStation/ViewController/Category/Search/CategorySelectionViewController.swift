//
//  CategorySelectionViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/12/12.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CategorySelectionViewController: UIViewController {
    public var index = 0
    private let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(25)
        button.setTitleColor(.black, for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    private let container: CategorySelectionContainer = {
        let container = CategorySelectionContainer()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    } ()
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(container)
        view.addSubview(button)
        
        container.setupView(type: index == 0 ? CategoryType.userFavor : CategoryType.dataSet)
        if index != 0 {
            navigationBar.topItem?.title = "데이터셋을 선택하세요"
        }
        
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: index == 0 ? 0.65 : 0.4 ),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func touchupButton(_ button: UIButton) {
        if index == 0 {
            if let target = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CategorySelectionViewController.className) as? CategorySelectionViewController {
                target.index = 1
                UserDatas.shared.selectedCategory = container.selectedCategories
                target.modalTransitionStyle = .crossDissolve
                target.modalPresentationStyle = .fullScreen
                present(target, animated: true, completion: nil)
            }
        } else {
            if let target = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: CategoryViewController.className) as? CategoryViewController {
                target.modalTransitionStyle = .crossDissolve
                target.modalPresentationStyle = .fullScreen
                UserDatas.shared.selectedDataset = container.selectedCategories
                present(target, animated: true, completion: nil)
            }
        }
    }
}
