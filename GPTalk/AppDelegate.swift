//
//  AppDelegate.swift
//  GPTalk
//
//  Created by Abdul Andha on 4/13/23.
//

import UIKit
import ParseSwift
import StreamChat
import OpenAIKit
import AsyncHTTPClient
import NIO
 
extension ChatClient {
    static var shared: ChatClient!
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//    var openAiApiKey: String {
//        ProcessInfo.processInfo.environment["OPENAI_API_KEY"]!
//    }
//
//    var openAiOrganization: String {
//        ProcessInfo.processInfo.environment["OPENAI_ORGANIZATION"]!
//    }
    static var openAIClient: Client!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ParseSwift.initialize(applicationId: "cl8uCfaV8ErbUUk1wqaQhPtrdurFNiI4VTGYeXMp",
                              clientKey: "WInTTsIpVpoBUcZaXkAorvL2BeGZf2QQVGWU003h",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)
        
        
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        let httpClient = HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))

//        defer {
//            // it's important to shutdown the httpClient after all requests are done, even if one failed. See: https://github.com/swift-server/async-http-client
//            try? httpClient.syncShutdown()
//        }
        let openAiApiKey = "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"
        let openAiOrganization = "org-KhOXBCAXsTyodJZ22nH1moHh"
        let configuration = Configuration(apiKey: openAiApiKey, organization: openAiOrganization)

        AppDelegate.openAIClient = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
