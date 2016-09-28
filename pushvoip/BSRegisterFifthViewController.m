//
//  BSRegisterFifthViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFifthViewController.h"

@implementation BSRegisterFifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Justificatif";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
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
