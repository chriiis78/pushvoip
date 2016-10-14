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
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIButton *skillButton;
@property (weak, nonatomic) IBOutlet UITextField *skillText;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UITextField *dateText;

@property (weak, nonatomic) IBOutlet UIView *lineDateButton;
@property (weak, nonatomic) IBOutlet UIView *lineDateText;
@property (weak, nonatomic) IBOutlet UIView *lineDateTextBottom;

@property NSArray *skillList;
@property NSString *skillId;
@property int currentTextField;

@end
