//
//  CategoryViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit
import paper_onboarding

class CategoryViewController: UIViewController {
    let onboarding = PaperOnboarding()
    let label = UILabel()
    let categories = ["탐색", "발상", "노트"]
    var state: Int = 0
    
    //MA
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPages()
        addSubview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupPages() {
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    private func addSubview() {
        label.frame = CGRect(x: view.bounds.width/2, y: view.bounds.height*0.8, width: 0, height: 0)
        label.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        setLabelText(i: 0)
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = .white
        label.onCenter()
        label.addShadowOnLabel()
        self.view.addSubview(label)
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTouchBegan)))
        ExitButton(on: self)
    }
    
    fileprivate func setLabelText(i: Int) {
        label.text = "\(categories[i])하러 가기"
    }
    
    @objc func labelTouchBegan() {
        switch state {
        case 0:
            performSegue(withIdentifier: "search", sender: nil)
        case 1:
            performSegue(withIdentifier: "madalart", sender: nil)
        case 2:
            performSegue(withIdentifier: "note", sender: nil)
        default:
            break
        }
    }
}

extension CategoryViewController: PaperOnboardingDelegate, PaperOnboardingDataSource {
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "ic-search")!,
                               title: "Searching Engine",
                               description: "you can find a lot of words related to your subject",
                               pageIcon: UIImage(named: "ic-search-mini")!,
                               color: UIColor(named: "Color1")!,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.init(name: "ArialRoundedMTBold", size: 30)!,
                               descriptionFont: UIFont.init(name: "ArialRoundedMTBold", size: 16)!),
            
            OnboardingItemInfo(informationImage: UIImage(named: "ic-puzzle")!,
                               title: "Upgrade, Extend Idea!",
                               description: "The idea tool 'Mandarart' is the best choice for upgrading and extending your idea",
                               pageIcon: UIImage(named: "ic-puzzle-mini")!,
                               color: UIColor(named: "Color2")!,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.init(name: "ArialRoundedMTBold", size: 30)!,
                               descriptionFont: UIFont.init(name: "ArialRoundedMTBold", size: 16)!),
            
            OnboardingItemInfo(informationImage: UIImage(named: "ic-note")!,
                               title: "Idea Note",
                               description: "You can make Idea Note that helps you remind your idea",
                               pageIcon: UIImage(named: "ic-note-mini")!,
                               color: UIColor(named: "Color3")!,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.init(name: "ArialRoundedMTBold", size: 30)!,
                               descriptionFont: UIFont.init(name: "ArialRoundedMTBold", size: 16)!)
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingWillTransitonToIndex(_ i: Int) {
        label.blink() {
            let center = self.label.center
            self.setLabelText(i: i)
            self.label.sizeToFit()
            self.label.center = center
            self.state = i
        }
    }
}
