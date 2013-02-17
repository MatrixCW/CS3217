//
//  PERectangleTest.m
//  PERectangleTest
//
//  Created by Cui Wei on 2/17/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PERectangleTest.h"
#import "PERectangle.h"
#import "ConstantLibrary.h"

@implementation PERectangleTest{
    
    PERectangle* A;
    PERectangle* B;
    PERectangle* C;
    PERectangle* D;
    PERectangle* E;
    PERectangle* F;
    
    
    PERectangle* left;
    PERectangle* right;
    PERectangle* upper;
    PERectangle* lower;
    
}

- (void)setUp
{
    [super setUp];
    
    A = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(90, 710)
                                                 Width:100
                                                Height:200
                                               andMass:100*200*defaultDensity];
    
    B = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(56, 89)
                                                 Width:300
                                                Height:400
                                               andMass:300*400*defaultDensity];
    
    C = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(425, 552)
                                                 Width:500
                                                Height:600
                                               andMass:500*600*defaultDensity];
    
    D = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(834, 667)
                                                 Width:700
                                                Height:800
                                               andMass:700*800*defaultDensity];
    
    E = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(531, 1124)
                                                 Width:900
                                                Height:1000
                                               andMass:900*1000*defaultDensity];
    
    F = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(66, 752)
                                                 Width:1000
                                                Height:1200
                                               andMass:1100*1200*defaultDensity];
    
    left  = [PERectangle getLeftVerticalBoundRectangle];
    right = [PERectangle getRightVerticalBoundRectangle];
    upper = [PERectangle getUpperHorizontalBoundRectangle];
    lower = [PERectangle getLowerHorizontalBoundRectangle];
    
}


- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testInit{
    
    STAssertTrue(A.rotation == 0,nil);
    STAssertTrue(A.velocity.x == 0,nil);
    STAssertTrue(A.velocity.y == 0,nil);
    STAssertTrue(A.angularVelocity == 0,nil);
    STAssertTrue(A.identity == 1,nil);
    
    STAssertTrue(B.rotation == 0,nil);
    STAssertTrue(B.velocity.x == 0,nil);
    STAssertTrue(B.velocity.y == 0,nil);
    STAssertTrue(B.angularVelocity == 0,nil);
    STAssertTrue(B.identity == 1,nil);
    
    STAssertTrue(C.rotation == 0,nil);
    STAssertTrue(C.velocity.x == 0,nil);
    STAssertTrue(C.velocity.y == 0,nil);
    STAssertTrue(C.angularVelocity == 0,nil);
    STAssertTrue(C.identity == 1,nil);
    
    STAssertTrue(D.rotation == 0,nil);
    STAssertTrue(D.velocity.x == 0,nil);
    STAssertTrue(D.velocity.y == 0,nil);
    STAssertTrue(D.angularVelocity == 0,nil);
    STAssertTrue(D.identity == 1,nil);
    
    STAssertTrue(E.rotation == 0,nil);
    STAssertTrue(E.velocity.x == 0,nil);
    STAssertTrue(E.velocity.y == 0,nil);
    STAssertTrue(E.angularVelocity == 0,nil);
    STAssertTrue(E.identity == 1,nil);
    
    STAssertTrue(F.rotation == 0,nil);
    STAssertTrue(F.velocity.x == 0,nil);
    STAssertTrue(F.velocity.y == 0,nil);
    STAssertTrue(F.angularVelocity == 0,nil);
    STAssertTrue(F.identity == 1,nil);
    
    
    STAssertTrue(left.rotation == 0,nil);
    STAssertTrue(left.velocity.x == 0,nil);
    STAssertTrue(left.velocity.y == 0,nil);
    STAssertTrue(left.angularVelocity == 0,nil);
    STAssertTrue(left.identity == 0,nil);
    
    
    STAssertTrue(right.rotation == 0,nil);
    STAssertTrue(right.velocity.x == 0,nil);
    STAssertTrue(right.velocity.y == 0,nil);
    STAssertTrue(right.angularVelocity == 0,nil);
    STAssertTrue(right.identity == 0,nil);

    
    STAssertTrue(upper.rotation == 0,nil);
    STAssertTrue(upper.velocity.x == 0,nil);
    STAssertTrue(upper.velocity.y == 0,nil);
    STAssertTrue(upper.angularVelocity == 0,nil);
    STAssertTrue(upper.identity == 0,nil);

    
    STAssertTrue(lower.rotation == 0,nil);
    STAssertTrue(lower.velocity.x == 0,nil);
    STAssertTrue(lower.velocity.y == 0,nil);
    STAssertTrue(lower.angularVelocity == 0,nil);
    STAssertTrue(lower.identity == 0,nil);

    
    
}

-(void)testPositive{
    
    STAssertTrue(lower.width > 0,nil);
    STAssertTrue(lower.height > 0,nil);
    
    STAssertTrue(upper.width > 0,nil);
    STAssertTrue(upper.height > 0,nil);
    
    STAssertTrue(left.width > 0,nil);
    STAssertTrue(left.height > 0,nil);
    
    STAssertTrue(right.width > 0,nil);
    STAssertTrue(right.height > 0,nil);
    
    STAssertTrue(A.width > 0,nil);
    STAssertTrue(A.height > 0,nil);
    
    STAssertTrue(B.width > 0,nil);
    STAssertTrue(B.height > 0,nil);
    
    STAssertTrue(C.width > 0,nil);
    STAssertTrue(C.height > 0,nil);
    
    STAssertTrue(D.width > 0,nil);
    STAssertTrue(D.height > 0,nil);
    
    STAssertTrue(E.width > 0,nil);
    STAssertTrue(E.height > 0,nil);
    
    STAssertTrue(F.width > 0,nil);
    STAssertTrue(F.height > 0,nil);

}



