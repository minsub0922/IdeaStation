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
}
