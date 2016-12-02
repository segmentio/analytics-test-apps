//
//  AppDelegate.swift
//  AnalyticsIOSTestApp
//
//  Created by Tony Xiao on 12/2/16.
//  Copyright © 2016 Segment. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let config = SEGAnalyticsConfiguration(writeKey: "H18ZaUENQGcg4t7mJnYt1XrgG5vNkULh")
        config.trackApplicationLifecycleEvents = true
        config.trackDeepLinks = true
        config.recordScreenViews = true
        config.use(SEGMixpanelIntegrationFactory.instance())
        
        SEGAnalytics.setup(with: config)
        SEGAnalytics.debug(true)
        
        return true
    }

}

