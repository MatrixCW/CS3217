//
//  PERectangleViewController.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/13/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PERectangleViewController.h"

@interface PERectangleViewController ()

@end

@implementation PERectangleViewController

-(id)initPERectangleWithCenter:(CGPoint)center Width:(CGFloat)width Height:(CGFloat)height mass:(CGFloat)mass andColor:(UIColor*) color{
    
    self.model = [[PERectangle alloc] initPERectangleWithCenter:center Width:width Height:height andMass:mass];
    self.model.myDelegate = self;
    self.view.frame = CGRectMake(center.x-width/2, center.y-height/2, width, height);
    [self.view setBackgroundColor:color];
    
    return self;
    
}

+(id)getUpperHorizontalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getUpperHorizontalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.center.x-temp.model.width/2, temp.model.center.y-temp.model.height/2, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
}

+(id)getLowerHorizontalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getLowerHorizontalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.center.x-temp.model.width/2, temp.model.center.y-temp.model.height/2, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
    
}

+(id)getLeftVerticalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getLeftVerticalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.center.x-temp.model.width/2, temp.model.center.y-temp.model.height/2, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
    
}
+(id)getRightVerticalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getRightVerticalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.center.x-temp.model.width/2, temp.model.center.y-temp.model.height/2, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
    
}


-(void)UpdatePosition{
    
    self.view.center = self.model.center;
    [self.view setTransform: CGAffineTransformMakeRotation(self.model.rotation)];

}

@end
