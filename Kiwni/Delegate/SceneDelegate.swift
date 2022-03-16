//
//  SceneDelegate.swift
//  Kiwni_User_App
//
//  Created by Shubham Shinde on 20/01/22.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth
import GooglePlaces
import GoogleMaps
import Network
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let _ = (scene as? UIWindowScene) else { return }
        let status = UserDefaults.standard.bool(forKey: "status")
        print(status)
        
        // add these lines
        
//        if(status == true){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let HomeVC = storyboard.instantiateViewController(identifier: Storyboard.Ids.HomeViewController) as! HomeViewController
//            window?.rootViewController = HomeVC
//        }
//        else{
//            let storyboard = UIStoryboard(name: "User", bundle: nil)
//            let LoginVC = storyboard.instantiateViewController(identifier: Storyboard.Ids.LoginViewController) as! LoginViewController
//            window?.rootViewController = LoginVC
//        }
        
        NetworkMonitor.share.startMonitoring()
        IQKeyboardManager.shared.enable = true
        GMSServices .provideAPIKey("AIzaSyDWKeGELULicORJQXa1AvVtfLNPifnj7BQ")
        GMSPlacesClient.provideAPIKey("AIzaSyDnaIPR6Tp0sgrhj-fcXLivvaILrOdQMhs")
        FirebaseApp.configure()
        NetworkMonitor.share.startMonitoring()
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

