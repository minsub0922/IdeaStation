//
//  BaseTabBarController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/17.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    private let button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchupButton(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        // Do any additional setup after loading the view.
    }
    
    private func setupButton() {
        view.addSubview(button)
            
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }
    
    @objc private func touchupButton(_ button: UIButton) {
        guard let target = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController else { return }
        present(target, animated: true, completion: nil)
    }
     
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
