//
//  DestHashMiddleware.swift
//  SwiftRadio
//
//  Created by Brandon Sneed on 6/26/19.
//  Copyright © 2019 matthewfecher.com. All rights reserved.
//
/*
import Foundation
import Analytics
import JavaScriptCore

class DestHashMiddleware: SEGDestinationMiddleware {
    let jsContext = JSContext()!
    var tsubSource: String? = nil
    var filterSource: String? = nil
    
    
    init() {
        // patch JS console to log to the Xcode console
        jsContext.evaluateScript("var console = { log: function(message) { _consoleLog(message) } }")
        let consoleLog: @convention(block) (String) -> Void = { message in
            print("JSConsole: " + message)
        }
        jsContext.setObject(unsafeBitCast(consoleLog, to: AnyObject.self), forKeyedSubscript: "_consoleLog" as (NSCopying & NSObjectProtocol)?)
        jsContext.exceptionHandler = { context, value in
            print("JSError: \(value!)")
        }

        if let tsubPath = Bundle.main.path(forResource: "tsub.bundle", ofType: "js"),
           let filterPath = Bundle.main.path(forResource: "filter", ofType: "js") {
            do {
                tsubSource = try String(contentsOfFile: tsubPath)
                filterSource = try String(contentsOfFile: filterPath)
                
                if let tsubSource = tsubSource, let filterSource = filterSource {
                    let jsContent = "var window = this; var tsub = \(tsubSource)\n\(filterSource)"
                    jsContext.evaluateScript(jsContent)
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // files not found!
        }
    }
    
    func transform(_ payload: SEGPayload, viaSettings settings: [AnyHashable : Any]) -> SEGPayload {
        let filterFunc = jsContext.objectForKeyedSubscript("filterTransform")
        
        if let trackPayload = payload as? SEGTrackPayload {
            if let props = trackPayload.properties {
                print("TSUB Input Props = \(props)")
                let result = filterFunc?.call(withArguments: [props])?.toDictionary()
                print("TSUB Result Props = \(String(describing: result))")
                let newPayload = SEGTrackPayload(event: trackPayload.event,
                                                 properties: result,
                                                 context: trackPayload.context,
                                                 integrations: trackPayload.integrations)
                return newPayload
            }
        }
        
        return payload
    }
}
*/
