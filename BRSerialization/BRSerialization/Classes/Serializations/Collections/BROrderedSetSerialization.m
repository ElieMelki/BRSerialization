//
//  BROrderedSetSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BROrderedSetSerialization.h"

@implementation BROrderedSetSerialization

+ (instancetype)  orderedSetSerialization
{
    return [[self alloc] init];
}

#pragma mark - BRSerializer implementation

- (NSArray *) serialize:(NSOrderedSet *)theObject
{
    if ([theObject isKindOfClass:[NSOrderedSet class]])
    {
        NSOrderedSet *set = (NSOrderedSet *)theObject;
        return [set array];
    }
    else
        return nil;
    
    
}

#pragma mark - BRDeserializer implementation

- (NSOrderedSet *) deserialize:(NSArray *)theData
{
    if ([theData isKindOfClass:[NSArray class]])
        return [NSOrderedSet orderedSetWithArray:theData];
    else  if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSArray for %@ found %@", theData, [theData class]]
                                     userInfo:nil];
    return nil;
}


@end
