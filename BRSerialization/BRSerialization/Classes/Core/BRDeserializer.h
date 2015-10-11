//
//  BRDeserializer.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * BRSerialiser protocol
 * used to deserialise a plist data types back to object
 */

@protocol BRDeserializer <NSObject>

/*
 * @params: data types supported by plists.
 * @return: return a complex object
 */
- (id) deserialize:(id)theData;

@end
