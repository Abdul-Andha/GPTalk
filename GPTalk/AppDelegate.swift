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
import StreamChatUI
 
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
        
        ParseSwift.initialize(applicationId: PARSE_APP_KEY,
                              clientKey: PARSE_CLIENT_KEY,
                              serverURL: URL(string: "https://parseapi.back4app.com")!)
        
        
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        let httpClient = HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))

        let configuration = Configuration(apiKey: OPEN_AI_API_KEY, organization: OPEN_AI_ORGANIZATION)

        AppDelegate.openAIClient = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
        setTheme()
        return true
    }
    
    func setTheme() {
        
        //read check marks
        Appearance.default.colorPalette.accentPrimary = .systemMint
        
        //delete button
        Appearance.default.colorPalette.alert = .red
        
        //separator between channels
        Appearance.default.colorPalette.border = .systemGray2
        
        //highlight on channel click
        Appearance.default.colorPalette.highlightedBackground = UIColor(white: 0.25, alpha: 0.8)
        
        //border around texts
        Appearance.default.colorPalette.border3 = .darkGray
        
        //shadow around various components in the app
        Appearance.default.colorPalette.shadow = .darkGray
        
        //date at the top when scrolling in a channel
        Appearance.default.colorPalette.staticColorText = .white
    
        //reaction on current user's msgs and instant commands popover
        Appearance.default.colorPalette.popoverBackground = UIColor(white: 0.2, alpha: 0.9)
        
        //reactions on other user msgs
        Appearance.default.colorPalette.background2 = UIColor(white: 0.1, alpha: 0.9)
        
        Appearance.default.colorPalette.inactiveTint = .systemMint
        Appearance.default.colorPalette.alternativeInactiveTint = .systemMint
        
        
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
