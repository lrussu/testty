//
//  BreedDataSource.swift
//  testty
//
//  Created by Liudmila Russu on 2/27/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

class BreedDataSource: NSObject {
    var name: String?
    var subBreedNames: [String]?
    var images: [Data] = [Data]()
    
    init(name: String? = nil, images: [Data]? = nil, subBreedNames: [String]? = nil) {
        if let name = name {
            self.name = name
        }
        
        if let images = images {
            self.images = images
        }
        
        if let subBreedNames = subBreedNames {
            self.subBreedNames = subBreedNames
        }
    }
    
    
    func update(name: String) {
        self.name = name
    }
    
    func update(images: [Data]) {
        self.images = images
    }
    
    func update(subBreedNames: [String]) {
        self.subBreedNames = subBreedNames
    }
}

extension BreedDataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = collectionView.dataSource as? BreedDataSource else {
            return 0
        }
        return data.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = String(describing: ImageBreedCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageBreedCell
       
        cell.breedImage = images[indexPath.row]

        return cell
    }
    

}
