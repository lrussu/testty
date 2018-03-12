//
//  BreedDataSource.swift
//  testty
//
//  Created by Liudmila Russu on 2/22/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

class BreedsDataSource: NSObject {

    var breeds: [Breed]?
    
    init(breeds: [Breed]? = nil) {
        self.breeds = breeds

    }
    
    func update(data: [Breed]?) {
        self.breeds = data
    }
}

extension BreedsDataSource: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BreedCell.self)) as! BreedCell
        let breed = breeds?[indexPath.row]
        
        
        cell.breedName = breed?.name
        if let image = breed?.image {
            cell.breedImage = image
        }
        if breed?.image != nil && cell.breedImageView.alpha == 0 {
            print("\nbreedImageView. = \(cell.breedImageView.alpha)")
           // cell.breedImageView.fadeIn(duration: 5)
            print("breedImageView. = \(cell.breedImageView.alpha)\n")
            
        }
        return cell
    }
}
