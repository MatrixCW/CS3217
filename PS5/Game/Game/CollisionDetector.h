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
// OVERVIEW: This class implements an collision detecter
// that can determine if two moving objects are colliding or not
// and it they do collide, find the colliding points
// it will keep track of all the colliding points and then laster
// apply impulse to the cossiding bodies

@property PERectangle* rectA;
@property PERectangle* rectB;

@property NSMutableArray* contactPoints;

@property NSMutableArray* hittedObjects;

@property BOOL puffCollisionDetected;


-(id)initCoiisionDetector;
-(void)detectCollisionBetweenRectA:(PERectangle*) rectA andRectB:(PERectangle*) rectB;
-(void)applyImpulse;

@end
