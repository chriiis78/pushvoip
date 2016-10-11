//
//  BSRegisterFirstCountryTableViewController.m
//  pushvoip
//
//  Created by Christophe Mei on 28/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "BSRegisterFirstCountryTableViewController.h"
#import "BSRegisterFirstViewController.h"

@interface BSRegisterFirstCountryTableViewController () {
    NSArray *sections;
    NSArray *sectionTitles;
    NSMutableDictionary *sortedCountryDict;
}
@end

@implementation BSRegisterFirstCountryTableViewController
@synthesize countrySelected;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *countriesArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EmergencyNumbers2" ofType:@"plist"]];
    
    NSLocale *locale = [NSLocale currentLocale];
    NSMutableArray *countryCode = [[NSMutableArray alloc] init];;
    NSMutableArray *countryLongCode = [[NSMutableArray alloc] init];;
    NSMutableArray *callingCode = [[NSMutableArray alloc] init];;
    
    for (NSDictionary *array in countriesArray){
        [countryCode addObject:[array objectForKey:@"short_code"]];
        [countryLongCode addObject:[array objectForKey:@"long_country_code"]];
        [callingCode addObject:[NSString stringWithFormat:@"+%@", [array objectForKey:@"calling_code"]]];
    }
    
    sortedCountryDict = [[NSMutableDictionary alloc] init];
    NSInteger i = 0;
    while (i < countryCode.count) {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode[i]];
        [sortedCountryDict setObject:[NSArray arrayWithObjects:displayNameString, countryCode[i], countryLongCode[i], callingCode[i], nil] forKey:displayNameString];
        i = i + 1;
    }
    
    //Count for the section titles, like 'A' 'B' 'C', depends on your language
    NSInteger sectionTitlesCount = [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
    //Generate array to store all the section titles
    NSMutableArray *mutableSections = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        [mutableSections addObject:[NSMutableArray array]];
    }
    
    //Locate where the object should store in, the selector userName is the property name of a object which you can use as a condition.
    for (id object in sortedCountryDict) {
        NSInteger sectionNumber = [[UILocalizedIndexedCollation currentCollation]
                                   sectionForObject:object collationStringSelector:@selector(self)];
        [[mutableSections objectAtIndex:sectionNumber] addObject:object];
    }
    
    //resort the array by alphabetic
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
        NSArray *objectsForSection = [mutableSections objectAtIndex:idx];
        [mutableSections replaceObjectAtIndex:idx withObject:[[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:objectsForSection collationStringSelector:@selector(self)]];
    }
    
    //remove all the arr which contain nothing.
    NSArray *collections = [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    NSMutableArray *newArray = [NSMutableArray array];
    NSMutableArray *newTitleArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < mutableSections.count; i++) {
        NSArray *subArr = [mutableSections objectAtIndex:i];
        if (subArr.count == 0) {
            continue;
        }
        [newArray addObject:subArr];
        [newTitleArray addObject:[collections objectAtIndex:i]];
    }
    sections = newArray;
    sectionTitles = newTitleArray;
    [self.tableView reloadData];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return sectionTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (NSString *)getImageFilename:(NSString *)sections
{
    NSString *imageFilename = [sections stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageFilename = [imageFilename stringByAppendingString:@"@2x.png"];
    
    return imageFilename;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *sectionCountry = [sections objectAtIndex:section];
    return [sectionCountry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *sectionCountry = [sections objectAtIndex:indexPath.section];
    NSString *row = [sectionCountry objectAtIndex:indexPath.row];
    NSArray *country = [sortedCountryDict objectForKey:row];
    cell.textLabel.text = country[0];
    cell.detailTextLabel.text = country[3];;
    cell.imageView.image = [UIImage imageNamed:[self getImageFilename:country[2]]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([country[0] isEqualToString:countrySelected]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    BSRegisterFirstViewController *vca = (BSRegisterFirstViewController *)segue.destinationViewController;
    NSIndexPath *selectedPath = [self.tableView indexPathForCell:sender];
    
    [vca.countryName setTitle: [self.tableView cellForRowAtIndexPath:selectedPath].textLabel.text forState:UIControlStateNormal];
    [vca.countryFlag setImage: [self.tableView cellForRowAtIndexPath:selectedPath].imageView.image forState:UIControlStateNormal];
    vca.callingCode.text = [self.tableView cellForRowAtIndexPath:selectedPath].detailTextLabel.text;

}

@end
