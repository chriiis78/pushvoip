//
//  ViewController.m
//  pushvoip
//
//  Created by chris 78 on 31/08/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    //Here we are just going to create the actions for the category.
    UIMutableUserNotificationAction *acceptAction = [self createAction];
    UIMutableUserNotificationAction *laterAction = [self createLaterAction];
    laterAction.title = @"Nop";
    //Create category
    UIMutableUserNotificationCategory *acceptCategory = [self createCategory:@[acceptAction, laterAction]];
    //Register the categories
    [self registerCategorySettings:acceptCategory];
}

// START Create notifications types *********************

//Create a category
- (UIMutableUserNotificationCategory *)createCategory:(NSArray *)actions {
    UIMutableUserNotificationCategory *acceptCategory = [[UIMutableUserNotificationCategory alloc] init];
    acceptCategory.identifier = @"ACCEPT_CATEGORY";
    
    [acceptCategory setActions:actions forContext:UIUserNotificationActionContextDefault];
    
    return acceptCategory;
}

//Register your settings for that category
- (void)registerCategorySettings:(UIMutableUserNotificationCategory *)category {
    UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_8_0) {
        NSSet *categories = [NSSet setWithObjects:category, nil];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else{
        // ancienne version
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
}

//Create Actions Methods
- (UIMutableUserNotificationAction *)createAction {
    
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Oui";  //@"Oui";
    
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptAction.destructive = NO;
    
    // If YES requires passcode
    acceptAction.authenticationRequired = NO;
    
    return acceptAction;
}

- (UIMutableUserNotificationAction *)createLaterAction {
    
    UIMutableUserNotificationAction *laterAction = [[UIMutableUserNotificationAction alloc] init];
    laterAction.identifier = @"LATER_IDENTIFIER";
    laterAction.title = @"Non"; //@"Non"; // AMLocalizedString(@"YES",@"")
    
    laterAction.activationMode = UIUserNotificationActivationModeBackground;
    laterAction.destructive = NO;
    laterAction.authenticationRequired = NO;
    
    return laterAction;
}

// END Create notifications types ********************

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startLocalNotification {  // Bind this method to UIButton action
    NSLog(@"startLocalNotification");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"bs_question" forKey:@"NOTIF_TAG"];
    [defaults synchronize];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];
    notification.alertBody = @"Un accident a été déclaré";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 10;
    notification.category = @"ACCEPT_CATEGORY";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
