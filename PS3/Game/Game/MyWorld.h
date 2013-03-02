//
//  MyWorld.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"
#import "ConstantLibrary.h"
#import "PERectangle.h"
#import "CollisionDetector.h"

@interface MyWorld : NSObject
// OVERVIEW: This class implements an simulated world
// where all the object models are added and the interaction simulated

@property NSMutableArray* objectsInWorld;
@property NSTimer* timer;
@property Vector2D* gravity;
@property CollisionDetector* conllisionDetector;

- (void)run;
- (void)stopTimer;

@end
