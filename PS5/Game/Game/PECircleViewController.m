//
//  PECircleViewController.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/28/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PECircleViewController.h"

typedef enum {whiteWind = 10,redWind = 11,blueWind = 12,greenWind = 13}windBlowType;

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

-(void)animate:(int) tag{
    
    
    
    
    UIImage* puffDisperseImages;
    
    
    CGImageRef imageRef;
    UIImage* singlePuffImage;
    CGRect cropRect;
    
    NSMutableArray * animationArray = [NSMutableArray array];
    
    
    
    switch (tag) {
        case whiteWind:
            puffDisperseImages = [UIImage imageNamed:@"wind-disperse.png"];
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 5; j++) {
                    cropRect = CGRectMake(0+j*253, 0+i*259, 253,259);
                    imageRef = CGImageCreateWithImageInRect([puffDisperseImages CGImage], cropRect);
                    singlePuffImage = [UIImage imageWithCGImage:imageRef];
                    CGImageRelease(imageRef);
                    [animationArray addObject:singlePuffImage];
                }
            }
            break;
            
        case redWind:
            puffDisperseImages = [UIImage imageNamed:@"wind-disperse1.png"];
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 4; j++) {
                    cropRect = CGRectMake(0+j*271.75, 0+i*273, 271.75,273);
                    imageRef = CGImageCreateWithImageInRect([puffDisperseImages CGImage], cropRect);
                    singlePuffImage = [UIImage imageWithCGImage:imageRef];
                    CGImageRelease(imageRef);
                    [animationArray addObject:singlePuffImage];
                }
            }
            break;
            
        case blueWind:
            puffDisperseImages = [UIImage imageNamed:@"wind-disperse2.png"];
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 3; j++) {
                    cropRect = CGRectMake(0+j*288.67, 0+i*385.5, 253,288.67);
                    imageRef = CGImageCreateWithImageInRect([puffDisperseImages CGImage], cropRect);
                    singlePuffImage = [UIImage imageWithCGImage:imageRef];
                    CGImageRelease(imageRef);
                    [animationArray addObject:singlePuffImage];
                }
            }
            break;
            
        case greenWind:
            puffDisperseImages = [UIImage imageNamed:@"wind-disperse3.png"];
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 4; j++) {
                    cropRect = CGRectMake(0+j*207, 0+i*207, 253,200);
                    imageRef = CGImageCreateWithImageInRect([puffDisperseImages CGImage], cropRect);
                    singlePuffImage = [UIImage imageWithCGImage:imageRef];
                    CGImageRelease(imageRef);
                    [animationArray addObject:singlePuffImage];
                }
            }
            break;
            
        default:
            break;
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
