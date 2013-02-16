//
//  CollisionDetector.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/14/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"
#import "Matrix2D.h"
#import "PERectangle.h"
#import "ConstantLibrary.h"
#import "ContactPoint.h"

@interface CollisionDetector : NSObject

@property PERectangle* rectA;
@property PERectangle* rectB;

@property NSMutableArray* contactPoints;

-(id)initCoiisionDetector;
-(void)detectCollisionBetweenRectA:(PERectangle*) rectA andRectB:(PERectangle*) rectB;
-(void)applyImpulse;

@end
