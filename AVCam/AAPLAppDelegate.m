/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Application delegate.
*/

#import "AAPLAppDelegate.h"

@implementation AAPLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// We use the device orientation to set the video orientation of the video preview,
	// and to set the orientation of still images and recorded videos.

	// Inform the device that we want to use the device orientation.
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    // Override point for customization after application launch.
    
    [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                       settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|
                                                       UIUserNotificationTypeSound categories:nil]];
    }
    
    if (application.scheduledLocalNotifications.count==0) {
    
        NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
        
        NSDateComponents *componentsForReferenceDate = [calendar components:(NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth ) fromDate:[NSDate date]];
        
        [componentsForReferenceDate setDay:9];
        [componentsForReferenceDate setMonth:11];
        [componentsForReferenceDate setYear:2012];
        
        NSDate *referenceDate = [calendar dateFromComponents:componentsForReferenceDate];
        
        // set components for time 7:00 a.m.
        
        NSDateComponents *componentsForFireDate = [calendar components:(NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate: referenceDate];
        
        [componentsForFireDate setHour:19];
        [componentsForFireDate setMinute:07];
        [componentsForFireDate setSecond:0];
        
        NSDate *fireDateOfNotification = [calendar dateFromComponents:componentsForFireDate];
        // Create the notification
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        
        notification.fireDate = fireDateOfNotification;
        notification.timeZone = [NSTimeZone localTimeZone];
        notification.alertBody = [NSString stringWithFormat: @"Did you take todays selfie?"];
        notification.repeatInterval= NSCalendarUnitDay;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    }

	return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    application.applicationIconBadgeNumber = 0;
}

-(void)applicationDidBecomeActive:(UIApplication *)application{
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Inform the device that we no longer require access the device orientation.
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Inform the device that we want to use the device orientation again.
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
}

@end
