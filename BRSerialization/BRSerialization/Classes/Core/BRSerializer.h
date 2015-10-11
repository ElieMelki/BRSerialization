//
//  BRSerialiser.h
//  BRJsonParser
//
//  Created by ELie Melki on 10/4/15.
//  Copyright © 2015 @Me. All rights reserved.
//

#import <Foundation/Foundation.h>

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
