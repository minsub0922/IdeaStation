//
//  ExitButtonForModal.swift
//  IdeaStation
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class ExitButton: UIButton {
    enum ExitButtonType {
        case normal
        case navigationBar
    }
    
    weak var targetVC: UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(on view: UIView, target: UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.targetVC = target
        
        setImage(UIImage(named: "ic-exit"), for: .normal)
        sizeToFit()
        
        addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
    }
    
    init(on targetVC: UIViewController, type: ExitButtonType = ExitButtonType.normal) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.targetVC = targetVC
        
        switch type {
        case .normal:
            center = CGPoint(x: targetVC.view.frame.width * 0.8, y: targetVC.view.frame.height * 0.1)
        case .navigationBar:
            break
        }
        
        setImage(UIImage(named: "ic-exit"), for: .normal)
        sizeToFit()
        
        addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        self.targetVC?.view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: targetVC.view.safeAreaLayoutGuide.topAnchor,
                             constant: 16).isActive = true
        rightAnchor.constraint(equalTo: targetVC.view.safeAreaLayoutGuide.rightAnchor,
                               constant: -16).isActive = true
    }

    @objc func exitButtonAction() {
        targetVC?.dismiss(animated: true, completion: nil)
    }
}
