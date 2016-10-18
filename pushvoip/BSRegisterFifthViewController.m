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
@synthesize skillText;
@synthesize skillList;
@synthesize skillId;
@synthesize currentTextField;
@synthesize dateLabel;
@synthesize datePicker;
@synthesize dateText;
@synthesize lineDateText;
@synthesize lineDateTextBottom;
@synthesize lineDateContraint;
@synthesize imageJustif;
@synthesize btJustif;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Compétence";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;

    [self initSkillList];
    lineDateText.hidden = YES;
    lineDateTextBottom.hidden = YES;
    dateLabel.hidden = YES;
    dateText.hidden = YES;
    lineDateContraint.constant = 45;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    skillPicker = [[UIPickerView alloc] init];
    skillPicker.showsSelectionIndicator = YES;
    skillPicker.delegate = self;
    skillText.inputView = skillPicker;
    skillText.inputAccessoryView = [UITextField closeToolbarWithTarget:self andSelector:@selector(resignAllResponder)];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    dateText.inputView = datePicker;
    dateText.inputAccessoryView = [UITextField closeToolbarWithTarget:self andSelector:@selector(resignAllResponder)];
    [datePicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
    self.imageJustif = nil;
    [btJustif.imageView setContentMode:UIViewContentModeScaleAspectFit];
    NSLog(@"viewDidLoad");
}

- (void)initSkillList
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *BSSkill = [defaults valueForKey:@"BS_SKILL"];
    NSMutableArray *skillLista = [[NSMutableArray alloc] init];
    NSMutableArray *skill = [[NSMutableArray alloc] init];
    NSLog(@"skill %@", skill);
    NSMutableDictionary *name = [[NSMutableDictionary alloc] init];
    [name setValue:@"" forKey:@"NAME"];
    NSMutableDictionary *id = [[NSMutableDictionary alloc] init];
    [name setValue:@"0" forKey:@"ID"];
    NSMutableDictionary *expiration = [[NSMutableDictionary alloc] init];
    [name setValue:@"0" forKey:@"EXPIRATION"];
    [skill addObject:name];
    [skill addObject:id];
    [skill addObject:expiration];
    [skillLista addObject:[skill objectAtIndex:0]];
    [skill removeAllObjects];
    for (int i = 0; i < BSSkill.count; i = i + 1){
        NSMutableDictionary *name = [[NSMutableDictionary alloc] init];
        [name setValue:[[BSSkill objectAtIndex:i] objectForKey:@"name"] forKey:@"NAME"];
        NSMutableDictionary *id = [[NSMutableDictionary alloc] init];
        [name setValue:[[BSSkill objectAtIndex:i] objectForKey:@"id"] forKey:@"ID"];
        NSMutableDictionary *expiration = [[NSMutableDictionary alloc] init];
        [name setValue:[[BSSkill objectAtIndex:i] objectForKey:@"expiration"] forKey:@"EXPIRATION"];
        [skill addObject:name];
        [skill addObject:id];
        [skill addObject:expiration];
        NSLog(@"skill %@", skill);
        [skillLista addObject:[skill objectAtIndex:0]];
        [skill removeAllObjects];
    }
    skillList = skillLista;
    NSLog(@"skilllista %@", skillLista);
}

- (void)pickerChanged:(id)sender
{
    NSLog(@"value: %@",[sender date]);
    dateText.text = [NSDateFormatter localizedStringFromDate:[sender date]
                                                   dateStyle:NSDateFormatterShortStyle
                                                   timeStyle:NSDateFormatterNoStyle];
}
- (void)viewDidAppear:(BOOL)animated
{
    lineDateContraint.constant = -45;
}

