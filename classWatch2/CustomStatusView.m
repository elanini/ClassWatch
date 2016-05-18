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
@property (nonatomic) NSMutableArray *classStrings;
@property (nonatomic) BOOL isMenuVisible;

@end

@implementation CustomStatusView


-(id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    
    if(self) {
        self.classStrings = [[NSMutableArray alloc] init];
        self.isMenuVisible = NO;
    }
    return self;
}

-(void)updateClassString:(NSString *)classString filled:(BOOL)isFull
{
    NSString *classSubString = [classString substringToIndex: 10];
    NSUInteger index = [self.classStrings indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([((NSAttributedString*)obj).string containsString:classSubString]) {
            *stop = YES;
            return YES;
        }
        return NO;
    }];
    
    if (index == NSNotFound) {
        [self.classStrings addObject:[CustomStatusView attributedStringForString:classString filled:isFull]];
    } else {
        [self.classStrings replaceObjectAtIndex:index withObject:[CustomStatusView attributedStringForString:classString filled:isFull]];
    }
}

#pragma drawing

+(NSAttributedString*)attributedStringForString:(NSString *)classString filled:(BOOL)isFull
{
    return [[NSAttributedString alloc] initWithString:classString attributes:@{NSForegroundColorAttributeName : (isFull ? [NSColor redColor] : [NSColor greenColor]),
                                                                               NSFontAttributeName : [NSFont fontWithName:@"Courier" size:9]}];
}

-(NSAttributedString*)defaultString
{
    return [[NSAttributedString alloc] initWithString:@"CW" attributes:@{NSForegroundColorAttributeName : [NSColor whiteColor],
                                                                                 NSFontAttributeName : [NSFont fontWithName:@"Courier" size:16]}];
}

-(void)setNeedsDisplay:(BOOL)needsDisplay
{
    if (self.classStrings.count == 0) {
        [self.statusItem setLength:[self defaultString].size.width];
    } else {
        [self.statusItem setLength:[CustomStatusView widthForClassAmount:self.classStrings.count]];
    }
    [super setNeedsDisplay:needsDisplay];
}

+(NSInteger)widthForClassAmount:(NSInteger)amt
{
    int textwidth = (int)ceil([self attributedStringForString:@" AAAAAAAA : 000" filled:YES].size.width);
    return ceil(amt/2.0f)*textwidth;
}

-(void)drawRect:(NSRect)dirtyRect
{
    if (self.classStrings.count == 0) {
        [[self defaultString] drawAtPoint:NSMakePoint(dirtyRect.origin.x, dirtyRect.origin.y)];
    } else {
        int i=1;
        for (NSAttributedString *classString in self.classStrings) {
            int widthModifier = classString.size.width*(ceil(i/2.0)-1);
            int heightModifier = classString.size.height*((i-1)%2);
            [classString drawAtPoint:NSMakePoint(dirtyRect.origin.x+widthModifier, dirtyRect.origin.y+heightModifier-1)];
            i++;
        }
    }
    
}



#pragma menu handling

- (void)mouseDown:(NSEvent *)event {
    [[self menu] setDelegate:self];
    [self.statusItem popUpStatusItemMenu:[self menu]];
    [self setNeedsDisplay:YES];
}

- (void)rightMouseDown:(NSEvent *)event {
    // Treat right-click just like left-click
    [self mouseDown:event];
}

- (void)menuWillOpen:(NSMenu *)menu {
    self.isMenuVisible = YES;
    [self setNeedsDisplay:YES];
}

- (void)menuDidClose:(NSMenu *)menu {
    self.isMenuVisible = NO;
    [menu setDelegate:nil];
    [self setNeedsDisplay:YES];
}





@end