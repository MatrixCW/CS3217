//
//  MyWorld.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"
#import "UpdatePositionInViewDelegate.h"
#import "ConstantLibrary.h"
#import "PERectangle.h"

@interface MyWorld : NSObject<UIAccelerometerDelegate>

@property Vector2D* gravity;


@property (weak) id<UpdatePositionInViewDelegate> updateViewDelegate;

@property NSMutableArray* objectsInWorld;
@property NSTimer* timer;

- (void)run;

@end
