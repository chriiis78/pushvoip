//
//  ViewController.m
//  pushvoip
//
//  Created by chris 78 on 31/08/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "ViewController.h"
#import "ACNotification.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[[ACNotification sharedInstance] pushNotificationReceived: nil];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startLocalNotification {  // Bind this method to UIButton action
    NSLog(@"startLocalNotification");
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
    notification.alertBody = @"This is local notification!";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 10;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
