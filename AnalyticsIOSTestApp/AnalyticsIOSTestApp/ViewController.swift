//
//  ViewController.swift
//  AnalyticsIOSTestApp
//
//  Created by Tony Xiao on 12/2/16.
//  Copyright © 2016 Segment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func screenHome(_ sender: Any) {
        SEGAnalytics.shared().screen("Home")
    }
    
    @IBAction func trackOrderCompleted(_ sender: Any) {
        SEGAnalytics.shared().track("Order Completed")
    }
    
    @IBAction func flush(_ sender: Any) {
        SEGAnalytics.shared().flush()
    }
    
}

