//
//  SceneDelegate.swift
//  SBTest
//
//  Created by Muhammad Wahab on 02/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let moviesListingVC = MoviesListViewController(viewModel: MoviesListViewModel())
        let navigaitonVC = UINavigationController(rootViewController: moviesListingVC)
        self.window?.rootViewController = navigaitonVC
        self.window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
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

