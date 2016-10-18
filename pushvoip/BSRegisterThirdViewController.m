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
@synthesize webCGU;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CGU";
    
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *urlBS = [defaults valueForKey:@"BS_CGU"];
    NSURL *url = [NSURL URLWithString:urlBS];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webCGU loadRequest:urlRequest];
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)checkValidButton:(UIButton *)sender {
    NSLog(@"%@", continueButton.backgroundColor);
    if (continueButton.enabled == NO){
        [checkButton setImage:[UIImage imageNamed:@"checkboxOn.png"] forState:UIControlStateNormal];
        continueButton.enabled = YES;
        continueButton.backgroundColor = [UIColor colorWithRed:0.000323687 green:0.69973 blue:0.231126 alpha:1];
    } else{
        [checkButton setImage:[UIImage imageNamed:@"checkboxOff.png"] forState:UIControlStateNormal];
        continueButton.enabled = NO;
        continueButton.backgroundColor = [UIColor colorWithRed:0.862861 green:0.862861 blue:0.862861 alpha:1];
    }

}

@end
