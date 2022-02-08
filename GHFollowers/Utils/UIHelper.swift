//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Diego Cué Hernández on 07/02/22.
//  Copyright © 2022 Diego Cué Hernández. All rights reserved.
//

import UIKit

struct UIHelper
{
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let numItemsPerRow: CGFloat = 3.0
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let widthPerItem = floor(availableWidth/numItemsPerRow)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: widthPerItem, height: widthPerItem + 40)
        return flowLayout
    }
}
