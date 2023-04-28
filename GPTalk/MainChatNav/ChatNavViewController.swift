//
//  ChatNavViewController.swift
//  GPTalk
//
//  Created by Abdul/Hector on 4/15/23.
//

import UIKit
import StreamChat
import StreamChatUI
import Alamofire
import AlamofireImage



class MainChatNav: ChatChannelListVC {
    override open func setUpAppearance() {
        super.setUpAppearance()
        title = "Chats"
        self.router = CustomChatChannelListRouter(rootViewController: self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(addChat))

    }
    
    open func showCurrentUserProfile(){
        printAllUsers()
    }
    @objc private func addChat() {
        let alertController = UIAlertController(title: "Create New Chat", message: "Enter the name of the users you want to chat with. Make sure to separate multiple users by commas.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Username(s)"
        }
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            
            guard let usernames = alertController.textFields?.first?.text else {return}
            
            let participantIds = usernames.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            
            // TODO: Create a new group chat with the specified participants
            print("Creating group chat with participants \(participantIds)")
            self.createChat(with: participantIds)
            
            guard let username = alertController.textFields?.first?.text else {
                return
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func createChat(with usernames: [String]) {
        printAllUsers()
        
        // Use the `ChatClient` to create a `ChatChannelController` with a list of user ids
        let channelController = try? ChatClient.shared.channelController(
            createDirectMessageChannelWith: Set(usernames),
            isCurrentUserMember: true,
            name: nil,
            imageURL: nil,
            extraData: ["test": "test"]
        )
        
        
        // Call `ChatChannelController.synchronize` to create the channel.
        channelController?.synchronize { error in
            if let error = error {
                print("Error creating channel: \(error)")
            } else {
                print("Channel created successfully.")
            }
        }
    }
    
    //call to print all users. useful during development. delete after.
    func printAllUsers() {
        let controller = ChatClient.shared.userListController(
            query: .init()
        )
        
        controller.synchronize { error in
            if let error = error {
                // handle error
                print("err")
                print(error)
            } else {
                // access users
                print("succ")
                print(controller.users)
                print(controller.users.forEach { user in
                    print(user.id)
                })
            }
        }
    }
}
