//
//  BreedViewController.swift
//  testty
//
//  Created by Liudmila Russu on 27/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

protocol BreedView: class {
    func updateUI()
    func getBreedNameFromDataSource() -> String?
    func updateDataSource(images: [Data])
    func updateDataSource(image: Data)
}

class BreedViewController: UIViewController, BreedView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var dataSource: BreedDataSource? = {
        return BreedDataSource()
    }()
    
    var presenter: BreedPresenter!
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.dataSource = self?.dataSource
            self?.collectionView.collectionViewLayout.invalidateLayout()
            self?.collectionView.reloadData()
        }
    }
    
    func updateDataSource(breed: Breed) {
        dataSource?.update(name: breed.name)
        presenter.viewDidUpdateDataSourceWithBreedName()
    }
    
    func updateDataSource(images: [Data]) {
        dataSource?.images = images
        presenter.viewDidUpdateDataSourceWithBreedImages()
    }
    
    func updateDataSource(image: Data) {
        if let _ = dataSource?.images {
            dataSource?.images.append(image)
            presenter.viewDidUpdateDataSourceWithBreedImage()
        }     
    }
    
    func getBreedNameFromDataSource() -> String? {
        return dataSource?.name
    }
}

extension BreedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.viewDidSelectBreedCell(index: indexPath.row)
    }
}


extension BreedViewController: BreedImagesLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, ratioForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        guard let images = dataSource?.images else {
            return 50
        }
        
        guard let image = UIImage(data: images[indexPath.row]) else {
            return 50
        }
 
        return (image.size.height/image.size.width)
    }
}

extension  BreedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("breed_photos", comment: "")
        if let layout = collectionView.collectionViewLayout as? BreedImagesLayout {
            layout.delegate = self
        }
        
        let cellID = String(describing: ImageBreedCell.self)
        collectionView.register(UINib.init(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        presenter.viewDidLoad()
    }
}
