//
//  InterfaceController.m
//  pushvoip watch Extension
//
//  Created by Christophe Mei on 15/09/2016.
//  Copyright © 2016 Mei. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceMap *map;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    // Location of Apple headquarters
    CLLocationCoordinate2D mapLocation = CLLocationCoordinate2DMake(37, -122);
    
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(1, 1);
    
    // Other colors include red and green pins
    [self.map addAnnotation:mapLocation withPinColor: WKInterfaceMapPinColorPurple];
    
    [self.map addAnnotation:mapLocation withPinColor: WKInterfaceMapPinColorPurple];
    [self.map setRegion:(MKCoordinateRegionMake(mapLocation, coordinateSpan))];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



