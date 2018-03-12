//
//  ImageBreedCell.swift
//  testty
//
//  Created by Liudmila Russu on 2/28/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

class ImageBreedCell: UICollectionViewCell {
    
    @IBOutlet weak var breedImageView: UIImageView!
    
    var breedImage: Data? {
        didSet {
            if let image = breedImage {
                breedImageView.image = UIImage(data: image)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView: UIView = UIView(frame: self.frame)
        backgroundView.backgroundColor = UIColor.yellow
        selectedBackgroundView = backgroundView
        backgroundColor = UIColor.red
        //breedImageView.translatesAutoresizingMaskIntoConstraints = false
    }

}
