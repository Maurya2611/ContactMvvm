//
//  GlobalVCFactory.swift
//  ContactMvvmExample
//
//  Created by Chandresh Maurya  on 05/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import Foundation
import UIKit
class GlobalVCFactory {
    internal static func createContactDetailsWithType(_ type: ContactViewType,
                                                      contact: Contact? = nil,
                                                      storyboardId: String) -> UIViewController? {
        let sid = storyboardId

        switch type {
        case .create:
            guard let navigation = Storyboard.contacts.instantiateViewController(withIdentifier: sid)
                as?   UINavigationController,
                let viewcontrol = navigation.viewControllers.first as? ContactDetailsVC else { return nil }
            
            let viewmodel = GlobalVMFactory.createContactDetailsVM(delegate: viewcontrol)
            viewcontrol.contactViewType = type
            viewcontrol.createBarButtons()
            viewcontrol.viewModel = viewmodel

            return navigation
        case .edit:
            guard let navigation = Storyboard.contacts.instantiateViewController(withIdentifier: sid)
                as?   UINavigationController,
                let viewcontrol = navigation.viewControllers.first as? ContactDetailsVC else { return nil }
            
            let viewmodel       = GlobalVMFactory.createContactDetailsVM(delegate: viewcontrol)
            viewmodel.contact   = contact
            viewcontrol.viewModel = viewmodel
            return viewcontrol
            
        case .view:
            let sid = storyboardId
            guard let viewcontrol = Storyboard.contacts.instantiateViewController(withIdentifier: sid)
                as?   ContactDetailsVC else { return nil }
            
            let viewmodel       = GlobalVMFactory.createContactDetailsVM(delegate: viewcontrol)
            viewmodel.contact   = contact
            viewcontrol.viewModel = viewmodel
            return viewcontrol
        }
    }
}
