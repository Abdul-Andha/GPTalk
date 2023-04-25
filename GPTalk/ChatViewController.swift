//
//  ChatViewController.swift
//  GPTalk
//
//  Created by Abdul Andha on 4/22/23.
//

import UIKit
import StreamChat
import StreamChatUI
import OpenAIKit

class ChatViewController: ChatChannelVC {
    
    
    var openAIClient = AppDelegate.openAIClient
    var chatMessages: [Chat.Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsController = client.eventsController()
        eventsController.delegate = self
        chatMessages = []
        
        let systemMessage = """
            {
                "role": "system",
                "content": "You are a text message assistant. Users will text each other and when they mention you, you will respond appropriately. You will receive role, content, and author of each message. Use this information appropriately."
            }
        """

        let data = systemMessage.data(using: .utf8)!
        let decoder = JSONDecoder()

        do {
            let message = try decoder.decode(Chat.Message.self, from: data)
            chatMessages.append(message)
        } catch {
            print("Error decoding message: \(error)")
        }

        
    }
    
    override func eventsController(_ controller: EventsController, didReceiveEvent event: Event) {
        
        // Handle any event received
        switch event {
        case let event as MessageNewEvent:
            storeMessage(event: event)
            if (event.message.text.lowercased().contains("@gpt")) {
                Task {
                    //query GPT
                    var gptMessage = await queryGPT(triggerMessage: event.message)
                    gptMessage = "** GPT **\n\n" + gptMessage
                    //send message
                    let channelController = ChatClient.shared.channelController(for: event.channel.cid)
                    channelController.createNewMessage(text: gptMessage) { result in
                        switch result {
                        case .success(let messageId):
                            print(messageId)
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        default:
            break
        }
    }
    
    func queryGPT(triggerMessage: ChatMessage) async -> String {
        do {
            let response = try await openAIClient?.chats.create(
                model: Model.GPT4.gpt4,
                messages: chatMessages,
                maxTokens: 512
            )
            return response!.choices[0].message.content
        } catch {
            print(error)
        }
        return "GPT Error: Please try again"
    }
    
    func storeMessage(event: MessageNewEvent) {
        let newMessage = """
            {
                "role": "user",
                "content": "\(event.message.text)",
                "author": "\(event.message.author.name!)"
            }
        """
        
        let data = newMessage.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let message = try decoder.decode(Chat.Message.self, from: data)
            chatMessages.append(message)
        } catch {
            print("Error decoding message: \(error)")
        }
    }
}

