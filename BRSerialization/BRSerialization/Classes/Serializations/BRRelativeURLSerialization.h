//
//  BRRelativeURLSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRRelativeURLSerialization : NSObject<BRISerialization>

+ (instancetype) relativeSerializationWithBaseURL:(NSURL *)theBaseURL;

- (id) initWithBaseURL:(NSURL *)theBaseURL;

- (NSString *) serialize:(NSURL *)theObject;
- (NSURL *) deserialize:(NSString *)theData;

@end
