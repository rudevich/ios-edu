//
//  StringsDelegate.h
//  29
//
//  Created by 18495524 on 7/4/21.
//

#ifndef StringsDelegate_h
#define StringsDelegate_h


#endif /* StringsDelegate_h */

@protocol StringsDelegate <NSObject>
@optional
- (NSMutableArray*)getStrings;
- (void)showStrings:(NSArray*)array;
@end

@interface StringsGenerator : NSObject <StringsDelegate>
- (NSMutableArray*)getStrings;
- (void)showStrings:(NSArray*)array;
@end
