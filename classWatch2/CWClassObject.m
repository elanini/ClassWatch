//
//  CWClassObject.m
//  classWatch2
//
//  Created by Eric Lanini on 2/25/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWClassObject.h"

@implementation CWClassObject

-(instancetype)init
{
    return [self initWithURL:nil availableSeats:0];
}
-(instancetype)initWithURL:(NSURL*)URL
{
    return [self initWithURL:URL availableSeats:0];
}

-(instancetype)initWithString:(NSString*)urlString
{
    return [self initWithURL:[NSURL URLWithString:urlString] availableSeats:0];
}

-(instancetype)initWithURL:(NSURL *)URL availableSeats:(int)amount
{
    self = [super init];
    if (self) {
        self.classURL = URL;
        self.availableSeats = amount;
        self.oldAvailableSeats = 0;
    }
    return self;
}

+(NSColor *)colorForAvailable:(int)availableSeats oldAvailable:(int)oldAvailableSeats
{
    NSColor *color;
    if (oldAvailableSeats < availableSeats) {
        color = [NSColor redColor];
    } else if (availableSeats > oldAvailableSeats) {
        color = [NSColor greenColor];
    } else {
        color = [NSColor whiteColor];
    }
    
    return color;
}

@end