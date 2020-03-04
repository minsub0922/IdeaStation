//
//  BaseViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 2020/03/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var spinner: UIView?
    
    lazy var topAnchor: NSLayoutYAxisAnchor = {
        var topAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            topAnchor = view.topAnchor
        }
        return topAnchor
    }()
    
    lazy var bottomAnchor: NSLayoutYAxisAnchor = {
        var bottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            bottomAnchor = view.bottomAnchor
        }
        return bottomAnchor
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    func displaySpinner(text: String) {
        spinner = UIView.init(frame: view.bounds)
        
        guard let spinner = spinner else { return }
        
        spinner.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinner.center
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = text
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = textLabel.font.withSize(15)
        
        spinner.addSubview(ai)
        spinner.addSubview(textLabel)
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: spinner.leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: spinner.rightAnchor),
            textLabel.topAnchor.constraint(equalTo: ai.bottomAnchor, constant: 15),
            textLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func removeSpinner() {
        spinner?.removeFromSuperview()
    }
}
