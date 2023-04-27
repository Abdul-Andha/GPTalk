//
//  customChatChannelListRouter.swift
//  GPTalk
//
//  Created by Tameem Ahmed on 4/27/23.
//

import Foundation
import StreamChat
import StreamChatUI


class CustomChatChannelListRouter: ChatChannelListRouter  {
    override func showCurrentUserProfile() {
            // Create your profile view controller with the given user info
            let profileViewController = ProfileViewController()
            // Present the view controller
            rootViewController.present(profileViewController, animated: true)
    }
    
}

