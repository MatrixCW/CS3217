//
//  PERectangleViewController.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/13/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PERectangle.h"
#import "UpdatePositionInViewDelegate.h"

@interface PERectangleViewController : UIViewController<UpdatePositionInViewDelegate>

@property PERectangle* model;
// OVERVIEW: This class is a child view controller of the main view controller
// it is responsible for updating position of all the objects in the main view

-(id)initPERectangleWithCenter:(CGPoint)center Width:(CGFloat)width Height:(CGFloat)height mass:(CGFloat)mass andColor:(UIColor*) color;

+(id)getUpperHorizontalBoundRectangle;
+(id)getLowerHorizontalBoundRectangle;
+(id)getLeftVerticalBoundRectangle;
+(id)getRightVerticalBoundRectangle;

@end
