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

@interface GameObject()

@property (readwrite) CGFloat widthInPalette;
@property (readwrite) CGFloat heightInPalette;
@property (readwrite) CGPoint centerInPalette;

@end

@implementation GameObject



-(id)init{
    
    UIImage *pigImage = [UIImage imageNamed:@"pig.png"];
    UIImageView *pigView = [[UIImageView alloc] initWithImage:pigImage];
    
    self.widthInPalette = 2*pigImage.size.width;
    self.heightInPalette = 2*pigImage.size.height;
    self.centerInPalette = CGPointMake(25,25); 
    
    pigView.frame = CGRectMake(self.centerInPalette.x - self.widthInPalette/2,
                               self.centerInPalette.y - self.heightInPalette/2,
                               self.widthInPalette,
                               self.heightInPalette);
    self.view = pigView;
    self.model = [[PERectangle alloc] initPERectangleWithCenter:self.view.center
                                                         Width:self.widthInPalette
                                                        Height:self.heightInPalette
                                                        andMass:100];
    
    NSLog(@"%lf, %lf, %lf, %lf",self.centerInPalette.x,self.centerInPalette.y,self.widthInPalette,self.heightInPalette);
    return self;
}

- (void)translate:(UIPanGestureRecognizer*)gesture{
    
    // MODIFIES: object model (coordinates)
    // REQUIRES: game in designer mode
    // EFFECTS: the user drags around the object with one finger
    //          if the object is in the palette, it will be moved in the game area
    
  
    [self.myDelegate disableGamearea];
    
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                        gesture.view.center.y + translation.y);
    
    NSLog(@"%lf", gesture.view.center.y - gesture.view.frame.size.height/2);
    [gesture setTranslation:CGPointZero inView:gesture.view.superview];
    
    
    if (gesture.state == UIGestureRecognizerStateChanged &&
       [self.myDelegate shouldAddToGameArea:gesture.view]) {
        
            
            
           [self.myDelegate addToGameArea:gesture.view];
        
    }
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [self.myDelegate enableGamearea];
        
        if ([self.myDelegate notMovedOutOfPalette:gesture.view]) {
            
            [self.myDelegate addToPalette:gesture.view];
                        
        }
        
    }
    
    
}


- (void)rotate:(UIRotationGestureRecognizer *)gesture{
    // MODIFIES: object model (rotation)
    // REQUIRES: game in designer mode, object in game area
    // EFFECTS: the object is rotated with a two-finger rotation gesture
    
    
    [self.myDelegate disableGamearea];
    
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation);
    gesture.rotation = 0;
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.myDelegate enableGamearea];
    }
    
}

- (void)zoom:(UIPinchGestureRecognizer *)gesture{
    // MODIFIES: object model (size)
    // REQUIRES: game in designer mode, object in game area
    // EFFECTS: the object is scaled up/down with a pinch gesture
    
    // You will need to define more methods to complete the specification.
    
    
    [self.myDelegate disableGamearea];
    
    CGFloat pictureScaleA = gesture.view.transform.a;
    CGFloat pictureScaleB = gesture.view.transform.b;
    CGFloat pictureScaleC = gesture.view.transform.c;
    CGFloat pictureScaleD = gesture.view.transform.d;
    
    CGFloat xScale = sqrt(pictureScaleA*pictureScaleA+pictureScaleC*pictureScaleC);
    CGFloat yScale = sqrt(pictureScaleB*pictureScaleB+pictureScaleD*pictureScaleD);
    
    
    
    if(xScale>=2 || yScale >=2){
        gesture.view.transform = CGAffineTransformScale(gesture.view.transform, 0.99, 0.99);
    }
    else if(xScale<=1 || yScale <=1){
        gesture.view.transform = CGAffineTransformScale(gesture.view.transform, 1.01, 1.01);
    }
    else{
        gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
    
    }
    
    gesture.scale = 1;
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self.myDelegate enableGamearea];;
    }
    
}



- (void)doubleTap:(UITapGestureRecognizer*) recognizer{
    
    
   [self restore];
    
}

-(void) restore{
    
    NSLog(@"FANGPI");
    NSLog(@"%lf, %lf, %lf, %lf",self.centerInPalette.x,self.centerInPalette.y,self.widthInPalette,self.heightInPalette);
    self.view.transform = CGAffineTransformIdentity;
    self.view.frame = CGRectMake(self.centerInPalette.x - self.widthInPalette/2,
                                 self.centerInPalette.y - self.heightInPalette/2,
                                 self.widthInPalette,
                                 self.heightInPalette);
    [self.myDelegate addToPalette:self.view];
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (id)initWithBackground:(UIScrollView*) downArea:(UIView*)upArea{
    return Nil;
}



@end
