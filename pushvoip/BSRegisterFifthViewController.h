//
//  BSRegisterFifthViewController.h
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSRegisterFifthViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIPickerView *skillPicker;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *skillText;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateText;

@property (weak, nonatomic) IBOutlet UIView *lineDateText;
@property (weak, nonatomic) IBOutlet UIView *lineDateTextBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineDateContraint;

@property (weak, nonatomic) IBOutlet UIButton *btJustif;
@property (nonatomic, strong) NSData *imageJustif;

@property NSArray *skillList;
@property NSString *skillId;
@property int currentTextField;
@property NSString *skillCurrent;

@end
