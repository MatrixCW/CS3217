//
//  GameWolf.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameWolf.h"

@interface GameWolf ()

@end

@implementation GameWolf

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GameWolf*)initWithBackground:(UIScrollView*) downArea:(UIView*)upArea{
    
    
    
    self.originalHeight = 90;
    self.originalWidth = 150;
    self.currentHeight = 150;
    self.currentWidth = 225;
    self.center =CGPointMake(80, 60);
    self.gamearea = downArea;
    self.selectBar = upArea;
    
    UIImage* wolfsImage = [UIImage imageNamed:@"wolfs.png"];
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([wolfsImage CGImage], CGRectMake(0,0,225,150));
    
    UIImage* singleWolfImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    UIImageView* wolf = [[UIImageView alloc] initWithImage:singleWolfImage];
    
    [wolf sizeToFit];
    
    wolf.frame = CGRectMake(self.center.x-self.originalWidth/2,
                            self.center.y-self.originalHeight/2,
                            self.originalWidth,
                            self.originalHeight);
    
    self.selfImgView = wolf;
    self.selfImgView.userInteractionEnabled = YES;
    
    self.view.tag = kGameObjectWolf;
    
    [self setRecognizer];
    
    
    
    
    return  self;
    
}


-(void) moveToTarget:(CGPoint)center withTransform:(CGAffineTransform)transform{
    
    [self.view setBounds:CGRectMake(0, 0, self.currentWidth, self.currentHeight)];
    self.view.center = center;
    self.view.transform = transform;
    

    [self.gamearea addSubview:self.view];
        
    

    
}



@end
