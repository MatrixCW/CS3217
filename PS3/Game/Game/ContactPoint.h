//
//  ContactPoint.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/16/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"
#import "PERectangle.h"

@interface ContactPoint : NSObject
// OVERVIEW: This class implements an contact point to
// store all the necessay infomation about the colliding point

@property PERectangle* rectA;
@property PERectangle* rectB;

@property CGFloat separation;

@property Vector2D* c;
@property Vector2D* n;
@property Vector2D* t;  


 

-(id)initWithRectA:(PERectangle*)rectA RectB:(PERectangle*)rectB Normal:(Vector2D*)n Separation:(CGFloat)s Position:(Vector2D*)c;



@end
