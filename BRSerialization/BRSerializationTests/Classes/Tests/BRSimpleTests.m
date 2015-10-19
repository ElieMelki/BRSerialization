//
//  BRSerializationTests.m
//  BRSerializationTests
//
//  Created by ELie Melki on 10/11/15.
//  Copyright © 2015 Elie Melki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BRSerialization/BRSerialization.h>
#import "Customer.h"

@interface BRSimpleTests : XCTestCase

@end

@implementation BRSimpleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDeserialization {
    
    Customer *c = [self deserializeSample];
    XCTAssertTrue([c.identifier isEqualToString:@"1234"]);
    XCTAssertTrue([c.name isEqualToString:@"name"]);
    XCTAssertTrue([[c.websiteURL absoluteString] isEqualToString:@"http://www.google.com"]);
    XCTAssertTrue([[c.contactURL absoluteString] isEqualToString:@"http://www.google.com/ContactUs"]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        for (int i = 0; i < 10; i++)
            [self deserializeSample];
    }];
}

- (Customer *) deserializeSample
{
    
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"customer" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    Customer *customer = [NSJSONSerialization JSONObjectWithData:data deserializer:[Customer serialization] options:0 error:nil];
    return customer;

}

@end
