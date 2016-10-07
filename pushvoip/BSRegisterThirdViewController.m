//
//  BSRegisterThirdViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterThirdViewController.h"

@implementation BSRegisterThirdViewController
@synthesize checkButton;
@synthesize continueButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CGU";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)checkValidButton:(UIButton *)sender {
    if (continueButton.enabled == NO){
        [checkButton setImage:[UIImage imageNamed:@"checkboxOn.png"] forState:UIControlStateNormal];
        continueButton.enabled = YES;
        continueButton.backgroundColor = [UIColor colorWithRed:0.000323687 green:0.69973 blue:0.231126 alpha:1];
    } else{
        [checkButton setImage:[UIImage imageNamed:@"checkboxOff.png"] forState:UIControlStateNormal];
        continueButton.enabled = NO;
        continueButton.backgroundColor = [UIColor lightGrayColor];
    }

}

@end
