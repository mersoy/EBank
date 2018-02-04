//  Copyright © 2018 Muge Ersoy. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let coordinator = LoginCoordinator(service: DefaultLoginService(), analytics: DefaultAnalyticsManager(), defaults: EDefaults())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator.rootViewController
        window?.makeKeyAndVisible()
        setupAppearance()
        return true
    }
    
    private func setupAppearance(){
        let nav = UINavigationBar.appearance()
       nav.barTintColor = UIColor(red: 20/255, green: 35/255, blue: 60/255, alpha: 1)
        nav.tintColor = UIColor.white
        nav.titleTextAttributes = [.foregroundColor: UIColor.white]
        nav.isTranslucent = false
    }
}

