//
//  CustomStatusView.h
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

@import AppKit;

@interface CustomStatusView : NSView
@property NSStatusItem *statusItem;

-(void)renderClassesWithTitlesAndEnrolled:(NSArray *)classData;
-(NSInteger)widthForClassAmount:(NSInteger)amt;

@end