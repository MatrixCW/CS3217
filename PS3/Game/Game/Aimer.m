//
//  Aimer.m
//  Game
//
//  Created by Cui Wei on 3/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "Aimer.h"

@interface Aimer ()

@end

@implementation Aimer

-(id)initWithPosition:(CGPoint)center{
    
    
    
    UIImage* directionArrow = [UIImage imageNamed:@"direction-arrow.png"];
    UIImageView* directionArrowView = [[UIImageView alloc]initWithImage:directionArrow];
    
    directionArrowView.frame =  CGRectMake(center.x+25,
                                           177,
                                           directionArrow.size.width ,
                                           directionArrow.size.height);
    
    
    
    
    self.view = directionArrowView;
    
    [self addRecognizer:self.view];
    return self;
    
}

-(Vector2D*)direction{
    return [Vector2D vectorWith:self.view.transform.b y:self.view.transform.a];
}

-(void)addRecognizer:(UIView*)view{
    
    
        
    UIPanGestureRecognizer *rotate = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(rotate:)];
    [view addGestureRecognizer:rotate];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(changeState)];
    [view addGestureRecognizer:tap];
    
    view.userInteractionEnabled = YES;
    
       
}

- (void)rotate:(UIPanGestureRecognizer *)gesture{
    // MODIFIES: object model (rotation)
    // REQUIRES: game in designer mode, object in game area
    // EFFECTS: the object is rotated with a two-finger rotation gesture
    
    BOOL userWantToIncreaseAngle = NO;
    BOOL userWantToDecreaseAngle = NO;
    
    CGFloat blowAngle = atan2(gesture.view.transform.b, gesture.view.transform.a);
    
    CGFloat delta = 0 ;
    
    CGPoint newPosition = [gesture translationInView:gesture.view.superview];
    
    
    if (newPosition.y > 0 ) {
        userWantToIncreaseAngle = YES;
    }
    if (newPosition.y < 0 ){
        userWantToDecreaseAngle = YES;
    }
    
    if (userWantToIncreaseAngle && blowAngle < M_PI) {
        
        if((blowAngle + 0.02) < M_PI)
            delta = 0.02;
        
    } 
    
    if (userWantToDecreaseAngle && blowAngle > 0) {
        if((blowAngle - 0.02) > 0)
            delta = -0.02;
        }
    

    
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform,delta);
    
    
   [gesture setTranslation:CGPointZero inView:gesture.view.superview];
    
    
    
    
}

-(void)changeState{
    
   
    if(!self.view.subviews.count){
        
        UIImage* directionArrowSelected = [UIImage imageNamed:@"direction-arorw-selected.png"];
        UIImageView* directionArrowSelectedView = [[UIImageView alloc]initWithImage:directionArrowSelected];
        
        directionArrowSelectedView.frame =  CGRectMake(0,
                                               0,
                                               self.view.bounds.size.width,
                                               self.view.bounds.size.height);
        
        
        
        
        [self.view addSubview:directionArrowSelectedView];
        
        
        
    }
    else{
                [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
}


@end
