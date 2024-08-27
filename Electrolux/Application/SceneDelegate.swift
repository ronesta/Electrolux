//
//  SceneDelegate.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 14.08.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let firstViewController = FirstViewController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let firstTabBarItem = UITabBarItem(title: "First Tab",
                                          image: UIImage(systemName: "1.circle"),
                                          tag: 0)
        firstTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        firstNavigationController.tabBarItem = firstTabBarItem

        let secondViewController = SecondViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        let secondTabBarItem = UITabBarItem(title: "Second Tab",
                                              image: UIImage(systemName: "2.circle"),
                                              tag: 1)
        secondTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        secondNavigationController.tabBarItem = secondTabBarItem

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstNavigationController,
                                            secondNavigationController]

        tabBarController.tabBar.barTintColor = .white

        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
