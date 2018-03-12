//
//  OtherViewController.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

protocol OtherView: class {
    func updateUI()
    func updateDataSource(breedNames: [String]?)
    func getBreedsFromDataSource() -> [Breed]?
    func getBreedFromDataSource(by index: Int) -> Breed?
    func updateDataSource(image: Data, forBreedName: String)
}

class OtherViewController: UIViewController, OtherView {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataSource: BreedsDataSource? = {
        return BreedsDataSource(breeds: nil)
    }()
    
    var presenter: OtherPresenter!
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.dataSource = self?.dataSource
            self?.tableView.reloadData()
        }
    }
    
    func getBreedsFromDataSource() -> [Breed]? {
        return dataSource?.breeds
    }
    
    func getBreedFromDataSource(by index: Int) -> Breed? {
        return dataSource?.breeds?[index]
    }
    
    func toBreeds(data: [String]?) -> [Breed]? {
        guard let data = data else {
            return nil
        }
        
        return data.map({ Breed(name: $0, image: nil) })
    }
    
    func updateDataSource(breedNames: [String]?) {
        guard let breedNames = breedNames else {
            return
        }
    
        guard let breeds = toBreeds(data: breedNames) else {
            return
        }
        
        dataSource?.update(data: breeds)
        
        presenter.viewDidUpdateDataSourceWithBreedNames()
    }
    
    
    func updateDataSource(image: Data, forBreedName: String) {
        guard var breeds = dataSource?.breeds else {
            return
        }
        
        guard let index = breeds.index(where: { $0.name == forBreedName }) else {
            return
        }
        
        breeds[index].image = image
        dataSource?.breeds = breeds
        
        presenter.viewDidUpdateDataSourceWithBreedImages()
    }
}

extension OtherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.viewDidSelectBreedCell(index: indexPath.row)
    }
}

extension OtherViewController {
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = NSLocalizedString("breed_list", comment: "")
        let cellID = String(describing: BreedCell.self)
        tableView.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.estimatedRowHeight = 20
        tableView.rowHeight = UITableViewAutomaticDimension
        presenter.viewDidLoad()
    }
}
