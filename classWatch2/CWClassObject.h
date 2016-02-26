//
//  CWClassObject.h
//  classWatch2
//
//  Created by Eric Lanini on 2/25/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


@interface CWClassObject : NSObject

@property NSURL *classURL;
@property int availableSeats;
@property int oldAvailableSeats;

-(instancetype)initWithURL:(NSURL*)URL;
-(instancetype)initWithURL:(NSURL *)URL availableSeats:(int)amount;
-(instancetype)initWithString:(NSString*)urlString;
+(NSColor*)colorForAvailable:(int)availableSeats oldAvailable:(int)oldAvailableSeats;

@end