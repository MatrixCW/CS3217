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

-(id)initPERectangleOrigin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height mass:(CGFloat)mass andColor:(UIColor*) color{
    
    self.model = [[PERectangle alloc] initPERectangleOrigin:origin Width:width Height:height andMass:mass];
    self.model.myDelegate = self;
    self.view.frame = CGRectMake(origin.x, origin.y, width, height);
    [self.view setBackgroundColor:color];
    
    return self;
    
}

+(id)getUpperHorizontalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getUpperHorizontalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.origin.x, temp.model.origin.y, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
}

+(id)getLowerHorizontalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getLowerHorizontalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.origin.x, temp.model.origin.y, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
    
}

+(id)getLeftVerticalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getLeftVerticalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.origin.x, temp.model.origin.y, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
    
}
+(id)getRightVerticalBoundRectangle{
    
    PERectangleViewController* temp = [PERectangleViewController alloc];
    temp.model = [PERectangle getRightVerticalBoundRectangle];
    temp.view.frame = CGRectMake(temp.model.origin.x, temp.model.origin.y, temp.model.width, temp.model.height);
    [temp.view setBackgroundColor:[UIColor redColor]];
    
    return temp;
    
}


-(void)UpdatePosition{
    
    
    self.view.center = CGPointMake(self.model.origin.x+self.model.width/2, self.model.origin.y+self.model.height/2);
}

@end
