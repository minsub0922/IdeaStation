//
//  CategoryViewController.swift
//  IdeaStation
//
//  Created by 최민섭 on 11/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit
import paper_onboarding
import CircleMenu

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let array = ["gkgkgk", "hohoo", "hihihi", "1231245", "gkgkgk", "hohoo", "hihihi", "1231245"]
        let view = CustomButton(size: CGSize(width: 60, height: 60), childArray: array, superView: self.view)
        self.view.addSubview(view)
    }
}

extension CategoryViewController: CircleMenuDelegate {
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        print(circleMenu.buttonsCount)
    }
}










extension CategoryViewController: PaperOnboardingDataSource {
    
    private func addOnBoarding(){
        
        let onboarding = PaperOnboarding()
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
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return [
            OnboardingItemInfo(informationImage: UIImage(named: "bgr1")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(named: "ic")!,
                               color: UIColor.red,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 18),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 12)),
            OnboardingItemInfo(informationImage: UIImage(named: "bgr2")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(named: "ic")!,
                               color: UIColor.blue,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 18),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 12)),
            OnboardingItemInfo(informationImage: UIImage(named: "bgr3")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(named: "ic")!,
                               color: UIColor.yellow,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 18),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 12))
            ][index]
    }
}
