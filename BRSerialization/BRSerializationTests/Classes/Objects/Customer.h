//
//  Customer.h
//  BRSerialization
//
//  Created by ELie Melki on 10/19/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BRSerialization/BRSerialization.h>

@interface Customer : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *websiteURL;
@property (nonatomic, strong) NSURL *contactURL;

+ (id<BRISerialization>) serialization;

@end
