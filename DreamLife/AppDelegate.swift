//
//  AppDelegate.swift
//  DreamLife
//
//  Created by 曹国盛 on 2023/10/26.
//

import UIKit
import Toaster

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        //跟视图设置
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white

        let navigation = UINavigationController.init(rootViewController: ViewController())

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.red
        navigation.navigationBar.standardAppearance = appearance;
        navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance;

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        return true
    }


}

