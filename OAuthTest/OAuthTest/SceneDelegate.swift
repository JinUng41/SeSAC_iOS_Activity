//
//  SceneDelegate.swift
//  OAuthTest
//
//  Created by 김진웅 on 1/22/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let manager = GithubManager()
    private lazy var viewController = ViewController(manager: manager)
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    
    func sceneDidBecomeActive(_ scene: UIScene) { }
    
    func sceneWillResignActive(_ scene: UIScene) { }
    
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            let code = url.absoluteString.components(separatedBy: "code=").last ?? ""
            
            // URLSession Completion + didSet
//            viewController.code = code
            
            // Swift Concurrency
            viewController.fetchGithubUserInfo(with: code)
        }
    }
}
