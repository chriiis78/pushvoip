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
    NSDictionary *animals;
    NSArray *animalSectionTitles;
    NSArray *animalIndexTitles;
    NSIndexPath *countrySelected;
}
@end

@implementation BSRegisterFirstCountryTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    animals = @{@"B" : @[@"Bear", @"Black Swan", @"Buffalo"],
                @"C" : @[@"Camel", @"Cockatoo"],
                @"D" : @[@"Dog", @"Donkey"],
                @"E" : @[@"Emu"],
                @"G" : @[@"Giraffe", @"Greater Rhea"],
                @"H" : @[@"Hippopotamus", @"Horse"],
                @"K" : @[@"Koala"],
                @"L" : @[@"Lion", @"Llama"],
                @"M" : @[@"Manatus", @"Meerkat"],
                @"P" : @[@"Panda", @"Peacock", @"Pig", @"Platypus", @"Polar Bear"],
                @"R" : @[@"Rhinoceros"],
                @"S" : @[@"Seagull"],
                @"T" : @[@"Tasmania Devil"],
                @"W" : @[@"Whale", @"Whale Shark", @"Wombat"]};
    
    animalSectionTitles = [[animals allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    animalIndexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
}

- (NSString *)getImageFilename:(NSString *)animal
{
    NSString *imageFilename = [[animal lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    imageFilename = [imageFilename stringByAppendingString:@".jpg"];
    
    return imageFilename;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [animalSectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [animalSectionTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:section];
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    return [sectionAnimals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *sectionTitle = [animalSectionTitles objectAtIndex:indexPath.section];
    NSArray *sectionAnimals = [animals objectForKey:sectionTitle];
    NSString *animal = [sectionAnimals objectAtIndex:indexPath.row];
    cell.textLabel.text = animal;
    cell.imageView.image = [UIImage imageNamed:[self getImageFilename:animal]];
    if (self->countrySelected != nil &&  indexPath.section == self->countrySelected.section && indexPath.row == self->countrySelected.row){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return animalIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [animalSectionTitles indexOfObject:title];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self->countrySelected = indexPath;
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
}

@end
