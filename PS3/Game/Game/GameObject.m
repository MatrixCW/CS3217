//
//  GameObject.m
//  Game
//
//  Created by Cui Wei on 2/1/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameObject.h"

#define ZERO 0
#define SELECTBARHEIGHT 83


@implementation GameObject


-(void)loadView{
    self.view = self.selfImgView;
}


- (void)translate:(UIPanGestureRecognizer*)gesture{
    // MODIFIES: object model (coordinates)
    // REQUIRES: game in designer mode
    // EFFECTS: the user drags around the object with one finger
    //          if the object is in the palette, it will be moved in the game area
    
    self.gamearea.scrollEnabled = NO;
    
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    [gesture.view setBounds:CGRectMake(ZERO, ZERO, self.currentWidth, self.currentHeight)];
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                      gesture.view.center.y + translation.y);
    
    [gesture setTranslation:CGPointZero inView:gesture.view.superview];
    
    NSLog(@"herehere %lf %lf",self.view.center.x,self.view.center.y);
    
    if (gesture.state == UIGestureRecognizerStateChanged &&
        gesture.view.superview == self.selectBar &&
        gesture.view.center.y - self.view.frame.size.height/2 >= self.selectBar.frame.size.height) {
        
        //NSLog(@"herehere %lf",self.selectBar.frame.size.height);
        
        //NSLog(@"gamearea");

        
            gesture.view.center = CGPointMake(self.gamearea.contentOffset.x + gesture.view.center.x,
                                              gesture.view.center.y - self.selectBar.frame.size.height);
            
            [self.gamearea addSubview:gesture.view];
            
    }
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
         //NSLog(@"bar");
        
       // NSLog(@"here %lf",self.selectBar.frame.size.height);
        
        self.gamearea.scrollEnabled = YES;
        
        if (gesture.view.center.y <= self.selectBar.frame.size.height && gesture.view.superview == self.selectBar) {
            
            
            [gesture.view setBounds:CGRectMake(ZERO, ZERO, self.originalWidth, self.originalHeight)];
            gesture.view.center = CGPointMake(self.originalCenter.x , self.originalCenter.y);
            
        }
        
    }
    
    
}


- (void)rotate:(UIRotationGestureRecognizer *)gesture{
    // MODIFIES: object model (rotation)
    // REQUIRES: game in designer mode, object in game area
    // EFFECTS: the object is rotated with a two-finger rotation gesture
    
    _gamearea.scrollEnabled = NO;
    
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation);
    gesture.rotation = 0;
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        gamearea.scrollEnabled = YES;
    }
    
}

- (void)zoom:(UIPinchGestureRecognizer *)gesture{
    // MODIFIES: object model (size)
    // REQUIRES: game in designer mode, object in game area
    // EFFECTS: the object is scaled up/down with a pinch gesture
    
    // You will need to define more methods to complete the specification.
    
    _gamearea.scrollEnabled = NO;
    
    gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
    gesture.scale = 1;
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        gamearea.scrollEnabled = YES;
    }
    
}

- (void)setRecognizer{
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(translate:)];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    
    UIPinchGestureRecognizer* zoom = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoom:)];
    
    UIRotationGestureRecognizer* rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    
    [self.selfImgView addGestureRecognizer:pan];
    pan.delegate = self;
    [self.selfImgView addGestureRecognizer:doubleTap];
    [self.selfImgView addGestureRecognizer:zoom];
    zoom.delegate = self;
    [self.selfImgView addGestureRecognizer:rotate];
    rotate.delegate = self;
    [self.selfImgView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    
}

- (void)handleDoubleTap:(UITapGestureRecognizer*) recognizer{
    
    if (recognizer.view.superview != self.selectBar) {
        
        self.view.frame = CGRectMake(self.originalCenter.x-self.originalWidth/2, self.originalCenter.y-self.originalHeight/2,
                                     self.originalWidth, self.originalHeight);
        
        [self.view setBounds:CGRectMake(ZERO, ZERO, self.originalWidth, self.originalHeight)];
        
        [self.selectBar addSubview:recognizer.view];
    }
    
}

-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end