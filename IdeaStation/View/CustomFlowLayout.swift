//
//  CustomFlowLayout.swift
//  IdeaStation
//
//  Created by 최민섭 on 2020/03/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {

    let cellSpacing:CGFloat = 10

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 4
        self.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargins = [sectionInset.left, sectionInset.left]
        attributes?.forEach { layoutAttribute in
            let index = layoutAttribute.frame.origin.y == 0 ? 0 : 1
            layoutAttribute.frame.origin.x = leftMargins[index]
            leftMargins[index] += layoutAttribute.frame.width + cellSpacing
        }
        return attributes
    }
}
