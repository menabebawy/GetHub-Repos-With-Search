//
//  SceneDelegate.swift
//  GitHubReposWithSearch
//
//  Created by user165891 on 2/4/20.
//  Copyright © 2020 Mena. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var rendererCoordinator : RepositoriesModuleCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UINavigationController()
        
        rendererCoordinator = RepositoriesModuleCoordinator(navigationController: window?.rootViewController as! UINavigationController)
        rendererCoordinator?.start()
        
        window?.makeKeyAndVisible()
    }
    
}
