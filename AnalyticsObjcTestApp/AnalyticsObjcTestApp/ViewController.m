//
//  ViewController.m
//  AnalyticsObjcTestApp
//
//  Created by Tony Xiao on 11/28/16.
//  Copyright © 2016 Segment. All rights reserved.
//

#import "ViewController.h"
#import <Analytics/SEGAnalytics.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)identifyEvent {
    
    [[SEGAnalytics sharedAnalytics] identify:@"Yamaha Star V Star 250"];
}

- (IBAction)eventOne {
    [[SEGAnalytics sharedAnalytics] track:@"Event 1"];
}

- (IBAction)eventTwo {
    [[SEGAnalytics sharedAnalytics] track:@"Event 2"];
}

- (IBAction)eventThree {
    [[SEGAnalytics sharedAnalytics] track:@"Event 3"];
}


- (IBAction)flushEvent {
    
    [[SEGAnalytics sharedAnalytics] flush];
}

- (IBAction)resetEvent {
    
    [[SEGAnalytics sharedAnalytics] reset];
}

- (IBAction)offlineEvent {
    
    [[SEGAnalytics sharedAnalytics] track:@"Offline Test"];
}


@end
