//
//  SceneDelegate.swift
//  PicturesApp
//
//  Created by Viviana Capolvenere on 14/01/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let services = ApiServices()
        let appCoordinator = AppCoordinator(window: window, services: services)
        appCoordinator.start()
        
        self.appCoordinator = appCoordinator
        self.window = window
        
        if let urlContext = connectionOptions.urlContexts.first {
                
            let sendingAppID = urlContext.options.sourceApplication
            let url = urlContext.url
            print("source application = \(sendingAppID ?? "Unknown")")
            print("url = \(url)")
                
            // Process the URL similarly to the UIApplicationDelegate example.
        }
        
        window.makeKeyAndVisible()
    }
   
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
       
        guard let urlContext = URLContexts.first,
              let components = URLComponents(string: urlContext.url.absoluteString),
              let queryItems = components.queryItems,
              let pageQueryItem = queryItems.first(where: { $0.name == "code" }),
              let code = pageQueryItem.value else { return }
        
        // Inviare messaggio tramite notification center per aggiornare lo stato della UI
       // UserDefaultsConfig.code = value
        
       // services.getToken(code: code) { token, err
       //     UserDefaultsConfig.code = value
     //   }
 
        appCoordinator?.services.getToken(code: code) { (token, error) in
            if let token = token {
                UserDefaultsConfig.token = token.access
                NotificationCenter.default.post(name: Notification.Name("refreshUser"), object: nil, userInfo: nil)
            }
        }
    }
}
