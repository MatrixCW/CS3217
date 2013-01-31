//
//  ViewController.m
//  Game
//
//  Created by Cui Wei on 1/23/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Load the image into UIImage objects
    UIImage *bgImage = [UIImage imageNamed:@"background.png"];
    UIImage *groundImage = [UIImage imageNamed:@"ground.png"];
    
    //Place each of them into a UIImageView
    
    //CGRect rect = CGRectMake(0, 0, 1024, 748);
    ///CGImageRef imageRef = CGImageCreateWithImageInRect([bgImage CGImage], rect);
    ////UIImage *img = [UIImage imageWithCGImage:imageRef];
    //CGImageRelease(imageRef);
    
    UIImageView *background = [[UIImageView alloc] initWithImage:bgImage ];
    UIImageView *ground = [[UIImageView alloc] initWithImage:groundImage ];
    
    //Get the width and height of the two images
    CGFloat backgroundWidth = bgImage.size.width;
    CGFloat backgroundHeight = bgImage.size.height;
    CGFloat groundWidth = groundImage.size.width;
    CGFloat groundHeight = groundImage.size.height;
    
    //Compute the y position for the two UIImageView
    CGFloat groundY = _gamearea.frame.size.height - groundHeight;
    CGFloat backGroundY = groundY - backgroundHeight;
    
    //The frame property holds the position and size of the views
    //The CGRectMake methods arguments are : x position, y position, width, height
    background.frame = CGRectMake(0, backGroundY, backgroundWidth, backgroundHeight);
    ground.frame = CGRectMake(0, groundY, groundWidth, groundHeight);
    
    //Add these views as subviews of the gamearea
    [_gamearea addSubview:background];
    [_gamearea addSubview:ground];
    
    //Set the content size so the gamearea is scrollable
    //Otherwise it defaults to the current window size
    
    //CGFloat gameareaHeight = backgroundHeight + groundHeight;  Don't want scrollable vertically
    CGFloat gameareaWidth = backgroundWidth;
    [_gamearea setContentSize:CGSizeMake(gameareaWidth, 0)];
    
    
    [self setWolf];

    
}


-(void)setWolf{
    UIImage* wolfImg = [UIImage imageNamed:@"wolf"];
    UIImageView* wolf = [[UIImageView alloc] initWithImage:wolfImg];
    
    wolf.frame = CGRectMake(20, 8, 120, 80);
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanForWolf:)];
    [wolf addGestureRecognizer:pan];
    wolf.userInteractionEnabled = YES;
    [_selectBar addSubview:wolf];

}

-(void)handlePanForWolf:(UIPanGestureRecognizer*) recognizer{
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    recognizer.view.center=CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view];
    
    if(recognizer.view.center.y>=_selectBar.frame.size.height){
        if (recognizer.view.superview != _gamearea) {
        recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y-_selectBar.frame.size.height);
        [_gamearea addSubview:recognizer.view];
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    UIColor *newColor;
    UIButton *button = (UIButton*)sender;
    
    if(button.tintColor == [UIColor blackColor]){
        newColor = [UIColor redColor];
    }else{
        newColor = [UIColor blackColor];
    }
    [button setTintColor:newColor];
     
    
}

- (void)say {
    NSLog(@"I can say");
   
    
}

- (void)viewDidUnload {
    [self setSelectBar:nil];
    [super viewDidUnload];
}
@end
