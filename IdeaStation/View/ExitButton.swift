//
//  ExitButtonForModal.swift
//  IdeaStation
//
//  Created by 최민섭 on 17/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class ExitButton: UIButton {
    var targetVC: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(on targetVC: UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.targetVC = targetVC
        setImage(UIImage(named: "ic-exit"), for: .normal)
        sizeToFit()
        center = CGPoint(x: targetVC.view.frame.width * 0.9, y: targetVC.view.frame.height * 0.1)
        addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        targetVC.view.addSubview(self)
    }

    @objc func exitButtonAction() {
        targetVC.dismiss(animated: true, completion: nil)
    }
}
