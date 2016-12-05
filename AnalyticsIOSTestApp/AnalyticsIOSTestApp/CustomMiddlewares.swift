//
//  CustomMiddlewares.swift
//  AnalyticsIOSTestApp
//
//  Created by Tony Xiao on 12/2/16.
//  Copyright © 2016 Segment. All rights reserved.
//

import Foundation

// Changing event names and adding custom attributes
let customizeAllTrackCalls = SEGBlockMiddleware { (context, next) in
    if context.eventType == .track {
        next(context.modify { ctx in
            guard let track = ctx.payload as? SEGTrackPayload else {
                return
            }
            let newEvent = "[New] \(track.event)"
            var newProps = track.properties ?? [:]
            newProps["customAttribute"] = "Hello"
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

// Turn one kind call into another
let turnScreenIntoTrack = SEGBlockMiddleware { (context, next) in
    if context.eventType == .screen {
        next(context.modify { ctx in
            guard let screen = ctx.payload as? SEGScreenPayload else {
                return
            }
            let event = "\(screen.name) Screen Tracked"
            ctx.payload = SEGTrackPayload(
                event: event,
                properties: screen.properties,
                context: screen.context,
                integrations: screen.integrations
            )
            ctx.eventType = .track
        })
    } else {
        next(context)
    }
}

// Completely block events
let enforceEventTaxonomy = SEGBlockMiddleware { (context, next) in
    let validEvents = [
        "Application Opened",
        "Order Completed",
        "Home Screen Tracked",
        "AnalyticsIOSTestApp. Screen Tracked",
    ]
    if let track = context.payload as? SEGTrackPayload {
        if !validEvents.contains(track.event) {
            showAlert(title: "Dropping Rogue Event",
                      message: track.event)
            return
        }
    }
    next(context)
}

// Sample events to Mixpanel
let sampleEventsToMixpanel = SEGBlockMiddleware { (context, next) in
    if let track = context.payload as? SEGTrackPayload {
        let numberBetween0To4 = arc4random() % 5
        if numberBetween0To4 != 0 {
            next(context.modify { ctx in
                ctx.payload = SEGTrackPayload(
                    event: track.event,
                    properties: track.properties,
                    context: track.context,
                    integrations: ["Mixpanel": false]
                )
            })
            return
        }
    }
    next(context)
}

// Block screen calls to amplitude
let blockScreenCallsToAmplitude = SEGBlockMiddleware { (context, next) in
    if let screen = context.payload as? SEGScreenPayload {
        next(context.modify { ctx in
            ctx.payload = SEGScreenPayload(
                name: screen.name,
                properties: screen.properties,
                context: screen.context,
                integrations: ["Mixpanel": false]
            )
        })
        return
    }
    next(context)
}
