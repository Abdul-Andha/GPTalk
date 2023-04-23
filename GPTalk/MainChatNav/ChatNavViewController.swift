//
//  ChatNavViewController.swift
//  GPTalk
//
//  Created by Abdul/Hector on 4/15/23.
//

import UIKit
import StreamChat
import StreamChatUI


class MainChatNav: ChatChannelListVC {
    override open func setUpAppearance() {
            super.setUpAppearance()
            title = "Chats"
            Components.default.isChatChannelListStatesEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(addTapped))

        // Create the logout button
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.backgroundColor = .systemBlue
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        logoutButton.addTarget(self, action: #selector(onLogOutTapped), for: .touchUpInside)
        
        // Set the frame of the logout button
        logoutButton.frame = CGRect(x: 0, y: view.bounds.height - 50, width: view.bounds.width, height: 50)
        
        // Add the logout button to the view
        view.addSubview(logoutButton)
    }
    
    //creates username pop to start new chat
    func showNewChatPopup() {
        let alertController = UIAlertController(title: "New Chat", message: "Enter the name of the user you want to start a chat with.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Username"
        }
        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let username = alertController.textFields?.first?.text else {
                return
            }
            // TODO: Create a new chat with the specified user
            print("Creating chat with user \(username)")
                
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
<<<<<<< Updated upstream
    // functionality to create new chats. Popup whre the user can enter a name of another user to create a chat with them
    
    @objc func addTapped() {
        let alert = UIAlertController(title: "Create new chat", message: "Enter the username of the user you want to chat with", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
=======
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
>>>>>>> Stashed changes

        let createAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let username = alert.textFields?.first?.text else { return }
            self.createChat(with: username)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(createAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
        
        print("add pressed")
    }

    private func createChat(with username: String) {
    
//                 MARK: Use as a reference on how to make channels
//                1: Use the `ChatClient` to create a `ChatChannelController` with a list of user ids
                let channelController = try? ChatClient.shared.channelController(
                    createDirectMessageChannelWith: ["afa"],
                    isCurrentUserMember: true,
                    name: nil,
                    imageURL: nil,
                    extraData: ["test": "test"]
                )


                /// 2: Call `ChatChannelController.synchronize` to create the channel.
                channelController!.synchronize { error in
                    if let error = error {
                        /// 4: Handle possible errors
                        print(error)
                    }
                }
                
//                MARK: Use as a reference on how to print a list of all users
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

    //logout button code starts here
    @objc func onLogOutTapped(_ sender: Any) {
        showConfirmLogoutAlert()
    }

    private func showConfirmLogoutAlert() {
        let alertController = UIAlertController(title: "Log out of your account?", message: nil, preferredStyle: .alert)
        let logOutAction = UIAlertAction(title: "Log out", style: .destructive) { _ in
            NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(logOutAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
