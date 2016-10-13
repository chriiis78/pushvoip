//
//  UITextField+toolbarAddition.m
//  ArretCardiaque
//
//  Created by Badr Meski on 23/01/2014.
//  Copyright (c) 2014 MobiCrea. All rights reserved.
//

#import "UITextField+toolbarAddition.h"

@implementation UITextField (toolbarAddition)

+ (UIToolbar *)closeToolbarWithTarget:(id)target andSelector:(SEL)selector {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UIBarButtonItem *toolbarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cross"] style:UIBarButtonItemStylePlain target:target action:selector];

    
    // iOS 7 Fix
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        toolbar.barTintColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
    }
    else {
        toolbarButton.tintColor = [UIColor colorWithRed:52.0/255.0 green:52.0/255.0 blue:52.0/255.0 alpha:1];
        toolbar.tintColor = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:237.0/255.0 alpha:1];
    }
    
    UIBarButtonItem *toolbarFlexibleWidthButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setTranslucent:YES];
    
    toolbar.items = @[toolbarFlexibleWidthButton,toolbarButton];
    
    return toolbar;
}

@end
