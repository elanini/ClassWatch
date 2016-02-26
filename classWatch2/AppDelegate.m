//
//  AppDelegate.m
//  classWatch2
//
//  Created by Eric Lanini on 2/23/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import "AppDelegate.h"
#import "CWClassObject.h"
#import "CustomStatusView.h"

@interface AppDelegate ()
@property (strong, nonatomic) NSStatusItem *statusItem;
@property NSArray *classArray;
@property CustomStatusView *myView;
@end

@implementation AppDelegate



-(void)setClassString
{
    NSMutableArray *classStrings = [[NSMutableArray alloc] init];
    //NSMutableAttributedString *fullString = [[NSMutableAttributedString alloc] init];
    BOOL initial = YES;
    for (CWClassObject *classObject in self.classArray) {
        int newCount = [self updateClassDataForURL:classObject.classURL];
        if (newCount < 0)
            break;
        [classStrings addObject:[[NSAttributedString alloc]
                                            initWithString:[NSString stringWithFormat:@"%8s : %3ld", classObject.name.UTF8String, (long)newCount]
                                            attributes:@{
                                                         NSForegroundColorAttributeName : [CWClassObject colorForAvailable:newCount oldAvailable:classObject.oldAvailableSeats],
                                                         NSFontAttributeName : [NSFont fontWithName:@"Courier" size:8]
                                                         }
                                            ]];
        classObject.oldAvailableSeats = newCount;
        initial = NO;
    }
    self.myView.classStrings = classStrings;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSMutableArray *array =  [[NSMutableArray alloc] init];
    [array addObject:[[CWClassObject alloc] initWithString:@"https://pisa.ucsc.edu/class_search/index.php?action=detail&class_data=YTozMDp7czo0OiJTVFJNIjtzOjQ6IjIxNjIiO3M6OToiQ0xBU1NfTkJSIjtzOjU6IjYwOTU1IjtzOjEzOiJDTEFTU19TRUNUSU9OIjtzOjI6IjAxIjtzOjEzOiJDTEFTU19NVEdfTkJSIjtzOjE6IjEiO3M6MTI6IlNFU1NJT05fQ09ERSI7czoxOiIxIjtzOjEwOiJDTEFTU19TVEFUIjtzOjE6IkEiO3M6NzoiU1VCSkVDVCI7czo0OiJDTVBTIjtzOjExOiJDQVRBTE9HX05CUiI7czo0OiIgMTAxIjtzOjU6IkRFU0NSIjtzOjE5OiJBYnN0cmFjdCBEYXRhIFR5cGVzIjtzOjEzOiJTU1JfQ09NUE9ORU5UIjtzOjM6IkxFQyI7czoxMDoiU1RBUlRfVElNRSI7czo3OiIwMjowMFBNIjtzOjg6IkVORF9USU1FIjtzOjc6IjAzOjEwUE0iO3M6OToiRkFDX0RFU0NSIjtzOjE2OiJUaGltIExlY3R1cmUgMDAzIjtzOjM6Ik1PTiI7czoxOiJZIjtzOjQ6IlRVRVMiO3M6MToiTiI7czozOiJXRUQiO3M6MToiWSI7czo1OiJUSFVSUyI7czoxOiJOIjtzOjM6IkZSSSI7czoxOiJZIjtzOjM6IlNBVCI7czoxOiJOIjtzOjM6IlNVTiI7czoxOiJOIjtzOjk6IkVOUkxfU1RBVCI7czoxOiJPIjtzOjg6IldBSVRfVE9UIjtzOjE6IjAiO3M6ODoiRU5STF9DQVAiO3M6MzoiMTgwIjtzOjg6IkVOUkxfVE9UIjtzOjI6IjI5IjtzOjk6IkxBU1RfTkFNRSI7czo4OiJDb21hbmR1ciI7czoxMDoiRklSU1RfTkFNRSI7czo5OiJTZXNoYWRocmkiO3M6MTE6Ik1JRERMRV9OQU1FIjtOO3M6MTY6IkNPTUJJTkVEX1NFQ1RJT04iO3M6MToiICI7czo1OiJUT1BJQyI7TjtzOjEyOiJESVNQTEFZX05BTUUiO3M6MTE6IkNvbWFuZHVyLFMuIjt9" name:@"CMPS101"]];
    [array addObject:[[CWClassObject alloc] initWithString:@"https://pisa.ucsc.edu/class_search/index.php?action=detail&class_data=YTozMDp7czo0OiJTVFJNIjtzOjQ6IjIxNjIiO3M6OToiQ0xBU1NfTkJSIjtzOjU6IjYwOTY1IjtzOjEzOiJDTEFTU19TRUNUSU9OIjtzOjI6IjAxIjtzOjEzOiJDTEFTU19NVEdfTkJSIjtzOjE6IjEiO3M6MTI6IlNFU1NJT05fQ09ERSI7czoxOiIxIjtzOjEwOiJDTEFTU19TVEFUIjtzOjE6IkEiO3M6NzoiU1VCSkVDVCI7czo0OiJDTVBTIjtzOjExOiJDQVRBTE9HX05CUiI7czo1OiIgMTA0QSI7czo1OiJERVNDUiI7czoxOToiRnVuZCBDb21waWxlciBEZXMgMSI7czoxMzoiU1NSX0NPTVBPTkVOVCI7czozOiJMRUMiO3M6MTA6IlNUQVJUX1RJTUUiO3M6NzoiMDU6MDBQTSI7czo4OiJFTkRfVElNRSI7czo3OiIwNjo0NVBNIjtzOjk6IkZBQ19ERVNDUiI7czoxNzoiSiBCYXNraW4gRW5nciAxNTIiO3M6MzoiTU9OIjtzOjE6IlkiO3M6NDoiVFVFUyI7czoxOiJOIjtzOjM6IldFRCI7czoxOiJZIjtzOjU6IlRIVVJTIjtzOjE6Ik4iO3M6MzoiRlJJIjtzOjE6Ik4iO3M6MzoiU0FUIjtzOjE6Ik4iO3M6MzoiU1VOIjtzOjE6Ik4iO3M6OToiRU5STF9TVEFUIjtzOjE6Ik8iO3M6ODoiV0FJVF9UT1QiO3M6MToiMCI7czo4OiJFTlJMX0NBUCI7czoyOiI3NSI7czo4OiJFTlJMX1RPVCI7czoyOiI1NCI7czo5OiJMQVNUX05BTUUiO3M6NjoiTWFja2V5IjtzOjEwOiJGSVJTVF9OQU1FIjtzOjY6Ildlc2xleSI7czoxMToiTUlERExFX05BTUUiO3M6MToiRiI7czoxNjoiQ09NQklORURfU0VDVElPTiI7czoxOiIgIjtzOjU6IlRPUElDIjtOO3M6MTI6IkRJU1BMQVlfTkFNRSI7czoxMToiTWFja2V5LFcuRi4iO30%3D" name:@"CMPS104A"]];
    [array addObject:[[CWClassObject alloc] initWithString:@"https://pisa.ucsc.edu/class_search/index.php?action=detail&class_data=YTozMDp7czo0OiJTVFJNIjtzOjQ6IjIxNjIiO3M6OToiQ0xBU1NfTkJSIjtzOjU6IjYwOTY5IjtzOjEzOiJDTEFTU19TRUNUSU9OIjtzOjI6IjAxIjtzOjEzOiJDTEFTU19NVEdfTkJSIjtzOjE6IjEiO3M6MTI6IlNFU1NJT05fQ09ERSI7czoxOiIxIjtzOjEwOiJDTEFTU19TVEFUIjtzOjE6IkEiO3M6NzoiU1VCSkVDVCI7czo0OiJDTVBTIjtzOjExOiJDQVRBTE9HX05CUiI7czo0OiIgMTA5IjtzOjU6IkRFU0NSIjtzOjE1OiJBZHYgUHJvZ3JhbW1pbmciO3M6MTM6IlNTUl9DT01QT05FTlQiO3M6MzoiTEVDIjtzOjEwOiJTVEFSVF9USU1FIjtzOjc6IjA3OjAwUE0iO3M6ODoiRU5EX1RJTUUiO3M6NzoiMDg6NDVQTSI7czo5OiJGQUNfREVTQ1IiO3M6MTc6IkogQmFza2luIEVuZ3IgMTUyIjtzOjM6Ik1PTiI7czoxOiJZIjtzOjQ6IlRVRVMiO3M6MToiTiI7czozOiJXRUQiO3M6MToiWSI7czo1OiJUSFVSUyI7czoxOiJOIjtzOjM6IkZSSSI7czoxOiJOIjtzOjM6IlNBVCI7czoxOiJOIjtzOjM6IlNVTiI7czoxOiJOIjtzOjk6IkVOUkxfU1RBVCI7czoxOiJPIjtzOjg6IldBSVRfVE9UIjtzOjE6IjAiO3M6ODoiRU5STF9DQVAiO3M6MzoiMTAwIjtzOjg6IkVOUkxfVE9UIjtzOjI6IjcyIjtzOjk6IkxBU1RfTkFNRSI7czo2OiJNYWNrZXkiO3M6MTA6IkZJUlNUX05BTUUiO3M6NjoiV2VzbGV5IjtzOjExOiJNSURETEVfTkFNRSI7czoxOiJGIjtzOjE2OiJDT01CSU5FRF9TRUNUSU9OIjtzOjE6IiAiO3M6NToiVE9QSUMiO047czoxMjoiRElTUExBWV9OQU1FIjtzOjExOiJNYWNrZXksVy5GLiI7fQ%3D%3D" name:@"CMPS109"]];
    self.classArray = array;
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    _myView = [[CustomStatusView alloc] init];
    _myView.statusItem = _statusItem;
    _myView.title = @"fuckboysrus";
    [self setClassString];
    [_statusItem setView:_myView];
    
    
    //self.classArray = array;
    //CustomStatusView *view = [[CustomStatusView alloc] initWithFrame:NSZeroRect];
    //NSLog(@"%ld", (long)[view widthForClassAmount:3]);

    //_statusItem.button.title = @"fuck";
    //[self updateClassData];

    [NSTimer scheduledTimerWithTimeInterval:5.0
                                     target:self
                                   selector:@selector(setClassString)
                                   userInfo:nil
                                    repeats:YES];
 
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

@end
