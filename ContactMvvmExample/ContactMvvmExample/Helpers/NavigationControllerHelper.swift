//
//  NavigationBarHelper.swift
//  ContactMvvmExample
//
//  Created by Chandresh on 3/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setTransparentNavbarBG() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = UIColor.clear
    }
}
