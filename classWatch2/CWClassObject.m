//
//  CWClassObject.m
//  classWatch2
//
//  Created by Eric Lanini on 2/25/16.
//  Copyright © 2016 Eric Lanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWClassObject.h"

@implementation CWClassObject

-(instancetype)init
{
    return [self initWithURL:nil name:nil availableSeats:0];
}

-(instancetype)initWithString:(NSString *)urlString
{
    NSURL *URL = [NSURL URLWithString:urlString];
    return [self initWithURL:URL name:[CWClassObject nameFromURL:URL]];
}

-(instancetype)initWithURL:(NSURL*)URL name:(NSString*)name
{
    return [self initWithURL:URL name:name availableSeats:0];
}

-(instancetype)initWithString:(NSString*)urlString name:(NSString*)name
{
    return [self initWithURL:[NSURL URLWithString:urlString] name: name availableSeats:0];
}

-(instancetype)initWithURL:(NSURL *)URL name:(NSString*)name availableSeats:(int)amount
{
    self = [super init];
    if (self) {
        self.classURL = URL;
        self.availableSeats = amount;
        self.name = name;
    }
    return self;
}

+(NSString*)nameFromURL:(NSURL*)classURL
{
    NSString *name;
    NSError *err;
    NSString *contents = [[NSString alloc] initWithContentsOfURL:classURL encoding:NSUTF8StringEncoding error:&err];
    if (err) {
        NSLog(@"cant get url; error: %@", err);
        return nil;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([A-Z]+) ([0-9]+)([A-Z])? -" options:NSRegularExpressionCaseInsensitive error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:contents options:0 range:NSMakeRange(0, contents.length)];

    if (match) {
        NSString *abbrev = [contents substringWithRange:[match rangeAtIndex:1]];
        NSString *num = [contents substringWithRange:[match rangeAtIndex:2]];
        NSString *letter = @"";
        if ([match rangeAtIndex:3].length > 0) {
            letter = [contents substringWithRange:[match rangeAtIndex:3]];
        }
        name = [NSString stringWithFormat:@"%4@%3d%@", abbrev, num.intValue, letter];
    } else {
        return nil;
    }

    
    return name;
}

+(NSArray<CWClassObject*>*)objectsFromPList:(NSArray<NSDictionary*>*)plist
{
    NSMutableArray *classes = [[NSMutableArray alloc] initWithCapacity:plist.count];
    for (NSDictionary *dict in plist) {
        [classes addObject:[[CWClassObject alloc] initWithString:dict[@"URL"] name:dict[@"name"]]];
    }
    return [classes copy];
}

+(NSArray<NSDictionary*>*)plistFromObjects:(NSArray<CWClassObject*>*)objects
{
    NSMutableArray <NSDictionary*>*dicts = [[NSMutableArray alloc] initWithCapacity:objects.count];
    for (CWClassObject *obj in objects) {
        [dicts addObject:@{
                            @"URL"  : obj.classURL.absoluteString,
                            @"name" : obj.name
                           }];
    }
    return [dicts copy];
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