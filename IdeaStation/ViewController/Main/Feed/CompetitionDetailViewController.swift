//
//  CompetitionDetailViewController.swift
//  IdeaStation
//
//  Created by 정종인 on 2019/11/23.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class CompetitionDetailViewController: UIViewController {
    
    var imageView: UIImageView = {
        let image = UIImage(named: "petfoodPackageDesignCompetition")
        let imageView = UIImageView(image: image)
        return imageView
    } ()
    
    var bodyView: UIView = {
        let uiView = UIView(frame: .zero)
        return uiView
    } ()

    var titleTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.text = "[팀블라썸] 펫푸드 제품 패키지 디자인 공모전. 자세한 사항은 홈페이지 참고"
        textView.textColor = .black
        textView.font = textView.font?.withSize(25)
        return textView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setViews()
    }
    //MARK:- set views
    private func setViews() {
        setNavigationItems()
        setSubviews()
        setImageView()
        setBodyView()
    }
    
    private func setSubviews(){
        view.addSubview(imageView)
        view.addSubview(bodyView)
        bodyView.addSubview(titleTextView)
    }
    
    private func setNavigationItems() {
        navigationItem.title = "공모전"
    }
    
    private func setImageView() {
        addConstraintsForImageView()
    }
    
    private func setBodyView(){
        addConstraintsForBodyView()
        setTitleTextView()
    }
    
    private func setTitleTextView() {
        titleTextView.text = "[팀블라썸] 펫푸드 제품 패키지 디자인 공모전\n\n\n자세한 사항은 홈페이지 참고"
        titleTextView.font = titleTextView.font?.withSize(18)
        titleTextView.textColor = .black
        addConstraintsForTitleLabel()
    }
    //MARK:- set constraints
    private func addConstraintsForImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1.4)
        ])
    }
    
    private func addConstraintsForBodyView(){
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            bodyView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bodyView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            bodyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func addConstraintsForTitleLabel() {
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextView.leftAnchor.constraint(equalTo: bodyView.leftAnchor, constant: 15),
            titleTextView.rightAnchor.constraint(equalTo: bodyView.rightAnchor),
            titleTextView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            titleTextView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor)
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
