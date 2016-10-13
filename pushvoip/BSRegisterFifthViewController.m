//
//  BSRegisterFifthViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFifthViewController.h"
#import "UITextField+toolbarAddition.h"

@implementation BSRegisterFifthViewController

@synthesize skillPicker;
@synthesize skillButton;
@synthesize skillText;
@synthesize skillList;
@synthesize skillId;
@synthesize currentTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Compétence";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    
    skillList = @[
                       @{@"NAME":@"",@"ID":@""},
                       @{@"NAME":@"Choix1".lowercaseString,@"ID":@"1"},
                       @{@"NAME":@"Choix2".lowercaseString,@"ID":@"2"},
                       @{@"NAME":@"Choix3".lowercaseString,@"ID":@"3"}
                       ];
    
    skillPicker = [[UIPickerView alloc] init];
    skillPicker.showsSelectionIndicator = YES;
    skillPicker.delegate = self;
    skillText.inputView = skillPicker;
    skillText.inputAccessoryView = [UITextField closeToolbarWithTarget:self andSelector:@selector(resignAllResponder)];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
        for (int i=0; i<[skillList count]; i++) {
            if ([[[skillList objectAtIndex:i] objectForKey:@"ID"] isEqualToString:@"0"]) {
                [skillText setText:[[skillList objectAtIndex:i] objectForKey:@"NAME"]];
                skillId = [[skillList objectAtIndex:i] objectForKey:@"ID"];
                [skillPicker selectRow:i inComponent:0 animated:NO];
            }
        }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.currentTextField = (int)textField.tag;
    
    return YES;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    switch(self.currentTextField){
        case 0:
            
            if (!view)
            {
                view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 47)];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 47)];
                label.backgroundColor = [UIColor clearColor];
                label.tag = 1;
                [view addSubview:label];
                
            }
            
            ((UILabel *)[view viewWithTag:1]).text = [[self.skillList objectAtIndex:row] objectForKey:@"NAME"];
            
            return view;
            
            break;
        default:
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 47)];
            return view;
            
            break;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 320.0;
}

// tell the picker the height of each row for a given component (in our case we have one component)
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 47.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch(currentTextField){
        case 0:
            return [skillList count];
            break;
        default:
            return [skillList count];
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch(self.currentTextField){
        case 0:
            return [self.skillList objectAtIndex:row];
            break;
        default:
            return [self.skillList objectAtIndex:row];
            break;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //NSLog(@" bn flag : %d ",self.currentTextField );
    switch(self.currentTextField){
        case 0:
            [self.skillText setText:[[self.skillList objectAtIndex:row] objectForKey:@"NAME"]];
            self.skillId = [[self.skillList objectAtIndex:row] objectForKey:@"ID"];
            break;
            
        default: break;
    }
    
    
    
}
/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
*/
- (void)resignAllResponder
{
    [skillText resignFirstResponder];
}

- (IBAction)skillButton:(UIButton *)sender {
    [skillText becomeFirstResponder];
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)btnFinishOnClick:(id)sender {
    UIAlertView *notificationAlert = [[UIAlertView alloc] initWithTitle:@"Bon samaritain"    message:@"Votre inscription a bien été prise en compte."
                                                               delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [notificationAlert show];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
