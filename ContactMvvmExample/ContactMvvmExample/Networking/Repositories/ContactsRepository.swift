//
//  LocationRepository.swift
//  ContactMvvmExample
//
//  Created by Chandresh Maurya  on 03/07/2019.
//  Copyright © 2019 Chandresh Maurya . All rights reserved.
//

import Foundation

class ContactsRepository: Repository<Contact> {

    typealias SingleC = ((Contact?, Error?) -> Void)
    typealias ArrayC = (([Contact]?, Error?) -> Void)
    
    // MARK: - Init
    override init() {
        super.init()
    }
    
    override func getList(params: Contact?,
                          completion: @escaping ArrayC) {
        super.getList(params: params,
                      completion: completion)
        
        let path = Paths.contacts
        
        let request = Request(path: path,
                              method: .get)
        
        createSuccessAndFail(request,
                             completion: completion) { (contacts, group) in
                                var sortBlock: ((Contact, Contact) throws -> Bool)
                                sortBlock  = { $0.first_name ?? "" < $1.first_name ?? "" }
                                
                                do {
                                    contacts = try contacts.sorted(by: sortBlock)
                                } catch let error {
                                    self.main.async {
                                        completion(nil, error)
                                    }
                                }
                                
                                group.leave()
        }
        
        requests.append(request)
    }
    
    override func get<U: LosslessStringConvertible>(params: U?,
                                                    completion: @escaping SingleC) {
        guard let param = params else { return }
        
        let path = Paths.contact.replacingOccurrences(of: URLParameters.contactId,
                                                      with: String(param))
        
        let request = Request(path: path,
                              method: .get)
        
        createSuccessAndFail(request,
                             completion: completion)
        
        requests.append(request)
    }
    
    override func edit(params: Contact?,
                       completion: @escaping ((Contact?, Error?) -> Void)) {
        super.edit(params: params,
                   completion: completion)
        
        guard let contact = params else { return }
        
        let path = Paths.contact.replacingOccurrences(of: URLParameters.contactId,
                                                      with: String(contact.id ?? 0))
        
        let request = Request(path: path,
                              method: .put)
        
        request.createParametersFrom(contact)
        
        createSuccessAndFail(request,
                             completion: completion)
        
        requests.append(request)
    }
    
    override func create(params: Contact?,
                         completion: @escaping SingleC) {
        
        guard let contact = params else { return }
        
        let path = Paths.contacts
        
        let request = Request(path: path,
                              method: .post)
        
        request.createParametersFrom(contact)
        
        createSuccessAndFail(request,
                             completion: completion)
        
        requests.append(request)
    }
   
    override func delete<U: LosslessStringConvertible>(params: U?,
                                                       completion: @escaping SingleC) {
        
        guard let params = params else { return }
        
        let path = Paths.contact.replacingOccurrences(of: URLParameters.contactId,
                                                      with: String(params))
        
        let request = Request(path: path,
                              method: .delete)
        
        createSuccessAndFail(request,
                             completion: completion)
        
        requests.append(request)
    }
}

class MockContactsRepository: ContactsRepository {
    
    internal var failable: Bool = false {
        didSet {
            (api as? MockAPI)?.failable = failable
        }
    }
    
    override init() {
        super.init()
        api = MockAPI(host: NetworkConfig.baseUrl)
    }
}
