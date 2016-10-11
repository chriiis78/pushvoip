//
//  BSRegisterFourthViewController.h
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSRegisterFourthViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;

@property (weak, nonatomic) IBOutlet UIView *lineZipCode;
@property (weak, nonatomic) IBOutlet UIView *lineEmail;
@property (weak, nonatomic) IBOutlet UIView *lineGender;
@property (weak, nonatomic) IBOutlet UIView *lineBottom;
@property (weak, nonatomic) IBOutlet UIView *lineVertical;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineEmailConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineBottomConstraint;

@end
