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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsController = client.eventsController()
        eventsController.delegate = self
    }
    
    override func eventsController(_ controller: EventsController, didReceiveEvent event: Event) {
        // Handle any event received
        switch event {
        case let event as MessageNewEvent:
            if (event.message.text.lowercased().contains("@gpt")) {
                Task {
                    let gptMessage = await queryGPT(message: event.message)
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
    
    func queryGPT(message: ChatMessage) async -> String {
        do {
            let response = try await openAIClient?.completions.create(
                model: Model.GPT3.textDavinci003,
                prompts: [message.text],
                maxTokens: 512
            )
            return response!.choices[0].text
        } catch {
            print(error)
        }
        return "GPT Error: Please try again"
    }
}

