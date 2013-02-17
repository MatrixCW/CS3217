//
//  detectorTest.m
//  detectorTest
//
//  Created by Cui Wei on 2/17/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "detectorTest.h"
#import "CollisionDetector.h"

@implementation detectorTest{
    CollisionDetector* myDetector;
    PERectangle* A;
    PERectangle* B;
}

- (void)setUp
{
    [super setUp];
    myDetector = [[CollisionDetector alloc] initCoiisionDetector];
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(90, 710)
                                                 Width:100
                                                Height:200
                                               andMass:100*200*defaultDensity];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(56, 89)
                                                 Width:300
                                                Height:400
                                               andMass:300*400*defaultDensity];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testDetector{
    
    [myDetector detectCollisionBetweenRectA:A andRectB:B];
    STAssertTrue(myDetector.contactPoints.count == 0, nil);
    
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(90, 710)
                                                 Width:100
                                                Height:200
                                               andMass:408];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(90, 708)
                                                 Width:300
                                                Height:400
                                               andMass:700];
    [myDetector detectCollisionBetweenRectA:A andRectB:B];
    STAssertTrue(myDetector.contactPoints.count == 2, nil);
    [myDetector.contactPoints removeAllObjects];
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(90, 710)
                                                 Width:100
                                                Height:200
                                               andMass:800];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(856, 15)
                                                 Width:430
                                                Height:128
                                               andMass:100];
    [myDetector detectCollisionBetweenRectA:A andRectB:B];
    STAssertTrue(myDetector.contactPoints.count == 0, @"%d", myDetector.contactPoints.count);
    [myDetector.contactPoints removeAllObjects];
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(786, 400)
                                                 Width:100
                                                Height:200
                                               andMass:100*200*defaultDensity];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(53, 502)
                                                 Width:300
                                                Height:400
                                               andMass:786];
    [myDetector detectCollisionBetweenRectA:A andRectB:B];
    STAssertTrue(myDetector.contactPoints.count == 0, @"%d", myDetector.contactPoints.count);
    [myDetector.contactPoints removeAllObjects];
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(66, 77)
                                                 Width:100
                                                Height:200
                                               andMass:543];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(98, 40)
                                                 Width:300
                                                Height:400
                                               andMass:753];
    [myDetector detectCollisionBetweenRectA:A andRectB:B];
    STAssertTrue(myDetector.contactPoints.count == 2, @"%d", myDetector.contactPoints.count);
    [myDetector.contactPoints removeAllObjects];
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(53, 783)
                                                 Width:100
                                                Height:200
                                               andMass:453];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(678, 786)
                                                 Width:300
                                                Height:400
                                               andMass:867];
    [myDetector detectCollisionBetweenRectA:A andRectB:B];
    STAssertTrue(myDetector.contactPoints.count == 0, @"%d", myDetector.contactPoints.count);
    [myDetector.contactPoints removeAllObjects];

}




@end
