//
//  ArrayHelper.swift
//  ContactMvvmExample
//
//  Created by Chandresh on 3/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    internal func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
