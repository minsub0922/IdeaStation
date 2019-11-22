//
//  seedDetailViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/23.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class SeedDetailViewController: UIViewController {
    
    var seedLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = label.font.withSize(20)
        label.textColor = .black
        return label
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViews()
    }
    
    private func setViews() {
        view.addSubview(seedLabel)
        addConstraintsForTestLabel()
    }

    private func addConstraintsForTestLabel() {
        seedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seedLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            seedLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            seedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
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
