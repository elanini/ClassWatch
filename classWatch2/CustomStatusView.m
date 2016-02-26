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
@property NSArray *classData;
@end

@implementation CustomStatusView

-(id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if(self) {
        self.classData = @[@{
                                @"class": @"class one",
                                @"openings": @100
                                }];
    }
    
    return self;
}

-(void)renderClassesWithTitlesAndEnrolled:(NSArray *)classData
{
    self.classData = classData;
    [self setNeedsDisplay:YES];
}

-(NSAttributedString*)stringForClass:(NSString*)className seats:(NSInteger)seats
{
    return [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%8s : %3ld", className.UTF8String, (long)seats ]
                                           attributes:@{NSForegroundColorAttributeName : seats == 0 ? [NSColor redColor] : [NSColor greenColor],
                                                                   NSFontAttributeName : [NSFont fontWithName:@"Helvetica" size:6]}];
}

-(NSInteger)widthForClassAmount:(NSInteger)amt
{
    int textwidth = (int)[[self stringForClass:@"CMPS101" seats:1] size].width;
    NSLog(@"%ld %f %d", (long)amt, ceil((float)amt/2.0f), textwidth);
    return ceil(amt/2.0f)*textwidth;
}

-(void)drawRect:(NSRect)dirtyRect
{
    [self.statusItem drawStatusBarBackgroundInRect:[self bounds] withHighlight:NO];
    
    NSRect viewRect = NSInsetRect(self.bounds, 20.0f, 20.0f);
    [@"fuck" drawInRect:viewRect withAttributes:nil];
}

@end