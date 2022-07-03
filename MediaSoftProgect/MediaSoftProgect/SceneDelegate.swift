//
//  SceneDelegate.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import UIKit
import FirebaseCore
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: sceneWindow)
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.showLogin()
            } else {
                self.showTabBar()
            }
        }
    }

    func showLogin() {
        
        self.window?.makeKeyAndVisible()
        
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        
        self.window?.rootViewController = navigationController
        self.window?.backgroundColor = .white
    }
    
    func showTabBar() {
        self.window?.makeKeyAndVisible()
        
        let tabBarViewController = TabBarViewController()
        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        
        self.window?.rootViewController = navigationController
        self.window?.backgroundColor = .white
    }
}

