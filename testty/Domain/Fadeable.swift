//
//  Fadeable.swift
//  testty
//
//  Created by Liudmila Russu on 2/27/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import UIKit

protocol Fadeable: class {
    var alpha: CGFloat { get set }
    
    func fadeIn(duration: TimeInterval,
                delay: TimeInterval,
                completion: @escaping (Bool) -> Void)
   
    func fadeOut(duration: TimeInterval,
                 delay: TimeInterval,
                 completion: @escaping (Bool) -> Void)
}



extension UIView {
    func fadeIn(duration: TimeInterval = 1.0,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(isFinished: Bool) -> Void in }) {
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                            self.alpha = 1.0
                        },
                       completion: nil)
    }
    
    func fadeOut(duration: TimeInterval = 1.0,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = {(isFinished: Bool) -> Void in }) {
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.alpha = 0.0
                        },
                       completion: nil)
    }
}


//extension UIView: Fadeable {
//}

