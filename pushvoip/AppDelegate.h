//
//  AppDelegate.h
//  pushvoip
//
//  Created by chris 78 on 31/08/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PushKit/PushKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, PKPushRegistryDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
