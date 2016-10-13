//
//  BSRegisterFifthViewController.h
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSRegisterFifthViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIPickerView *skillPicker;

@property (weak, nonatomic) IBOutlet UIButton *skillButton;
@property (weak, nonatomic) IBOutlet UITextField *skillText;

@property NSArray *skillList;
@property NSString *skillId;
@property int currentTextField;

+ (UIToolbar *)closeToolbarWithTarget:(id)target andSelector:(SEL)selector;

@end
