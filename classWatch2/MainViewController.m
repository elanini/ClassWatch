//
//  ViewController.m
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import "MainViewController.h"
#import "CWClassObject.h"
#import "CustomStatusView.h"
#import "PrefWindowController.h"

@interface MainViewController ()
@property (strong, nonatomic) NSStatusItem *statusItem;
@property NSArray *classList;
@property CustomStatusView *myView;
@property NSWindowController *prefwc;
@end

@implementation MainViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        [self loadPreferences];
        [self initializeStatusItem];
    }
    return self;
}


-(void)initializeStatusItem
{
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _myView = [[CustomStatusView alloc] init];
    _myView.statusItem = _statusItem;
    NSMenu *menu = [[NSMenu alloc] init];
    
    [[menu addItemWithTitle:@"Preferences" action:@selector(showPrefWindow:) keyEquivalent:@""] setTarget:self];
    [menu addItem:[NSMenuItem separatorItem]];
    [menu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@""];
    [_myView setMenu:menu];
    [self setClassString];
    [_statusItem setView:_myView];
    [_statusItem setHighlightMode:YES];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:60
                                     target:self
                                   selector:@selector(setClassString)
                                   userInfo:nil
                                    repeats:YES];


}

-(void)showPrefWindow:(id)sender
{
    NSStoryboard *sb = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    self.prefwc = [sb instantiateControllerWithIdentifier:@"PreferencesWindowController"];
    [self.prefwc showWindow:nil];
    [[self.prefwc window] makeMainWindow];
    [[self.prefwc window] makeKeyAndOrderFront:nil];
    [[self.prefwc window] setDelegate:self];
    

}

-(void)windowWillClose:(NSNotification *)notification
{
    [self loadPreferences];
    [self performSelectorInBackground:@selector(setClassString) withObject:nil];
    self.prefwc = nil;
}

-(void)setClassString
{
        
    for (CWClassObject *classObject in self.classList) {
        NSLog(@"name = %@", classObject.name);
        int count = [self updateClassDataForURL:classObject.classURL];
        if (count < 0)
            break;
        
        [self.myView
         updateClassString:[NSString stringWithFormat:@" %8s : %3ld", classObject.name.UTF8String, (long)count]
         filled:count == 0 ? YES : NO];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myView setNeedsDisplay:YES];
    });

}



-(int)updateClassDataForURL:(NSURL*)classURL {
    NSError *err;
    NSString *contents = [[NSString alloc] initWithContentsOfURL:classURL encoding:NSUTF8StringEncoding error:&err];
    if (err) {
        NSLog(@"%@", err);
        return -3;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"Available Seats.*\n[^\\d]*(\\d*)" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:contents options:0 range:NSMakeRange(0, contents.length)];
    if (match) {
        NSString *amount = [contents substringWithRange:[match rangeAtIndex:1]];
        if (amount)
            return amount.intValue;
        else
            return -2;
    } else {
        return -1;
    }
    
}


-(void)loadPreferences
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    self.classList = [CWClassObject objectsFromPList:[def arrayForKey:@"classList"]];
}


@end
