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
    return [self initWithURL:nil name:nil availableSeats:0];
}
-(instancetype)initWithURL:(NSURL*)URL name:(NSString*)name
{
    return [self initWithURL:URL name:name availableSeats:0];
}

-(instancetype)initWithString:(NSString*)urlString name:(NSString*)name
{
    return [self initWithURL:[NSURL URLWithString:urlString] name: name availableSeats:0];
}

-(instancetype)initWithURL:(NSURL *)URL name:(NSString*)name availableSeats:(int)amount
{
    self = [super init];
    if (self) {
        self.classURL = URL;
        self.availableSeats = amount;
        self.oldAvailableSeats = 0;
        self.name = name;
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