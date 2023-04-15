//
//  Messages.swift
//  GPTalk
//
//  Created by School on 4/15/23.
//

import Foundation
import ParseSwift

struct Message: ParseObject {
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    
    var profilePic: ParseFile?
    var userName: String?
    var lastMessage: String?
}
