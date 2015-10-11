//
//  BRNSSetSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRSetSerialization.h"

@implementation BRSetSerialization

+ (instancetype)  setSerialization
{
    return [[self alloc] init];
}

#pragma mark - BRSerializer implementation

- (NSArray *) serialize:(NSSet *)theObject
{
    if ([theObject isKindOfClass:[NSSet class]])
    {
        NSSet *set = (NSSet *)theObject;
        return [set allObjects];
    }
    else
        return nil;
    
    
}

#pragma mark - BRDeserializer implementation

- (NSSet *) deserialize:(NSArray *)theData
{
    if ([theData isKindOfClass:[NSArray class]])
        return [[NSSet alloc] initWithArray:theData];
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSArray for %@ found %@", theData, [theData class]]
                                     userInfo:nil];
    return nil;
}


@end
