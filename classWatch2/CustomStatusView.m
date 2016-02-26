//
//  CustomStatusView.m
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomStatusView.h"

@interface CustomStatusView ()

@end

@implementation CustomStatusView
@synthesize classStrings = _classStrings;

-(id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if(self) {
        self.title = @"";
    }
    NSLog(@"ran initWithFrame:%@", CGRectCreateDictionaryRepresentation(frameRect));
    return self;
}

-(void)setClassStrings:(NSArray *)classStrings
{
    [self.statusItem setLength:[CustomStatusView widthForClassAmount:classStrings.count]];
    _classStrings = classStrings;
    [self setNeedsDisplay:YES];
}

+(NSAttributedString*)stringForClass:(NSString*)className seats:(NSInteger)seats
{
    return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%9s : %03ld", className.UTF8String, (long)seats ]
                                           attributes:@{NSForegroundColorAttributeName : seats == 0 ? [NSColor redColor] : [NSColor greenColor],
                                                                   NSFontAttributeName : [NSFont fontWithName:@"Courier" size:8]}];
}

+(NSInteger)widthForClassAmount:(NSInteger)amt
{
    int textwidth = (int)ceil([[self stringForClass:@"CMPS101" seats:15] size].width);
    return ceil(amt/2.0f)*textwidth;
}

-(void)drawRect:(NSRect)dirtyRect
{
    int i=1;
    for (NSAttributedString *classString in self.classStrings) {
        int widthModifier = classString.size.width*(ceil(i/2.0)-1);
        int heightModifier = classString.size.height*((i-1)%2);
        [classString drawAtPoint:NSMakePoint(dirtyRect.origin.x+widthModifier, dirtyRect.origin.y+heightModifier-1)];
        i++;
    }
    
    
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