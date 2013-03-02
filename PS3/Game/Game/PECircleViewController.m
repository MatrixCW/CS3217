//
//  PECircleViewController.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/28/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PECircleViewController.h"

@interface PECircleViewController ()

@end

@implementation PECircleViewController

-(id)initPECircleWithCenter:(CGPoint)center mass:(CGFloat)mass andImage:(UIImage*) image{
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(center.x, center.y, width, height);
    
    self.model = [[PERectangle alloc] initPECircleWithCenter:center
                                                       Width:width
                                                      Height:height
                                                     andMass:mass];
    self.model.myDelegate = self;
    
    self.view = imageView;
        
    return self;
}



-(void)UpdatePosition{
    
    self.view.center = self.model.center;
    [self.view setTransform: CGAffineTransformMakeRotation(-self.model.rotation)];
    
}

@end
