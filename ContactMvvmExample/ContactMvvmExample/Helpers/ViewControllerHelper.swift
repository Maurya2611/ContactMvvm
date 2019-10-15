//
//  ViewControllerHelper.swift
//  ContactMvvmExample
//
//  Created by Chandresh on 3/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertMessageWithAction(_ type: UIAlertAction.Style,
                                    title: String,
                                    message: String,
                                    cancelTitle: String?,
                                    acceptTitle: String?,
                                    completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        
        if let cancel = cancelTitle {
            let leftAction = UIAlertAction(title: cancel,
                                           style: type,
                                           handler: nil)
            alertController.addAction(leftAction)
        }
        
        if let accept = acceptTitle {
            let rightAction = UIAlertAction(title: accept,
                                            style: type,
                                            handler: { action in
                                                completion?()
            })
            alertController.addAction(rightAction)
        }
        
        present(alertController,
                animated: true,
                completion: nil)
    }
}
