//
//  SampleMiddleware.swift
//  SwiftRadio
//
//  Created by Brandon Sneed on 7/8/19.
//  Copyright © 2019 matthewfecher.com. All rights reserved.
//

import Foundation
import Analytics

class SampleSourceMiddleware: SEGMiddleware {
    func context(_ context: SEGContext, next: @escaping SEGMiddlewareNext) {
        next(context);
    }

    func context(_ context: SEGContext, settings:[AnyHashable : Any]?, next: @escaping SEGMiddlewareNext) {
        next(context);
    }
}

class SampleDestMiddleware: SEGMiddleware {
    func context(_ context: SEGContext, next: @escaping SEGMiddlewareNext) {
        next(context);
    }
    
    func context(_ context: SEGContext, settings:[AnyHashable : Any]?, next: @escaping SEGMiddlewareNext) {
        next(context);
    }
}
