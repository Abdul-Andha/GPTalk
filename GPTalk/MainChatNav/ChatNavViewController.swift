//
//  ChatNavViewController.swift
//  GPTalk
//
//  Created by School on 4/15/23.
//

import UIKit

import StreamChat
import StreamChatUI
import UIKit

class MainChatNav: ChatChannelListVC {
    override open func setUpAppearance() {
            super.setUpAppearance()
            title = "Chats"
            Components.default.isChatChannelListStatesEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app.fill"), style: .plain, target: self, action: #selector(addTapped))
        }
    
    @objc func addTapped() {
        // TODO: Add functionality to create new chats. I think make a popup or something whre the user can enter a name of another user to create a chat with them
        print("add pressed")
        
        
        // MARK: Use as a reference on how to make channels
        /// 1: Use the `ChatClient` to create a `ChatChannelController` with a list of user ids
//        let channelController = try? ChatClient.shared.channelController(
//            createDirectMessageChannelWith: ["afa"],
//            isCurrentUserMember: true,
//            name: nil,
//            imageURL: nil,
//            extraData: ["test": "test"]
//        )
//
//
//        /// 2: Call `ChatChannelController.synchronize` to create the channel.
//        channelController!.synchronize { error in
//            if let error = error {
//                /// 4: Handle possible errors
//                print(error)
//            }
//        }
        
        // MARK: Use as a reference on how to print a list of all users
//        let controller = ChatClient.shared.userListController(
//            query: .init()
//        )
//
//        controller.synchronize { error in
//            if let error = error {
//                // handle error
//                print("err")
//                print(error)
//            } else {
//                // access users
//                print("succ")
//                print(controller.users)
//                print(controller.users.forEach { user in
//                    print(user.id)
//                })
//            }
//        }
        
    }
}





//class ChatNavViewController: UIViewController {
//
//    @IBOutlet weak var tableView: UITableView!
//
//    private var messages = [Message]() {
//        didSet {
//            // Reload table view data any time the posts variable gets updated.
//            tableView.reloadData()
//        }
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//}
//
//extension ChatNavViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell else {
//            return UITableViewCell()
//        }
//        cell.configure(with: messages[indexPath.row])
//        return cell
//    }
//
//}
//
//extension ChatNavViewController: UITableViewDelegate { }
