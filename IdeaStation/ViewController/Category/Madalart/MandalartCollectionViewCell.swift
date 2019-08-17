//
//  MandalartCollectionViewCell.swift
//  IdeaStation
//
//  Created by 정종인 on 12/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

class MandalartCollectionViewCell: UICollectionViewCell {
    // MARK: 만다라트 한 셀에 텍스트필드 9개
    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var textField3: UITextField!
    @IBOutlet var textField4: UITextField!
    @IBOutlet var textField5: UITextField!
    @IBOutlet var textField6: UITextField!
    @IBOutlet var textField7: UITextField!
    @IBOutlet var textField8: UITextField!
    @IBOutlet var textField9: UITextField!
    

    @IBAction public func editingDidEndTextField1(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField1")
    }
    @IBAction public func editingDidEndTextField2(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField2")
    }
    @IBAction public func editingDidEndTextField3(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField3")
    }
    @IBAction public func editingDidEndTextField4(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField4")
    }
    @IBAction public func editingDidEndTextField5(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField5")
    }
    @IBAction public func editingDidEndTextField6(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField6")
    }
    @IBAction public func editingDidEndTextField7(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField7")
    }
    @IBAction public func editingDidEndTextField8(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField8")
    }
    @IBAction public func editingDidEndTextField9(_ sender: UITextField, forEvent event: UIEvent) {
        print("editingDidEndTextField9")
    }
    
}
