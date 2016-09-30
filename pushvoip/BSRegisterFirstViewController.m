//
//  BSRegisterFirstViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFirstViewController.h"

@implementation BSRegisterFirstViewController

@synthesize countryName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Téléphone";
    

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    
    if ([countryName.titleLabel.text isEqualToString:@"Pays"]){
        NSLocale *currentLocale = [NSLocale currentLocale];
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        NSString *country = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
        [countryName setTitle: country forState:UIControlStateNormal];
    }
    
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    
}

@end
