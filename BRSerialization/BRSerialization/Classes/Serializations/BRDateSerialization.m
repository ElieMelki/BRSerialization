//
//  BRDateSerialization.m
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import "BRDateSerialization.h"
@interface BRDateSerialization()

@property (nonatomic,readonly) NSDateFormatter *dateFormatter;
@end

@implementation BRDateSerialization

+ (instancetype) dateSerializationWith:(NSString *)theDateFormat
{
    return [[self alloc] initWithDateFormat:theDateFormat] ;
}

@synthesize dateFormat;

 - (id) initWithDateFormat:(NSString *)theDateFormat
{
    self = [super init];
    if (self)
    {
        dateFormat = theDateFormat;
    }
    return self;
}



//------------------------------------
//Private Methods
//------------------------------------
#pragma mark - Private Methods


- (NSDateFormatter *) dateFormatter
{
    NSDateFormatter *_fm = [[NSDateFormatter alloc] init];
    _fm.dateFormat = self.dateFormat;
    return _fm;
}


#pragma mark - BRSerializer implementation

- (NSString *) serialize:(NSDate *)theObject
{
    if ([theObject isKindOfClass:[NSDate class]])
        return [self.dateFormatter stringFromDate:theObject];
    else
        return nil;

    
}

#pragma mark - BRDeserializer implementation

- (NSDate *) deserialize:(NSString *)theData
{
    if ([theData isKindOfClass:[NSString class]])
        return [self.dateFormatter dateFromString:theData];
    else if (theData != nil && ![theData isKindOfClass:[NSNull class]])
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Expected an NSString for %@ found %@", theData, [theData class]]
                                     userInfo:nil];
    return nil;
}



@end
