//
//  NSJSONSerialization+BRS.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/11/15.
//  Copyright © 2015 @Me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface NSJSONSerialization (BRS)

+ (NSData *) dataWithJSONObject:(id)obj
                             serializer:(id<BRSerializer>)serializer
                                options:(NSJSONWritingOptions)opt
                                  error:(__autoreleasing NSError **)error;

+ (id) JSONObjectWithData:(NSData *)data
                     deserializer:(id<BRDeserializer>)serializer
                          options:(NSJSONReadingOptions)opt
                            error:(NSError **)error;

@end
