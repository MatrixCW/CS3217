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

-(void)decrementRemainingHit{
    
}

-(void)animate{
    
    
    
    
    UIImage* puffDisperseImages = [UIImage imageNamed:@"wind-disperse.png"];
    CGImageRef imageRef;
    UIImage* singlePuffImage;
    CGRect cropRect;
    
    NSMutableArray * animationArray = [NSMutableArray array];
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 5; j++) {
            cropRect = CGRectMake(0+j*253, 0+i*259, 253,259);
            imageRef = CGImageCreateWithImageInRect([puffDisperseImages CGImage], cropRect);
            singlePuffImage = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            [animationArray addObject:singlePuffImage];
        }
    }
    
    
    UIImageView *animationView=[[UIImageView alloc]initWithFrame:self.view.frame];
    
    
    animationView.animationImages=animationArray;
    animationView.animationDuration=1;
    animationView.animationRepeatCount=1;
    [animationView startAnimating];
    [self.myDelegate addDirectlyToGameArea:animationView];
    

    
    
}



-(void)UpdatePosition{
    
    self.view.center = self.model.center;
    [self.view setTransform: CGAffineTransformMakeRotation(-self.model.rotation)];
    
}

@end
