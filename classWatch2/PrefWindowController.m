//
//  PrefWindowController.m
//  classWatch2
//
//  Created by Eric Lanini on 5/11/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import "PrefWindowController.h"
#import "CWClassObject.h"

@interface PrefWindowController ()
@property (strong) IBOutlet NSTableView *tableView;
@property NSArray <NSDictionary*>*classList;
@end

@implementation PrefWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPreferences];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setAllowsMultipleSelection:YES];
}

-(void)loadPreferences
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSArray <NSDictionary*>*storedClasses = [def arrayForKey:@"classList"];
    
    if (!storedClasses || storedClasses.count == 0) {
        self.classList = @[];
        return;
    }
    
    self.classList = storedClasses;
    
}


-(void)syncData
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    [def setValue:self.classList forKey:@"classList"];
    [def synchronize];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.classList.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView* view = [tableView makeViewWithIdentifier:@"MyCell" owner:nil];
    view.textField.stringValue = self.classList[row][@"name"];
    return view;
}

- (IBAction)addPress:(id)sender {
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Add"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Enter URL:"];
    [alert setInformativeText:@""];
    [alert setAlertStyle:NSInformationalAlertStyle];
    
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input setStringValue:@""];
    [alert setAccessoryView:input];
    NSInteger button = [alert runModal];
    
    if (button != NSAlertFirstButtonReturn) {
        return;
    }
    [input validateEditing];
    NSString *url = [input stringValue];

    NSString *className = [CWClassObject nameFromURL:[NSURL URLWithString:url]];
    if (!className) {
        NSLog(@"error, couldnt get name for url");
        return;
    }
    
    NSDictionary *newClass = @{@"URL":url, @"name":className};
    

    self.classList = [self.classList arrayByAddingObject:newClass];
    [self syncData];
    [self.tableView reloadData];
}



- (IBAction)removePress:(id)sender {
    NSIndexSet *selectedIndexes = [self.tableView selectedRowIndexes];
    if (!selectedIndexes)
        return;
    
    NSMutableArray *newArray = [NSMutableArray arrayWithArray:self.classList];
    [newArray removeObjectsAtIndexes:selectedIndexes];
    self.classList = [newArray copy];
    [self syncData];
    [self.tableView reloadData];
}
@end
