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
@property NSString *name;

-(instancetype)initWithURL:(NSURL*)URL name:(NSString*)name;
-(instancetype)initWithURL:(NSURL *)URL name:(NSString*)name availableSeats:(int)amount;
-(instancetype)initWithString:(NSString *)urlString name:(NSString*)name;

+(NSColor*)colorForAvailable:(int)availableSeats oldAvailable:(int)oldAvailableSeats;

@end