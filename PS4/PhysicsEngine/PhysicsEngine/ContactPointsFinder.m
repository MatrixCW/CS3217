//
//  ContactPointsFinder.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/13/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ContactPointsFinder.h"

@implementation ContactPointsFinder

-(id)initWithRectangleA:(PERectangle*)rectA andRectangleB:(PERectangle*)rectB{
    self.rectA = rectA;
    self.rectB = rectB;
    
    return self;
}

-(CGPoint)rectCenterInUpRightCoordinateSystem:(PERectangle*)rectA{
    return nil;
}
@end
