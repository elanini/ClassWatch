//
//  CustomStatusView.h
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import "CWClassObject.h"
@import AppKit;

@interface CustomStatusView : NSView
@property NSStatusItem *statusItem;
@property (nonatomic) NSString *title;
@property (nonatomic) NSArray *classStrings;


+(NSInteger)widthForClassAmount:(NSInteger)amt;
+(NSColor*)colorForAvailable:(int)availableSeats oldAvailable:(int)oldAvailableSeats;

@end