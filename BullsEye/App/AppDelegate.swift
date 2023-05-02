//
//  AppDelegate.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        return true
    }
}

private extension AppDelegate {
    func setRootViewController() {
        let gameViewController = ViewControllers.game(GameViewReactor(recordService: RecordService())).instantiate()
        let rootViewController = UINavigationController(rootViewController: gameViewController)
        
        let initialWindow = UIWindow(frame: UIScreen.main.bounds)
        initialWindow.rootViewController = rootViewController
        initialWindow.makeKeyAndVisible()
        
        window = initialWindow
    }
}
