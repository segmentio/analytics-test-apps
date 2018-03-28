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
        
        let config = SEGAnalyticsConfiguration(writeKey: "0YrIcHkVrkzOJ8EQ5juMHyPDPEW6GJlE")
        config.trackApplicationLifecycleEvents = true
        config.trackDeepLinks = true
        config.recordScreenViews = true
        //config.use(SEGAmplitudeIntegrationFactory.instance())
            // config.use(SEGFirebaseIntegrationFactory.instance())

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

}

