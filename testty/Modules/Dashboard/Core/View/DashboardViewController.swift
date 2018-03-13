//
//  DashboardViewController.swift
//  testty
//
//  Created by Liudmila Russu on 20/02/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

protocol DashboardView: class {
    func setUpUI()
    func updateUI()
    func toggleState(state: State)
}

enum State {
    
    case on, off
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
    
    mutating func toggle(_ state: State) {
        self = state
    }
}

class DashboardViewController: UIViewController, DashboardView {
    @IBOutlet weak var helloImage: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var buttonLewisCarroll: UIButton!
    
    var presenter: DashboardPresenter!
    var state: State = .off
    
    override func viewWillAppear(_ animated: Bool) {
        toggleState(state: .off)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    @objc private func tapped() {
        toggleState(state: .on)
        presenter.mainButtonTapped()
    }

    @objc func tappedButtonLewisCarroll() {
        presenter.viewDidTapedButtonLewisCarroll()
    }
    
    func showLoading() {
        spinner.startAnimating()
     //   mainButton.setTitle("Stop", for: .normal)
    }
    
    func hideLoading() {
        spinner.stopAnimating()
      //  mainButton.setTitle("Start", for: .normal)
    }

    func setUpUI() {
        self.title = .dogBreeds
        spinner.stopAnimating()
        mainButton.setTitle(.start, for: .normal)
        helloImage.image = UIImage(named: .helloImage)
        buttonLewisCarroll.setTitle(.lewisCarroll, for: .normal)
        buttonLewisCarroll.titleLabel?.minimumScaleFactor = 0.5;
        buttonLewisCarroll.titleLabel?.adjustsFontSizeToFitWidth = true
        mainButton.addTarget(self, action: #selector(tapped), for: .touchDown)
        buttonLewisCarroll.addTarget(self, action: #selector(tappedButtonLewisCarroll), for: .touchDown)
    }
    
    func updateUI() {
        switch state {
        case .on: showLoading()
        case .off: hideLoading()
        }
    }
    
    func toggleState(state: State) {
        self.state.toggle(state)
        updateUI()
    }

}
