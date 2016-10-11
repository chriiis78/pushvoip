//
//  BSRegisterFourthViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFourthViewController.h"

@implementation BSRegisterFourthViewController

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
        _lineBottomConstraint.constant = -1;
        _genderLabel.hidden = YES;
        _gender.hidden = YES;
        
    }
    if (displayZipCode == NO){
        NSLog(@"Test2 ");
        _lineEmailConstraint.constant = -1;
        _zipCodeLabel.hidden = YES;
        _zipCode.hidden = YES;
    }
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Compte existant"
                                 message:@"Un compte avec ce numéro de téléphone existe déjà. Êtes-vous cette personne ?"
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
                                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                    
                                    [defaults synchronize];
                                }];
    
    [alert addAction:noButton];
    [alert addAction:yesButton];
    
    //[self presentViewController:alert animated:YES completion:nil];
    
    
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
