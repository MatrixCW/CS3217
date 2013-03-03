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
#import "GestureHandlerProtocol.h"

@interface PECircleViewController : UIViewController<UpdatePositionInViewDelegate>

@property PERectangle* model;
@property (weak) id<GestureHandlerProtocol> myDelegate;

-(id)initPECircleWithCenter:(CGPoint)center mass:(CGFloat)mass andImage:(UIImage*) image;

-(void)animate:(int) tag;



@end
