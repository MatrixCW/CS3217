//
//  PECircleViewController.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/28/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PERectangle.h"
#import "UpdatePositionInViewDelegate.h"

@interface PECircleViewController : UIViewController<UpdatePositionInViewDelegate>

@property PERectangle* model;


-(id)initPECircleWithCenter:(CGPoint)center mass:(CGFloat)mass andImage:(UIImage*) image;


@end
