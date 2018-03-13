//
//  String+Extension.swift
//  testty
//
//  Created by Liudmila Russu on 3/12/18.
//  Copyright © 2018 Liudmila Russu. All rights reserved.
//

import Foundation


public extension String {
    
    /**
     method returns localized string with default comment and self name
     - returns: localized string
     */
    public func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
