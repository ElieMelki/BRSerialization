//
//  BRSerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/11/15.
//  Copyright © 2015 @Me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRISerialization.h"

@interface BRSerializationFacade : NSObject

+ (id) serializeObject:(id)object
            serialiser:(id<BRSerializer>)serializer
                 error:(__autoreleasing NSError **)error;

+ (id) deserializeData:(id)data
          deserialiser:(id<BRDeserializer>)deserializer
             error:(__autoreleasing NSError **)error;



@end
