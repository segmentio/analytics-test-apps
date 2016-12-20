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
        
        let config = SEGAnalyticsConfiguration(writeKey: "ACIG3kwqCUsWZBfYxZDu0anuGwP3XtWW")
        config.trackApplicationLifecycleEvents = true
        config.trackDeepLinks = true
        config.recordScreenViews = true
        config.use(SEGMixpanelIntegrationFactory.instance())
        config.use(SEGKahunaIntegrationFactory.instance() as! SEGIntegrationFactory)

        config.middlewares = [
            turnScreenIntoTrack,
            enforceEventTaxonomy,
            customizeAllTrackCalls,
            sampleEventsToMixpanel,
            blockScreenCallsToAmplitude,
        ]
        
        SEGAnalytics.setup(with: config)
        SEGAnalytics.debug(true)

        
        
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        SEGAnalytics.shared().registeredForRemoteNotifications(withDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        SEGAnalytics.shared().failedToRegisterForRemoteNotificationsWithError(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SEGAnalytics.shared().receivedRemoteNotification(userInfo)
    }
    
    // TODO: Update docs to use the new iOS 10 API - UNUserNotificationDelegate
    // This is only relevant if developer implements the
    // custom notification action handling API, which is typically rare (check medium app for example)
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        SEGAnalytics.shared().handleAction(withIdentifier: identifier!, forRemoteNotification: userInfo)
    }

}

