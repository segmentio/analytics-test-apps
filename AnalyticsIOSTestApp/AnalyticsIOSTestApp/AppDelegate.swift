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
        
        let addPropertyToScreenCalls = SEGBlockMiddleware { (context, next) in
            if context.eventType == .screen {
                next(context.modify { ctx in
                    guard let screen = ctx.payload as? SEGScreenPayload else {
                        return
                    }
                    let newName = "Custom \(screen.name)"
                    var newProps = screen.properties ?? [:]
                    newProps["customAttribute"] = "Hello"
                    ctx.payload = SEGScreenPayload(
                        name: newName,
                        properties: newProps,
                        context: screen.context,
                        integrations: screen.integrations
                    )
                })
            } else {
                next(context)
            }
        }
        
        let customizeTrackCall = SEGBlockMiddleware { (context, next) in
            if context.eventType == .track {
                next(context.modify { ctx in
                    guard let track = ctx.payload as? SEGTrackPayload else {
                        return
                    }
                    let newEvent = "[New] \(track.event)"
                    ctx.payload = SEGTrackPayload(
                        event: newEvent,
                        properties: track.properties,
                        context: track.context,
                        integrations: track.integrations
                    )
                })
            } else {
                next(context)
            }
        }
        
        config.middlewares = [addPropertyToScreenCalls, customizeTrackCall]
        
        SEGAnalytics.setup(with: config)
        SEGAnalytics.debug(true)
        
        return true
    }

}

