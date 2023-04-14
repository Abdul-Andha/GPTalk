//
//  Users.swift
//  GPTalk
//
//  Created by Tameem Ahmed on 4/14/23.
//

import Foundation
import ParseSwift


struct User: ParseUser{
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    
    
    var username: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?
    
}
