//
//  BRTypedDictionarySerialization.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRSerializer.h"
#import "BRDeserializer.h"


//Execpt a key for type NSString

@interface BRTypedDictionarySerialization : NSObject<BRSerializer,BRDeserializer>

+ (instancetype) typedDictionarySerializationWith:(id<BRSerializer,BRDeserializer>)serialization;

- (id) initWithSerialization:(id<BRSerializer,BRDeserializer>)serialization;


- (NSDictionary *) deserialize:(NSDictionary *)theData;
- (NSDictionary *) serialize:(NSDictionary *)theObject;
@end
