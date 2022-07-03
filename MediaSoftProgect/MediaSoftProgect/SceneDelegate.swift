//
//  SceneDelegate.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: sceneWindow)
        self.window?.makeKeyAndVisible()
        
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        self.window?.rootViewController = navigationController
        self.window?.backgroundColor = .white
    }


}

