//
//  MyPEViewController.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Matrix2D.h"
#import "PERectangle.h"
#import "PERectangleViewController.h"
#import "MyWorld.h"


@interface MyPEViewController : UIViewController


@property MyWorld* simulatedWorld;

@property PERectangle* upperBound;
@property PERectangle* lowerBound;
@property PERectangle* leftBound;
@property PERectangle* rightBound;



@end
