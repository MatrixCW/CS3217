//
//  GameStraw.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameBlock.h"

@interface GameBlock ()

@end

@implementation GameBlock

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GameBlock*)initWithBackground:(UIScrollView*) downArea:(UIView*)upArea{
//override
//init a gameObject and associate it with the gameArea and selectBar
    
        
    self.originalHeight = 55;
    self.originalWidth = 55;
    self.currentHeight = 130;
    self.currentWidth = 30;
    self.center =CGPointMake(320, 60);
    self.gamearea = downArea;
    self.selectBar = upArea;
    
    UIImage* blockImg = [UIImage imageNamed:@"straw.png"];
    UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
    
    block.frame =  CGRectMake(self.center.x-self.originalWidth/2,
                              self.center.y-self.originalHeight/2,
                              self.originalWidth,
                              self.originalHeight);
    
    self.selfImgView = block;
    self.selfImgView.tag = kGameObjectBlock;
    self.selfImgView.userInteractionEnabled = YES;
    
    [self setRecognizer];
    
    self.view.tag = kGameObjectBlock;
    self.count = 0;
    
    return  self;
    
}


- (void)translate:(UIPanGestureRecognizer*)gesture{
    // MODIFIES: object model (coordinates)
    // REQUIRES: game in designer mode
    // EFFECTS: the user drags around the object with one finger
    //          if the object is in the palette, it will be moved in the game area
    
    
    self.gamearea.scrollEnabled = NO;
    
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    [gesture.view setBounds:CGRectMake(0, 0, self.currentWidth, self.currentHeight)];
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                      gesture.view.center.y + translation.y);
    
    [gesture setTranslation:CGPointZero inView:gesture.view.superview];
    
    
    if (gesture.state == UIGestureRecognizerStateChanged &&
        gesture.view.superview == self.selectBar &&
        gesture.view.center.y - self.view.frame.size.height/2 >= self.selectBar.frame.size.height) {
        
        gesture.view.center = CGPointMake(self.gamearea.contentOffset.x + gesture.view.center.x,
                                          gesture.view.center.y - self.selectBar.frame.size.height);
        
        [self.gamearea addSubview:gesture.view];
        
        self.nextGameBlock = [[GameBlock alloc] initWithBackground:self.gamearea :self.selectBar];
        
        [self.selectBar addSubview:self.nextGameBlock.view];
        
            
    }
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        self.gamearea.scrollEnabled = YES;
        
        if (gesture.view.center.y <= self.selectBar.frame.size.height && gesture.view.superview == self.selectBar) {
            
            
            [gesture.view setBounds:CGRectMake(0, 0, self.originalWidth, self.originalHeight)];
            gesture.view.center = CGPointMake(self.center.x , self.center.y);
            
        }
        
    }
    
    
}

-(void) releaseObject{
    
    [self.view removeFromSuperview];
    
}

-(void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [self changeTexture];
    
    
}


-(void)changeTexture{
    
    if(self.view.superview == self.gamearea){
        
        if(self.count == 0){
            
            self.count = (++self.count)%3;
            UIImage* blockImg = [UIImage imageNamed:@"stone.png"];
            UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
            block.frame =CGRectMake(0, 0, self.currentWidth, self.currentHeight);
            [self.view addSubview:block];
            self.view.tag = 4;
            
            
        }else
            
            if(self.count == 1){
                self.count = (++self.count)%3;
                UIImage* blockImg = [UIImage imageNamed:@"iron.png"];
                UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
                block.frame =CGRectMake(0, 0, self.currentWidth, self.currentHeight);
                [self.view addSubview:block];
                self.view.tag = 5;

                
            }else
                
                if(self.count == 2){
                    self.count = (++self.count)%3;
                    UIImage* blockImg = [UIImage imageNamed:@"straw.png"];
                    UIImageView* block = [[UIImageView alloc]initWithImage:blockImg];
                    block.frame =CGRectMake(0, 0, self.currentWidth, self.currentHeight);
                    [self.view addSubview:block];
                    self.view.tag = 3;

                    
                }
        
        
    }
}

-(void) moveToTarget:(CGPoint)center withTransform:(CGAffineTransform)transform andTexture:(int)count{
    
    [self.view setBounds:CGRectMake(0, 0, self.currentWidth, self.currentHeight)];
    self.view.center = center;
    self.view.transform = transform;
    self.count = (count+2)%3;
    [self.gamearea addSubview:self.view];
    [self changeTexture];
}


@end