- (void)testPosition{
    
    STAssertTrue(A.center.x == 90, nil);
    STAssertTrue(A.center.y == 710, nil);
    
    STAssertTrue(B.center.x == 56, nil);
    STAssertTrue(B.center.y == 89, nil);
    
    STAssertTrue(C.center.x == 425, nil);
    STAssertTrue(C.center.y == 552, nil);
    
    STAssertTrue(D.center.x == 834, nil);
    STAssertTrue(D.center.y == 667, nil);
    
    STAssertTrue(E.center.x == 531, nil);
    STAssertTrue(E.center.y == 1124, nil);
    
    STAssertTrue(F.center.x == 66, nil);
    STAssertTrue(F.center.y == 752, nil);
    
    STAssertTrue(left.center.x + 150 == 0.0, nil);
    STAssertTrue(left.center.y - 512 == 0.0, nil);
    
    
    STAssertTrue(right.center.x - 150 == 768, @"%lf",right.center.x - 150);
    STAssertTrue(right.center.y - 512 == 0.0, @"%lf",right.center.y - 512);
    
    STAssertTrue(upper.center.x - 384 == 0.0, @"%lf",upper.center.x - 384);
    STAssertTrue(upper.center.y + 150 == 0.0, @"%lf",upper.center.y + 150);
    
    STAssertTrue(lower.center.x - 384 == 0.0, @"%lf",lower.center.x - 384);
    STAssertTrue(lower.center.y - 150 == 1004,@"%lf",lower.center.y - 150);
    
}

- (void)testMass{
        
    STAssertTrue(A.mass == 100*200*defaultDensity,nil);
    STAssertTrue(B.mass == 300*400*defaultDensity,nil);
    STAssertTrue(C.mass == 500*600*defaultDensity,nil);
    STAssertTrue(D.mass == 700*800*defaultDensity,nil);
    STAssertTrue(E.mass == 900*1000*defaultDensity,nil);
    STAssertTrue(F.mass == 1100*1200*defaultDensity,nil);

}

-(void)testMomentOfInertia{
    
    STAssertTrue(left.momentOfInetia == INFINITY,nil);
    STAssertTrue(right.momentOfInetia == INFINITY,nil);
    STAssertTrue(lower.momentOfInetia == INFINITY,nil);
    STAssertTrue(right.momentOfInetia == INFINITY,nil);

}


-(void)testCenterMethod{
    
    STAssertEquals(A.center.x, [A centerOfRectangle].x, nil);
    STAssertEquals(A.center.y, -[A centerOfRectangle].y, nil);
    
    STAssertEquals(B.center.x, [B centerOfRectangle].x, nil);
    STAssertEquals(B.center.y, -[B centerOfRectangle].y, nil);
    
    STAssertEquals(C.center.x, [C centerOfRectangle].x, nil);
    STAssertEquals(C.center.y, -[C centerOfRectangle].y, nil);
    
    STAssertEquals(D.center.x, [D centerOfRectangle].x, nil);
    STAssertEquals(D.center.y, -[D centerOfRectangle].y, nil);
    
    STAssertEquals(E.center.x, [E centerOfRectangle].x, nil);
    STAssertEquals(E.center.y, -[E centerOfRectangle].y, nil);
    
    STAssertEquals(F.center.x, [F centerOfRectangle].x, nil);
    STAssertEquals(F.center.y, -[F centerOfRectangle].y, nil);
    
    STAssertEquals(left.center.x, [left centerOfRectangle].x, nil);
    STAssertEquals(left.center.y, -[left centerOfRectangle].y, nil);
    
    STAssertEquals(right.center.x, [right centerOfRectangle].x, nil);
    STAssertEquals(right.center.y, -[right centerOfRectangle].y, nil);
    
    STAssertEquals(upper.center.x, [upper centerOfRectangle].x, nil);
    STAssertEquals(upper.center.y, -[upper centerOfRectangle].y, nil);
    
    STAssertEquals(lower.center.x, [lower centerOfRectangle].x, nil);
    STAssertEquals(lower.center.y, -[lower centerOfRectangle].y, nil);
    
    
}

-(void)testhVector{
    
    STAssertEquals([A hVector].x, A.width/2, nil);
    STAssertEquals([A hVector].y, A.height/2, nil);
    
    STAssertEquals([B hVector].x, B.width/2, nil);
    STAssertEquals([B hVector].y, B.height/2, nil);
    
    STAssertEquals([C hVector].x, C.width/2, nil);
    STAssertEquals([C hVector].y, C.height/2, nil);
    
    STAssertEquals([D hVector].x, D.width/2, nil);
    STAssertEquals([D hVector].y, D.height/2, nil);
    
    STAssertEquals([E hVector].x, E.width/2, nil);
    STAssertEquals([E hVector].y, E.height/2, nil);
    
    STAssertEquals([F hVector].x, F.width/2, nil);
    STAssertEquals([F hVector].y, F.height/2, nil);
    
    STAssertEquals([left hVector].x, left.width/2, nil);
    STAssertEquals([left hVector].y, left.height/2, nil);
    
    STAssertEquals([right hVector].x, right.width/2, nil);
    STAssertEquals([right hVector].y, right.height/2, nil);
    
    STAssertEquals([lower hVector].x, lower.width/2, nil);
    STAssertEquals([lower hVector].y, lower.height/2, nil);
    
    STAssertEquals([upper hVector].x, upper.width/2, nil);
    STAssertEquals([upper hVector].y, upper.height/2, nil);
    
    
}





@end
