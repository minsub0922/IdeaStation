//
//  Object+.swift
//  IdeaStation
//
//  Created by 최민섭 on 14/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        completion()
    }
    
    func reloadSection(section: Int) {
        UIView.animate(withDuration: 1) {
            self.reloadSections(IndexSet(0...section))
        }
    }
}

extension Thread {
    
    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}

extension UIColor {
    open class var appthemeColor: UIColor {
        return UIColor(displayP3Red: 86/255.0, green: 181/255.0, blue: 210/255.0, alpha: 1)
    }
    
    open class var darkAppthemeColor: UIColor {
        return UIColor(displayP3Red: 70/255.0, green: 149/255.0, blue: 174/255.0, alpha: 1)
    }
    
    open class var lightlightGray: UIColor {
        return UIColor(displayP3Red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
    }
}

extension UIStoryboard {
    
}
