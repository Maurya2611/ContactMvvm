//
//  URLHelper.swift
//  ContactMvvmExample
//
//  Created by Chandresh on 3/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import UIKit
extension URL {
    static func isvalidURL(string: String?) -> Bool {
        if string != nil {
            if let url = NSURL(string: string ?? "") {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        
        return false
    }
}
