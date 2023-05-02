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
        let viewController = GameViewController()
        viewController.reactor = GameViewReactor(recordService: RecordService())
        let rootViewController = UINavigationController(rootViewController: viewController)
        
        let initialWindow = UIWindow(frame: UIScreen.main.bounds)
        initialWindow.rootViewController = rootViewController
        initialWindow.makeKeyAndVisible()
        
        window = initialWindow
    }
}
