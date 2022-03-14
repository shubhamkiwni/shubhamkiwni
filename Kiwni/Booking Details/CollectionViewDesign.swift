//
//  CollectionViewDesign.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 17/02/22.
//

import Foundation
import UIKit

class CollectionViewDesignclass {
    
    static let shareInstance = CollectionViewDesignclass()
    
    static func collectionViewDesign(_ collection: UICollectionView) {
        collection.layer.borderColor = UIColor.black.cgColor
        collection.layer.borderWidth = 1.0
//        collection.delegate = self
//        collection.dataSource = self
    }
    
    static func viewDesign(_ view: UIView, cornerRadius: CGFloat, color: CGColor, borderWidth: CGFloat, maskCorner: CACornerMask) {
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = maskCorner
        view.layer.borderColor = color
        view.layer.borderWidth = borderWidth
    }
    
}
