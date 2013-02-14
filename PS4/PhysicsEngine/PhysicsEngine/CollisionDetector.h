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

@interface CollisionDetector : NSObject

@property (weak) PERectangle* rectA;
@property (weak) PERectangle* rectB;



@end
