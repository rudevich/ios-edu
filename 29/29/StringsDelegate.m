//
//  StringsDelegate.m
//  29
//
//  Created by 18495524 on 7/4/21.
//

#import <Foundation/Foundation.h>
#import "StringsDelegate.h"

@implementation StringsGenerator

- (NSMutableArray*)getStrings {
    NSMutableArray *ar = [NSMutableArray array];
    [ar addObject:@"alexander rudevich"]; // same with float values
    [ar addObject:@"alexaalex rudevi chacha"];
    [ar addObject:@"third string"];
    [ar addObject:@"bebebe"];
    [ar addObject:@"aaaaaa"];
    return ar;
}

- (void)showStrings:(NSArray*)array {
    for (id string in array) {
        NSLog(@"String: %@", string);
    }
}

@end
