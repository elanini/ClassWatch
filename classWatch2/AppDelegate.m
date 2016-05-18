//
//  AppDelegate.m
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()
@property MainViewController *vc;
@end

@implementation AppDelegate



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.vc = [[MainViewController alloc] init];
}



@end
