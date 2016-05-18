//
//  CustomStatusView.h
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import "CWClassObject.h"
@import AppKit;

@interface CustomStatusView : NSView <NSMenuDelegate>
@property NSStatusItem *statusItem;


-(void)updateClassString:(NSString *)classString filled:(BOOL)isFull;
@end