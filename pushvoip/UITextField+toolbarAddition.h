//
//  UITextField+toolbarAddition.h
//  ArretCardiaque
//
//  Created by Badr Meski on 23/01/2014.
//  Copyright (c) 2014 MobiCrea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (toolbarAddition)

+ (UIToolbar *)closeToolbarWithTarget:(id)target andSelector:(SEL)selector;

@end
