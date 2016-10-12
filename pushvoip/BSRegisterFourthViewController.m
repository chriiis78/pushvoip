//
//  BSRegisterFourthViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFourthViewController.h"

@implementation BSRegisterFourthViewController

@synthesize lineBottomConstraint;
@synthesize genderLabel;
@synthesize gender;
@synthesize lineEmailConstraint;
@synthesize zipCodeLabel;
@synthesize zipCode;
@synthesize firstname;
@synthesize lastname;
@synthesize email;
@synthesize continueButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Information";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    
    // Remonte les champs du tableau
    //_lineEmailConstraint.constant = -1;
    //_lineBottomConstraint.constant = -1;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL displayGender = [defaults valueForKey:@"BS_DISPLAY_GENDER"];
    BOOL displayZipCode = [defaults valueForKey:@"BS_DISPLAY_ZIPCODE"];
    
    if (displayGender == NO){
        NSLog(@"Test");
        lineBottomConstraint.constant = -1;
        genderLabel.hidden = YES;
        gender.hidden = YES;
        
    }
    if (displayZipCode == NO){
        NSLog(@"Test2 ");
        lineEmailConstraint.constant = -1;
        zipCodeLabel.hidden = YES;
        zipCode.hidden = YES;
    }
    
    NSString *firstnameBS = [defaults valueForKey:@"BS_FIRSTNAME"];
    NSString *lastnameBS = [defaults valueForKey:@"BS_LASTNAME"];
    NSString *emailBS = [defaults valueForKey:@"BS_EMAIL"];
    
    NSLog(@"alert : %@ %@ %@", firstnameBS, lastnameBS, emailBS);
    if (firstnameBS != nil && lastnameBS != nil && emailBS != nil){
        NSLog(@"alert : %@ %@ %@", firstnameBS, lastnameBS, emailBS);
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Compte existant"
                                     message:[NSString stringWithFormat:@"Un compte avec ce numéro de téléphone existe déjà.\n\n Êtes-vous %@ %@ ?", firstnameBS, lastnameBS]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Non"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle no, thanks button
                                   }];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Oui"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        firstname.text = firstnameBS;
                                        lastname.text = lastnameBS;
                                        email.text = emailBS;
                                        [self action:nil];
                                    }];
        
        [alert addAction:noButton];
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    firstname.delegate = self;
    lastname.delegate = self;
    zipCode.delegate = self;
    email.delegate = self;
    [firstname becomeFirstResponder];
    continueButton.enabled = NO;
    continueButton.backgroundColor = [UIColor lightGrayColor];
    
    [gender addTarget:self
            action:@selector(action:)
            forControlEvents:UIControlEventValueChanged];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL displayGender = [defaults valueForKey:@"BS_DISPLAY_GENDER"];
    BOOL displayZipCode = [defaults valueForKey:@"BS_DISPLAY_ZIPCODE"];
    BOOL condition = YES;
    // This 'tabs' to next field when entering digits
    if (newLength > 0) {
        if (textField != firstname && firstname.text.length == 0)
            condition = NO;
        if (textField != lastname && lastname.text.length == 0)
            condition = NO;
        if (displayZipCode == YES && textField != zipCode && zipCode.text.length == 0)
            condition = NO;
        if (textField != email && email.text.length == 0)
            condition = NO;
        if (displayGender == YES && gender.selectedSegmentIndex == -1)
            condition = NO;
        
        if (condition == NO)
        {
            continueButton.enabled = NO;
            continueButton.backgroundColor = [UIColor lightGrayColor];
        } else{
            continueButton.enabled = YES;
            continueButton.backgroundColor = [UIColor colorWithRed:0.000323687 green:0.69973 blue:0.231126 alpha:1];
        }

    }
    //this goes to previous field as you backspace through them, so you don't have to tap into them individually
    else {
        continueButton.enabled = NO;
        continueButton.backgroundColor = [UIColor lightGrayColor];

    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL displayZipCode = [defaults valueForKey:@"BS_DISPLAY_ZIPCODE"];
    
    if (textField == firstname){
        [lastname becomeFirstResponder];
    } else if (textField == lastname){
        if (displayZipCode == YES)
            [zipCode becomeFirstResponder];
        else
            [email becomeFirstResponder];
    } else if (textField == zipCode){
        [email becomeFirstResponder];
    } else if (textField == email){
        [email resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)action:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL displayGender = [defaults valueForKey:@"BS_DISPLAY_GENDER"];
    BOOL displayZipCode = [defaults valueForKey:@"BS_DISPLAY_ZIPCODE"];
    BOOL condition = YES;
    
    if (firstname.text.length == 0)
        condition = NO;
    if (lastname.text.length == 0)
        condition = NO;
    if (displayZipCode == YES && zipCode.text.length == 0)
        condition = NO;
    if (email.text.length == 0)
        condition = NO;
    if (displayGender == YES && gender.selectedSegmentIndex == -1)
        condition = NO;
    
    if (condition == NO){
        continueButton.enabled = NO;
        continueButton.backgroundColor = [UIColor lightGrayColor];
    } else{
        continueButton.enabled = YES;
        continueButton.backgroundColor = [UIColor colorWithRed:0.000323687 green:0.69973 blue:0.231126 alpha:1];
    }
}

- (IBAction)confirmFourthRegister:(UIButton *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:firstname.text forKey:@"BS_FIRSTNAME"];
    [defaults setObject:lastname.text forKey:@"BS_LASTNAME"];
    [defaults setObject:zipCode.text forKey:@"BS_ZIPCODE"];
    [defaults setObject:email.text forKey:@"BS_EMAIL"];
    [defaults setInteger:gender.selectedSegmentIndex forKey:@"BS_GENDER"];
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
