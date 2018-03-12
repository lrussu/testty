//
//  BreedCell.swift
//  testty
//
//  Created by Liudmila Russu on 2/22/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

class BreedCell: UITableViewCell {

    @IBOutlet weak var breedNameLabel: UILabel!
    
    @IBOutlet weak var breedImageView: UIImageView!
    
    weak var loadActivityIndicatorView: UIActivityIndicatorView?
    
    var breedName: String? {
        didSet {
            breedNameLabel.text = breedName
        }
    }
    
    var breedImage: Data? {
        
        didSet {
            if let image = breedImage {
                breedImageView.image = UIImage(data: image)

//                UIView.animate(withDuration: 5,
//                               animations: {
//                                    self.breedImageView.image.alpha = 1
//                                }, completion: nil);
                
                breedImageView.fadeIn(duration: 5)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        breedImageView.alpha = 0
        breedImageView.layer.cornerRadius = 40
        breedImageView.layer.borderColor = UIColor.orange.cgColor
        breedImageView.layer.borderWidth = 4
        breedImageView.clipsToBounds = true
  
        
        let loadIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadIndicator.color = UIColor.green
        loadIndicator.startAnimating()
        loadIndicator.hidesWhenStopped = true

        self.addSubview(loadIndicator)
        
        let trailing = NSLayoutConstraint(item: loadIndicator,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: -20.0)
        
        let vertical = NSLayoutConstraint(item: loadIndicator,
                                          attribute: .centerY,
                                          relatedBy: .equal,
                                          toItem: self,
                                          attribute: .centerY,
                                          multiplier: 1.0,
                                          constant: 0.0)
        
        
        self.addConstraint(vertical)
        self.addConstraint(trailing)
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadActivityIndicatorView = loadIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
