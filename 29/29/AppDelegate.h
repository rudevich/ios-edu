//
//  AppDelegate.h
//  29
//
//  Created by 18495524 on 7/4/21.
//

#import <UIKit/UIKit.h>
#import "StringsDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
    @property (weak) id <StringsDelegate> delegate;
- (void)showArray:(NSArray*)array;
@end

