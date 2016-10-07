//
//  BSRegisterSecondViewController.h
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSRegisterSecondViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *pin1;
@property (weak, nonatomic) IBOutlet UITextField *pin2;
@property (weak, nonatomic) IBOutlet UITextField *pin3;
@property (weak, nonatomic) IBOutlet UITextField *pin4;
@property (weak, nonatomic) IBOutlet UILabel *codeIncorrect;
@property NSString *code;
@end
