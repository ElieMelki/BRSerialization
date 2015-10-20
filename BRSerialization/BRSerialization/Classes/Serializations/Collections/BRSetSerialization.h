//
//  BRNSSetSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRSetSerialization : NSObject<BRISerialization>

+ (instancetype)  setSerialization;

- (NSArray *) serialize:(NSSet *)theObject;
- (NSSet *) deserialize:(NSArray *)theData;

@end
