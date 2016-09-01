//
//  AppDelegate.m
//  pushvoip
//
//  Created by chris 78 on 31/08/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "AppDelegate.h"
#import <PushKit/PushKit.h>
#import "ACNotification.h"
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface AppDelegate () <CLLocationManagerDelegate>
@property(readonly, copy) NSDictionary *dictionaryPayload;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self voipRegistration];
    [launchOptions valueForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                       settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|
                                                       UIUserNotificationTypeSound categories:nil]];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Register for VoIP notifications
- (void) voipRegistration {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // Create a push registry object
    PKPushRegistry * voipRegistry = [[PKPushRegistry alloc] initWithQueue: mainQueue];
    // Set the registry's delegate to self
    voipRegistry.delegate = self;
    // Set the push type to VoIP
    voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
}

// Handle updated push credentials
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials: (PKPushCredentials *)credentials forType:(NSString *)type {
    // Register VoIP push token (a property of PKPushCredentials) with server
    if([credentials.token length] == 0) {
        NSLog(@"voip token NULL");
        return;
    }
    
    NSLog(@"PushCredentials: %@", credentials.token);
}

// Handle incoming pushes
- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type {
    NSLog(@"push recu");
    NSDictionary *aps;
    aps = [[payload dictionaryPayload] valueForKey:@"aps"];
    
    NSString *alert = [aps valueForKey:@"alert"];
    NSLog(@"%@", aps);
    double lat1 = [[aps valueForKey:@"lat"] doubleValue];
    double lon1 = [[aps valueForKey:@"lon"] doubleValue];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter= kCLDistanceFilterNone;
    double lat2 = self.locationManager.location.coordinate.latitude;
    double lon2 = self.locationManager.location.coordinate.longitude;
    NSLog(@"%f %f %f %f", lat1, lon1, lat2, lon2);
    
    double result = (acos(sin(lat1 * 0.0174533) * sin(lat2 * 0.0174533) + cos(lat1 * 0.0174533) * cos(lat2 * 0.0174533) * cos((lon2-lon1) * 0.0174533)) * 6371000);
    NSLog(@"result %f", result);
    
    if (result < 500.0){
        NSLog(@"DANS LES ENVIRONS");
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        //notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
        notification.alertBody = alert;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 10;
    
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        //[[ACNotification sharedInstance] pushNotificationReceived: nil];
    }else{
        NSLog(@"TROP LOIN");
    }
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    UIAlertView *notificationAlert = [[UIAlertView alloc] initWithTitle:@"Notification"    message:@"This local notification"
                                                               delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [notificationAlert show];
    // NSLog(@"didReceiveLocalNotification");
}

@end
