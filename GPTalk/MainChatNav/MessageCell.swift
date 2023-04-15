//
//  MessageCell.swift
//  GPTalk
//
//  Created by School on 4/15/23.
//

import UIKit
import Alamofire
import AlamofireImage


class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lastMessage: UITextField!
    
    private var imageDataRequest: DataRequest?
    
    func configure(with message: Message) {
        
        // Username
        if message.userName != nil {
            userNameLabel.text = message.userName
        }
        
        // Image
        if let imageFile = message.profilePic,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.userImage.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
    }

}
