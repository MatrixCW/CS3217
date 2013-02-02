//
//  GamePig.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GamePig.h"

@interface GamePig ()

@end

@implementation GamePig

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

- (GamePig*)initWithBackground:(UIScrollView*) downArea:(UIView*)upArea{
    
    
    
    self.originalHeight = 66;
    self.originalWidth = 66;
    self.currentHeight = 88;
    self.currentWidth = 88;
    self.center =CGPointMake(200, 60);
    self.gamearea = downArea;
    self.selectBar = upArea;
    
    UIImage* pigImg = [UIImage imageNamed:@"pig.png"];
    UIImageView* pig = [[UIImageView alloc]initWithImage:pigImg];
    
    pig.frame =  CGRectMake(self.center.x-self.originalWidth/2,
                            self.center.y-self.originalHeight/2,
                            self.originalWidth,
                            self.originalHeight);
    
    self.selfImgView = pig;
    self.selfImgView.userInteractionEnabled = YES;
    
    [self setRecognizer];
    
    self.view.tag = kGameObjectPig;

    return  self;
    
}

@end
