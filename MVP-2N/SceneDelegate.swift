//
//  SceneDelegate.swift
//  MVP-2N
//
//  Created by Denis Medvedev on 05/10/2021.
//  Copyright © 2021 Denis Medvedev. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        //создали сцену
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //создали наш window
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        //передали ему сцену
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        let assemblyBuilder = AsselderModuleBuilder()
        let router = Router(navigationController: navigationController, assembyBuilder: assemblyBuilder)
        
        router.initialViewController()
        //создали наш модуль, он вернул нам VC
        //let mainVC = AsselderModuleBuilder.createMainModule()
        //создаем navController, сюда передаем ему рутовый контроллер который мы собрали
        //let navBar = UINavigationController(rootViewController: mainVC)
        //сказали что у window будет rotVC это наш navBar у которого тоже свой root есть
        window?.rootViewController = navigationController
        //виндов покажи
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

