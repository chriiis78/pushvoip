//
//  BSRegisterFirstViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFirstViewController.h"
#import "BSRegisterSecondViewController.h"
#import "BSRegisterFirstCountryTableViewController.h"

@interface BSRegisterFirstViewController () {
    NSMutableDictionary *sortedCountryDict;
}
@end

@implementation BSRegisterFirstViewController

@synthesize countryName;
@synthesize countryFlag;
@synthesize callingCode;
@synthesize phoneNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Téléphone";
    

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 20]}];
    
    //lineTop.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"WAIT_CODE_TOKEN"] != nil){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *myController = [sb instantiateViewControllerWithIdentifier:@"BSRegisterSecondViewController"];
        [self.navigationController pushViewController: myController animated:YES];
    }
    
    NSString *country = [defaults objectForKey:@"COUNTRY"];
    NSString *myPhoneNumber = [defaults objectForKey:@"PHONE_NUMBER"];
    NSLog(@"%@", myPhoneNumber);
    if (myPhoneNumber != nil){
        [phoneNumber setText:myPhoneNumber];
    }
    //[defaults setObject:phoneNumber forKey:@"PHONE_NUMBER"];
    [defaults synchronize];
    
    NSLocale *locale = [NSLocale currentLocale];
    
    if (country != nil){
        [countryName setTitle: country forState:UIControlStateNormal];
    } else{
        NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
        country = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
        [countryName setTitle: country forState:UIControlStateNormal];
    }
    
    NSArray *countriesArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmergencyNumbers2" ofType:@"plist"]];
    
    NSMutableArray *countryCodeArray = [[NSMutableArray alloc] init];;
    NSMutableArray *countryLongCodeArray = [[NSMutableArray alloc] init];;
    NSMutableArray *callingCodeArray = [[NSMutableArray alloc] init];;
    
    for (NSDictionary *array in countriesArray){
        [countryCodeArray addObject:[array objectForKey:@"short_code"]];
        [countryLongCodeArray addObject:[array objectForKey:@"long_country_code"]];
        [callingCodeArray addObject:[NSString stringWithFormat:@"+%@", [array objectForKey:@"calling_code"]]];
    }
    
    sortedCountryDict = [[NSMutableDictionary alloc] init];
    NSInteger i = 0;
    while (i < countryCodeArray.count) {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCodeArray[i]];
        [sortedCountryDict setObject:[NSArray arrayWithObjects:displayNameString, countryCodeArray[i], countryLongCodeArray[i], callingCodeArray[i], nil] forKey:displayNameString];
        i = i + 1;
    }
    
    NSArray *countrySelected = [sortedCountryDict objectForKey:country];
    [countryFlag setImage: [UIImage imageNamed:[self getImageFilename:countrySelected[2]]]];
    callingCode.text = countrySelected[3];
}

- (NSString *)getImageFilename:(NSString *)sections
{
    NSString *imageFilename = [sections stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageFilename = [imageFilename stringByAppendingString:@"@2x.png"];
    return imageFilename;
}

-(void)btnOnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"countryTable"]) {
        // Get destination view
        BSRegisterFirstCountryTableViewController *vc = (BSRegisterFirstCountryTableViewController *)segue.destinationViewController;
        // Get button tag number (or do whatever you need to do here, based on your object
        vc.countrySelected = countryName.titleLabel.text;
    }
}
- (IBAction)confirmRegisterFirst:(UIButton *)sender {
    NSLog(@"First");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"BLA" forKey:@"WAIT_CODE_TOKEN"];
    [defaults setObject:countryName.titleLabel.text forKey:@"COUNTRY"];
    NSLog(@"%@", countryName.titleLabel.text);
    NSLog(@"%@", phoneNumber.text);
    [defaults setObject:phoneNumber.text forKey:@"PHONE_NUMBER"];
    [defaults synchronize];
}
@end
