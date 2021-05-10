//
//  SceneDelegate.swift
//  PizdecProject
//
//  Created by gdml on 03/03/2020.
//  Copyright © 2020 gdml. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coredata: CoreDataProtocol!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
     self.coredata = SwinjectStoryboard.defaultContainer.resolve(CoreDataProtocol.self)
     let window = UIWindow(windowScene: scene)
     var viewController: UIViewController
     var navigator: UINavigationController
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     if coredata.checker() {
     viewController = storyboard.instantiateViewController(withIdentifier: "CitySelector")
     navigator = UINavigationController(rootViewController: viewController)
     } else {
     viewController = storyboard.instantiateViewController(withIdentifier: "PageViewController")
    navigator = UINavigationController(rootViewController: viewController)
     }
     self.window = window
     self.window?.rootViewController = navigator
     self.window?.makeKeyAndVisible()
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

