//
//  SceneDelegate.swift
//  UsaJobs
//
//  Created by Viviana Capolvenere on 21/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let appCoordinator = AppCoordinator(window: window)
        
        self.window = window
        self.appCoordinator = appCoordinator
        
        appCoordinator.start()
        
        window.makeKeyAndVisible()
    }
}
