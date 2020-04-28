//
//  AppDelegate.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/2/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit
import Analytics
import Segment_Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    weak var stationsViewController: StationsViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MPNowPlayingInfoCenter
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        // Make status bar white
        UINavigationBar.appearance().barStyle = .black
        
        // FRadioPlayer config
        FRadioPlayer.shared.isAutoPlay = true
        FRadioPlayer.shared.enableArtwork = true
        FRadioPlayer.shared.artworkSize = 600
        
        // Get weak ref of StationsViewController
        if let navigationController = window?.rootViewController as? UINavigationController {
            stationsViewController = navigationController.viewControllers.first as? StationsViewController
        }
        
        let configURL = URL(string: "http://0.0.0.0:8000/configuration.json")
        let configuration = SEGAnalyticsConfiguration(writeKey: "3VxTfPsVOoEOSbbzzbFqVNcYMNu2vjnr")//, configurationURL: configURL)
        configuration.trackApplicationLifecycleEvents = false
        configuration.recordScreenViews = true
        //configuration.flushAt = 1
        configuration.experimental.nanosecondTimestamps = true
        
        let segmentIntegration = SEGSegmentIntegrationFactory()
        let mixpanelIntegration = SEGMixpanelIntegrationFactory()
        
        configuration.use(mixpanelIntegration)
        
        let customizeSegmentTrackCalls = SEGBlockMiddleware { (context, next) in
          if context.eventType == .track {
            next(context.modify { ctx in
              guard let track = ctx.payload as? SEGTrackPayload else {
                return
              }
              let newEvent = "[Segment] \(track.event)"
              var newProps = track.properties ?? [:]
              newProps["customAttribute"] = "Bacon"
              ctx.payload = SEGTrackPayload(
                event: newEvent,
                properties: newProps,
                context: track.context,
                integrations: track.integrations
              )
            })
          } else {
            next(context)
          }
        }

        let customizeMixpanelTrackCalls = SEGBlockMiddleware { (context, next) in
          if context.eventType == .track {
            next(context.modify { ctx in
              guard let track = ctx.payload as? SEGTrackPayload else {
                return
              }
              let newEvent = "[Mixpanel] \(track.event)"
              var newProps = track.properties ?? [:]
              newProps["customAttribute"] = "Sausage"
              ctx.payload = SEGTrackPayload(
                event: newEvent,
                properties: newProps,
                context: track.context,
                integrations: track.integrations
              )
            })
          } else {
            next(context)
          }
        }
        
        configuration.sourceMiddleware = [dropAppLifecycleStuff];
        
        configuration.integrationMiddleware = [
            SEGIntegrationMiddleware(key: segmentIntegration.key(), middleware: [customizeSegmentTrackCalls]),
            SEGIntegrationMiddleware(key: mixpanelIntegration.key(), middleware: [customizeMixpanelTrackCalls])
        ]
        
        configuration.experimental.rawSegmentModificationBlock = { (payload: [AnyHashable: Any]) -> [AnyHashable: Any] in
            print(payload)
            
            var newPayload = payload
            if var context = newPayload["context"] as? [String: Any] {
                context["myValue"] = "chocolate"
                newPayload["context"] = context
            }
            
            return newPayload
        }
        
        /*
        configuration.use(integration: SEGSegmentIntegration.self)
        configuration.use(integration: SEGMixpanelIntegration.self)
        
        configuration.add(sourceMiddleware: SampleSourceMiddleware())
        configuration.add(sourceMiddlewares: [SampleSourceMiddleware(), SomeOtherMiddleware()])
            
        configuration.add(destinationMiddleware: SampleDestMiddleware(), integration:SEGSegmentIntegration.self)
        configuration.add(destinationMiddleware: SampleDestMiddleware(), integrations:[SEGSegmentIntegration.self, SEGMixpanelIntegration.self])
 
        //configuration.setDestinationMiddleware(DestHashMiddleware(), forIntegrationClass: SEGMixpanelIntegration.self)
        //configuration.setDestinationMiddleware(DestHashMiddleware(), forIntegrationClass: SEGSegmentIntegration.self)
        configuration.middlewares = [SampleMiddleware()]*/
        
        SEGAnalytics.setup(with: configuration)
        SEGAnalytics.shared()?.identify("brandon")

        /*DispatchQueue.main.async {
            SEGAnalytics.shared()?.identify(nil, traits: ["email": "test@test.com"])
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 1000000000)) { // 1-second
                SEGAnalytics.shared()?.identify(nil, traits: ["hakuna": "matata"])
            }
        }*/
        
        SEGAnalytics.shared()?.identify("brandon")
        SEGAnalytics.shared()?.track("test0")
        SEGAnalytics.shared()?.group("MyGroup")
        SEGAnalytics.shared()?.track("test1")
        SEGAnalytics.shared()?.track("test2")
        SEGAnalytics.shared()?.track("test3")
        
        SEGAnalytics.shared()?.flush()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
        SEGAnalytics.shared()?.track("AppEnteredBackgroundEvent")
        SEGAnalytics.shared()?.flush()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        SEGAnalytics.shared()?.track("AppWarmLaunchEvent")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        UIApplication.shared.endReceivingRemoteControlEvents()
        
        SEGAnalytics.shared()?.track("AppTerminatedEvent")
    }
    
    // MARK: - Remote Controls

    override func remoteControlReceived(with event: UIEvent?) {
        super.remoteControlReceived(with: event)
        
        guard let event = event, event.type == .remoteControl else { return }
        
        switch event.subtype {
        case .remoteControlPlay:
            FRadioPlayer.shared.play()
            SEGAnalytics.shared()?.track("PlayEvent")
        case .remoteControlPause:
            FRadioPlayer.shared.pause()
            SEGAnalytics.shared()?.track("PauseEvent")
        case .remoteControlTogglePlayPause:
            FRadioPlayer.shared.togglePlaying()
            SEGAnalytics.shared()?.track("PlayToggle")
        case .remoteControlNextTrack:
            stationsViewController?.didPressNextButton()
            SEGAnalytics.shared()?.track("SkipEvent")
        case .remoteControlPreviousTrack:
            stationsViewController?.didPressPreviousButton()
            SEGAnalytics.shared()?.track("PreviousEvent")
        default:
            break
        }
    }
}

