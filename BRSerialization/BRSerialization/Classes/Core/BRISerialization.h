//
//  BRISerialization.h
//  BRSerialization
//
//  Created by ELie Melki on 10/19/15.
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


/*
 * BRSerialiser protocol
 * Serialise an object to data types supported by plists.
 * e.g: NSDictionary, NSArray,NSString,  NSNumber, int, double etc...
 */
@protocol BRSerializer <NSObject>

/*
 * @params: Any complex Object
 * @return: return data types supported by plists.
 */
- (id) serialize:(id)theObject;

@end

@protocol BRISerialization <BRDeserializer,BRSerializer>


@end
