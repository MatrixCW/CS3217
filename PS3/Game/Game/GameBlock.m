//
//  GameStraw.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameBlock.h"

@interface GameBlock ()

@property (readwrite) CGFloat widthInPalette;
@property (readwrite) CGFloat heightInPalette;
@property (readwrite) CGPoint centerInPalette;

@end

@implementation GameBlock


- (id)init{
        
   
    
    UIImage* blockImg = [UIImage imageNamed:@"straw.png"];
    UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
    
    self.widthInPalette =  0.6*blockImg.size.width;
    self.heightInPalette =  blockImg.size.height;
    self.centerInPalette = CGPointMake(250,50);
    
    
    block.frame = CGRectMake(self.centerInPalette.x - self.widthInPalette/2,
                               self.centerInPalette.y - self.heightInPalette/2,
                               self.widthInPalette,
                               self.heightInPalette);
    self.view = block;
    self.model = [[PERectangle alloc] initPERectangleWithCenter:self.view.center
                                                          Width:self.widthInPalette
                                                         Height:4*self.heightInPalette
                                                        andMass:100];
    self.model.myDelegate = self;
    self.view.tag = 3;
    
    return self;

    
}


- (void)translate:(UIPanGestureRecognizer*)gesture{
    
    // MODIFIES: object model (coordinates)
    // REQUIRES: game in designer mode
    // EFFECTS: the user drags around the object with one finger
    //          if the object is in the palette, it will be moved in the game area
    
    assert(self.myDelegate != Nil);
    
    if([self.myDelegate isInMiddleOfGame])
        return;
    
    [self.myDelegate disableGamearea];
    
    
    
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    [gesture.view setBounds:CGRectMake(0, 0, self.widthInPalette, 4*self.heightInPalette)];
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                      gesture.view.center.y + translation.y);
    
    
    [gesture setTranslation:CGPointZero inView:gesture.view.superview];
    
    
    if (gesture.state == UIGestureRecognizerStateChanged &&
        
        [self.myDelegate shouldAddToGameArea:gesture.view]) {
        
        [self.myDelegate addToGameArea:gesture.view];
        
        [self.myDelegate createNewGameBlock];
        
    }
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [self.myDelegate enableGamearea];
        
        if ([self.myDelegate notMovedOutOfPalette:gesture.view]) {
            
            self.view.transform = CGAffineTransformIdentity;
            self.view.frame = CGRectMake(self.centerInPalette.x - self.widthInPalette/2,
                                         self.centerInPalette.y - self.heightInPalette/2,
                                         self.widthInPalette,
                                         self.heightInPalette);
            [self.myDelegate addToPalette:self.view];

            
        }
        
    }
    
    self.model.center = gesture.view.center;
    
    
    
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
    
    
    CGAffineTransform t = self.view.transform;
    CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
    CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
    
    
    self.model.width = self.widthInPalette * xSize;
    self.model.height = 4*self.heightInPalette * ySize;
    
    [self.model updateMomentOfInertia];
    
    
    
}


- (void)singleTap:(UITapGestureRecognizer*) recognizer{
    
    [self changeTexture];
    
}


-(void)changeTexture{
    
    if(![self.myDelegate isInPalette:self.view]){
        
        if(self.view.tag == 3){
            
            self.view.tag = 4;
            UIImage* blockImg = [UIImage imageNamed:@"stone.png"];
            UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
            block.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [self.view addSubview:block];
            
            
            
        }else if(self.view.tag == 4){
            
            self.view.tag = 5;
            UIImage* blockImg = [UIImage imageNamed:@"iron.png"];
            UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
            block.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [self.view addSubview:block];
        
        }else if(self.view.tag == 5){
            
            self.view.tag = 3;
            UIImage* blockImg = [UIImage imageNamed:@"straw.png"];
            UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
            block.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);

            [self.view addSubview:block];
                    

                    
        }
        
        
    }
    
}


-(void) restore{
    
    if(![self.myDelegate isInPalette:self.view]){
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }
    
}




@end
