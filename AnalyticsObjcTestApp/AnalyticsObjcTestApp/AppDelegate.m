//
//  AppDelegate.m
//  AnalyticsObjcTestApp
//
//  Created by Tony Xiao on 11/28/16.
//  Copyright © 2016 Segment. All rights reserved.
//

#import "AppDelegate.h"
#import <Analytics/SEGAnalytics.h>
#import <Segment-GoogleAnalytics/SEGGoogleAnalyticsIntegrationFactory.h>
#import <Segment-Mixpanel/SEGMixpanelIntegrationFactory.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //https://segment.com/segment-mobile/sources/ios/overview
    SEGAnalyticsConfiguration *config = [SEGAnalyticsConfiguration configurationWithWriteKey:@"H18ZaUENQGcg4t7mJnYt1XrgG5vNkULh"];
    
    config.trackApplicationLifecycleEvents = YES;
    config.recordScreenViews = YES;
    
    [config use:[SEGGoogleAnalyticsIntegrationFactory instance]];
    [config use:[SEGMixpanelIntegrationFactory instance]];
    [SEGAnalytics setupWithConfiguration:config];
    [SEGAnalytics debug:YES];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
