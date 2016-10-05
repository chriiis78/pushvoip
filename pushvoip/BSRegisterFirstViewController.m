//
//  BSRegisterFirstViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 27/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFirstViewController.h"
#import "BSRegisterFirstCountryTableViewController.h"

@interface BSRegisterFirstViewController () {
    NSMutableDictionary *sortedCountryDict;
}
@end

@implementation BSRegisterFirstViewController

@synthesize countryName;
@synthesize countryFlag;
@synthesize callingCode;
@synthesize lineTop;
@synthesize lineMiddle;
@synthesize lineBottom;
@synthesize lineVertical;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Téléphone";
    

    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]initWithTitle:@"Annuler" style:UIBarButtonItemStyleDone target:self action:@selector(btnOnClick:)];
    self.navigationItem.leftBarButtonItem = btnLogout;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName: @"HelveticaNeue-Thin" size: 20]}];
    
    lineTop.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    lineMiddle.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    lineBottom.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    lineVertical.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    NSString *country = [[NSLocale systemLocale] displayNameForKey:NSLocaleCountryCode value:countryCode];
    [countryName setTitle: country forState:UIControlStateNormal];
    
    NSArray *countriesArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmergencyNumbers2" ofType:@"plist"]];
    
    NSLocale *locale = [NSLocale currentLocale];
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
    NSLog(@"sortedCountryDirt %@", sortedCountryDict);
    
    NSArray *countrySelected = [sortedCountryDict objectForKey:country];
    [countryFlag setImage: [UIImage imageNamed:[self getImageFilename:countrySelected[2]]]];
    callingCode.text = countrySelected[3];

}

- (NSString *)getImageFilename:(NSString *)sections
{
    NSString *imageFilename = [sections stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"%@", imageFilename);
    imageFilename = [imageFilename stringByAppendingString:@"@2x.png"];
    NSLog(@"%@", imageFilename);
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
        NSLog(@"TEST");
        // Get destination view
        BSRegisterFirstCountryTableViewController *vc = (BSRegisterFirstCountryTableViewController *)segue.destinationViewController;
        // Get button tag number (or do whatever you need to do here, based on your object
        NSLog(@"%@", countryName.titleLabel.text);
        vc.countrySelected = countryName.titleLabel.text;
        NSLog(@"%@", vc.countrySelected);
    }
}
@end
