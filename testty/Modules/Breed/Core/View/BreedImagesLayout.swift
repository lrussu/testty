//
//  BreedImagesLayaout.swift
//  testty
//
//  Created by Liudmila Russu on 3/1/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

protocol BreedImagesLayoutDelegate: class {
    
    func collectionView(_ collectionView: UICollectionView, ratioForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}

class BreedImagesLayout: UICollectionViewLayout {
    
    weak var delegate: BreedImagesLayoutDelegate!
    
    fileprivate var cacheCellAttributes = [UICollectionViewLayoutAttributes]()
    
    fileprivate var countColumns: Int = 2
    lazy fileprivate var lastColumn = {
        return countColumns - 1
    }()
    fileprivate var cellPadding: CGFloat = 6
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collection = collectionView else {
            return 0
        }
        let insets = collection.contentInset
        return collection.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cacheCellAttributes.isEmpty == true, let collection = collectionView else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(countColumns)
        
        var xOffset = [CGFloat]()
        for column in 0..<countColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        let countCell = collection.numberOfItems(inSection: 0)

        var yOffset = [CGFloat](repeating: 0, count: countColumns)
        
        var column = 0

        for i in 0..<countCell {

            let indexPath = IndexPath(item: i, section: 0)
          //  let imageHeight = (columnWidth - 2 * cellPadding) * delegate.collectionView(collection, ratioForImageAtIndexPath: indexPath)
            
            let imageHeight = (columnWidth -  cellPadding) * delegate.collectionView(collection, ratioForImageAtIndexPath: indexPath)

            let height = cellPadding +  imageHeight
          //  let height = cellPadding * 2 +  imageHeight
            let indices = yOffset.indices;
            
            let columnWithMinHeight = indices.min(by: {(i, j) in
                return yOffset[i] < yOffset[j]
            })
            
            if let columnForCell = columnWithMinHeight {
                column = columnForCell
            }
            
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
          
         
            let halfPadding = cellPadding/2
            
            
            let insets = [
                UIEdgeInsetsMake(0, cellPadding, cellPadding, halfPadding),
                UIEdgeInsetsMake(0, halfPadding, cellPadding, cellPadding)// TLBR
            ]
            
            let insetFrame = UIEdgeInsetsInsetRect(frame, insets[column])


            let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            cellAttributes.frame = insetFrame
            cacheCellAttributes.append(cellAttributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] += height

          }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cacheCellAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheCellAttributes[indexPath.item]
    }
    
    
    override func invalidateLayout() {
        super.invalidateLayout()
            
        cacheCellAttributes = []
        contentHeight = 0
    }
}
