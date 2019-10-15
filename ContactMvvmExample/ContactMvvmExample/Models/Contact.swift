//
//  Contact.swift
//  ContactMvvmExample
//
//  Created by Chandresh Maurya  on 03/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import Foundation
struct Contact: Codable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var phone_number: String?
    var profile_pic: String?
    var favorite: Bool?
    var created_at: String?
    var updated_at: String?
    var fullName: String {
        return (first_name ?? "") + " " + (last_name ?? "")
    }
    
    static func createStub() -> Contact {
        
        return Contact(id: 6027,
                       first_name: "Chandresh Maurya",
                       last_name: "Maurya",
                       email: "chandresh.maurya326@.com",
                       phone_number: nil,
                       profile_pic: nil,
                       favorite: nil,
                       created_at: nil,
                       updated_at: nil)
    }
}
