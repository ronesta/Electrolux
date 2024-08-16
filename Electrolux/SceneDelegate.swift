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

        let mainViewController = ViewController()
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        let mainTabBarItem = UITabBarItem(title: "First Tab",
                                          image: UIImage(systemName: "1.circle"),
                                          tag: 0)
        mainTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        mainNavigationController.tabBarItem = mainTabBarItem

        let paymentsViewController = UIViewController()
        let paymentsNavigationController = UINavigationController(rootViewController: paymentsViewController)
        let paymentsTabBarItem = UITabBarItem(title: "Second Tab",
                                              image: UIImage(systemName: "2.circle"),
                                              tag: 1)
        paymentsTabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16)], for: .normal)
        paymentsNavigationController.tabBarItem = paymentsTabBarItem

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainNavigationController,
                                            paymentsNavigationController]

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
