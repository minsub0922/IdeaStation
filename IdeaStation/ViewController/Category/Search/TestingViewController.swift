//
//  TestingViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2019/11/14.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {
    let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBubbleContainer()
//        setupTestingLabel()
//        setupTestingButtons()
    }
    
    private func setupBubbleContainer() {
        let container = BubbleContainer(frame: .zero, centerText: "과학", childTextArray: ["샤ㅐ","아","ㅁㄴ이ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅏ머니아", "안녕", "하늘아~~", "방갑습니다!","좋아가는거야","사회"])
        self.view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            container.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
    }
}

extension TestingViewController {
    private func setupTestingLabel() {
        testLabel.text = "테스트 함 해보까!!"
        view.addSubview(testLabel)
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupTestingButtons() {
        let expandButton = UIButton()
        let collapseButton = UIButton()
        
        expandButton.setTitle("확대", for: .normal)
        collapseButton.setTitle("축소", for: .normal)
        expandButton.setTitleColor(.black, for: .normal)
        collapseButton.setTitleColor(.black, for: .normal)
        expandButton.addTarget(self, action: #selector(touchupExpandButton(_:)), for: .touchUpInside)
        collapseButton.addTarget(self, action: #selector(touchupCollapse(_:)), for: .touchUpInside)
        
        view.addSubview(expandButton)
        view.addSubview(collapseButton)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        collapseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            expandButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            expandButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            collapseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            collapseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
    }
    
    @objc private func touchupExpandButton(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.testLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }
    }
    @objc private func touchupCollapse(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            self.testLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { _ in
            self.testLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
}
