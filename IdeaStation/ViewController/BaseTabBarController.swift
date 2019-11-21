//
//  BaseTabBarController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/17.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit
import BubbleTransition

class BaseTabBarController: UITabBarController {
    
    // MARK:- Properties
    private let container: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    } ()
    private let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "ic-logo"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
        button.backgroundColor = .lightlightGray
        return button
    }()
    private let transition = BubbleTransition()
    private let interactiveTransition = BubbleInteractiveTransition()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.rootViewController = self
        setupButton()
        setupTabbar()
        // Do any additional setup after loading the view.
    }
    
    private func setupTabbar() {
        tabBar.tintColor = .black
        addTabbarShadow()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        container.addCircularRounded()
        button.addCircularRounded()
        button.addCircularShadow()
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
    }
    
    private func addTabbarShadow() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setupButton() {
        container.addSubview(button)
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: tabBar.topAnchor, constant: 15),
            container.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1/6),
            container.heightAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 1/6),
            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            button.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8)
        ])
    }
    
    @objc private func touchupButton(_ button: UIButton) {
        guard let target = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController else { return }
        target.transitioningDelegate = self
        target.modalPresentationStyle = .custom
        target.view.backgroundColor = button.backgroundColor!
        target.interactiveTransition = interactiveTransition
        target.setupCloseButton(center: container.center, width: button.bounds.width)
        interactiveTransition.attach(to: target)
        present(target, animated: true, completion: nil)
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension BaseTabBarController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = container.center
        transition.bubbleColor = button.backgroundColor!
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = container.center
        transition.bubbleColor = button.backgroundColor!
        return transition
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       return interactiveTransition
     }
}
