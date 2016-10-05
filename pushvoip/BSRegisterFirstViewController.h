//
//  BSRegisterFirstViewController.h
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSRegisterFirstViewController.h"

@interface BSRegisterFirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *countryFlag;
@property (weak, nonatomic) IBOutlet UIButton *countryName;
@property (weak, nonatomic) IBOutlet UITextField *callingCode;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIView *lineTop;
@property (weak, nonatomic) IBOutlet UIView *lineMiddle;
@property (weak, nonatomic) IBOutlet UIView *lineBottom;
@property (weak, nonatomic) IBOutlet UIView *lineVertical;
@end
