//
//  GameStraw.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameStraw.h"

@interface GameStraw ()

@end

@implementation GameStraw

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

- (GameStraw*)initWithBackground:(UIScrollView*) downArea:(UIView*)upArea{
    
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
    
    return  self;
    
}


@end