- (void)viewWillAppear:(BOOL)animated
{
    for (int i=0; i<[skillList count]; i++) {
        if ([[[skillList objectAtIndex:i] objectForKey:@"ID"] isEqualToString:@"0"]) {
            [skillText setText:[[skillList objectAtIndex:i] objectForKey:@"NAME"]];
            skillId = [[skillList objectAtIndex:i] objectForKey:@"ID"];
            [skillPicker selectRow:i inComponent:0 animated:NO];
        }
    }
    lineDateContraint.constant = -45;
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
    
    
    NSString *expiration = [[self.skillList objectAtIndex:row] objectForKey:@"EXPIRATION"];
    expiration = [NSString stringWithFormat:@"%@", expiration];
    [self.view layoutIfNeeded];
    if ([expiration isEqual:@"1"]){
        [UIView animateWithDuration:0.2 animations:^{
            lineDateText.hidden = NO;
            lineDateTextBottom.hidden = NO;
            dateLabel.hidden = NO;
            dateText.hidden = NO;
            lineDateContraint.constant = 38;
            
            // Make the animation happen
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }];
    }else if ([expiration isEqual:@"0"]){
        [UIView animateWithDuration:0.2 animations:^{
            lineDateText.hidden = YES;
            lineDateTextBottom.hidden = YES;
            dateLabel.hidden = YES;
            dateText.hidden = YES;
            lineDateContraint.constant = -45;
            
            // Make the animation happen
            [self.view setNeedsLayout];
            [self.view layoutIfNeeded];
        }];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)resignAllResponder
{
    [skillText resignFirstResponder];
    [dateText resignFirstResponder];
}




#pragma mark - Camera button Callback method
/*
- (IBAction)btDelJustifTapped:(UIButton *)sender {
    
    [[DSAAPIClient sharedApiInstance] deleteJustifWithSuccess:^{
        [self deleteJustif];
        [[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"FIRSTRESPONDER_ALERT_TITLE", @"") message:AMLocalizedString(@"FIRSTRESPONDER_ALERT_JUSTIF_DELETED", @"") delegate:self cancelButtonTitle:AMLocalizedString(@"OK", @"") otherButtonTitles:nil, nil] show];
        
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:AMLocalizedString(@"APP_NAME", @"") message:AMLocalizedString(@"FIRSTRESPONDER_ALERT_MSG_ERROR", @"") delegate:nil cancelButtonTitle:AMLocalizedString(@"OK", @"") otherButtonTitles:nil, nil] show];
    }];
}

*/
 
- (IBAction)pictureButtonHasBeenTapped:(UIButton *)sender {
    UIActionSheet *actionSheet;
    //if(!self.imageJustif) {
    actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                              delegate: self
                                     cancelButtonTitle: @"CANCEL"
                                destructiveButtonTitle: nil
                                     otherButtonTitles: @"TAKE_A_NEW_PHOTO",@"CHOOSE_PHOTO_FROM_LIBRARY", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == actionSheet.destructiveButtonIndex) {
        self.imageJustif = nil;
        [self.btJustif setTitle:@"FIRSTRESPONDER_LABEL_BT_NEWJUSTIF" forState:UIControlStateNormal];
    }
    else if(buttonIndex != actionSheet.cancelButtonIndex){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if(buttonIndex == actionSheet.firstOtherButtonIndex) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            NSLog(@"competence %@ %@", skillId, skillText.text);
        }
        else if(buttonIndex == actionSheet.firstOtherButtonIndex+1) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }
}

#pragma mark - UIImagePickerController Delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    /*
    UIImage *croppedImage = nil;
    
    if (image.size.width > image.size.height)
        croppedImage = [UIImage imageWithImage:image scaledToSize:CGSizeMake(267, 200)];
    else
        croppedImage = [UIImage imageWithImage:image scaledToSize:CGSizeMake(200, 267)];
    */
    self.imageJustif = UIImageJPEGRepresentation(image, 0.5);
    
    [self saveImage:self.imageJustif];
    
    [btJustif setContentMode:UIViewContentModeScaleAspectFit];
    [btJustif setImage:image forState:UIControlStateNormal];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.btJustif setTitle:@"FIRSTRESPONDER_LABEL_BT_JUSTIF" forState:UIControlStateNormal];
}


- (void)saveImage:(NSData *)data
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSString *file = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"justif.jpg"]];
    
    [[NSFileManager defaultManager] createFileAtPath:file contents:data attributes:nil];
    [self refreshLayout];
}

- (void)deleteJustif
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    NSString *file = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"justif.jpg"]];
    
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    [self refreshLayout];
}

- (BOOL)hasJustif
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    NSString *file = [[NSString alloc] initWithString:[documentsDirectory stringByAppendingPathComponent:@"justif.jpg"]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
        
        return YES;
    }
    
    return NO;
}

- (void)refreshLayout
{
    if ([self hasJustif]) {
        [self.btJustif setTitle:@"FIRSTRESPONDER_LABEL_BT_NEWJUSTIF" forState:UIControlStateNormal];
    }else{
        [self.btJustif setTitle:@"FIRSTRESPONDER_LABEL_BT_JUSTIF" forState:UIControlStateNormal];
    }
    /*
    [self.btDelJustif setHidden:![self hasJustif]];
    
    if([self.btDelJustif isHidden]){
        [self.viewCondition setFrame:CGRectMake(self.viewCondition.frame.origin.x, self.btJustif.frame.origin.y+30, self.viewCondition.frame.size.width, self.viewCondition.frame.size.height)];
        
    }else{
        [self.viewCondition setFrame:CGRectMake(self.viewCondition.frame.origin.x, self.btDelJustif.frame.origin.y+30, self.viewCondition.frame.size.width, self.viewCondition.frame.size.height)];
    }
     */
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
