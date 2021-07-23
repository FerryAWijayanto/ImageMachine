//
//  UIHelpers.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

enum UIHelpers {
    
    static func createCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                           = view.bounds.width
        let padding: CGFloat                = 12
        let minimumInterimSpacing: CGFloat  = 10
        let availableWidth                  = width - (padding * 2) - (minimumInterimSpacing * 2)
        let itemWidth                       = availableWidth / 3
        
        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
