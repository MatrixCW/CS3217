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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// Rotation 6.0

// Tell the system It should autorotate
- (BOOL) shouldAutorotate {
    return YES;
}

// Tell the system which initial orientation we want to have
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
    
}

// Tell the system what we support
-(NSUInteger)supportedInterfaceOrientations
{
    // return UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskAll;
    // return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *bgImage = [UIImage imageNamed:@"background.png"];
    UIImage *groundImage = [UIImage imageNamed:@"ground.png"];
    
       
    UIImageView *background = [[UIImageView alloc] initWithImage:bgImage ];
    UIImageView *ground = [[UIImageView alloc] initWithImage:groundImage ];
    
        CGFloat backgroundWidth = bgImage.size.width;
    CGFloat backgroundHeight = bgImage.size.height;
    CGFloat groundWidth = groundImage.size.width;
    CGFloat groundHeight = groundImage.size.height;
    
    
    CGFloat groundY = _gamearea.frame.size.height - groundHeight;
    CGFloat backGroundY = groundY - backgroundHeight;
    
    //The frame property holds the position and size of the views
    //The CGRectMake methods arguments are : x position, y position, width, height
    background.frame = CGRectMake(0, backGroundY, backgroundWidth, backgroundHeight);
    ground.frame = CGRectMake(0, groundY, groundWidth, groundHeight);
    
    //Add these views as subviews of the gamearea
    [_gamearea addSubview:background];
    
    [_gamearea addSubview:ground];
   
    CGFloat gameareaHeight = backgroundHeight + groundHeight;
    CGFloat gameareaWidth = backgroundWidth;
    [_gamearea setContentSize:CGSizeMake(gameareaWidth, gameareaHeight)];
    
    GameObject *test = [[GameObject alloc] init];
    test.myDelegate = self;
    [self addChildViewController:test];
    [self.palette addSubview:test.view];
    [self addRecognizer:test.view :test];
    test.view.userInteractionEnabled = YES;
    
    
    

    
}


-(void)addRecognizer:(UIView*)view :(UIViewController*)controller{
    
        
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:controller
                                                                              action:@selector(translate:)];
    [pan setMaximumNumberOfTouches:1];
    pan.delegate = (GameObject*)controller;
    [view addGestureRecognizer:pan];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:controller
                                                                                action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    doubleTap.delegate = (GameObject*)controller;;
    [view addGestureRecognizer:doubleTap];
    
    UIPinchGestureRecognizer *zoom = [[UIPinchGestureRecognizer alloc] initWithTarget:controller
                                                                               action:@selector(zoom:)];
    zoom.delegate = (GameObject*)controller;;
    [view addGestureRecognizer:zoom];
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:controller
                                                                                       action:@selector(rotate:)];
    rotate.delegate = (GameObject*)controller;
    [view addGestureRecognizer:rotate];
    
    
    
        
                  
    
}

-(void)disableGamearea{
    self.gamearea.scrollEnabled = NO;
}
-(void)enableGamearea{
    self.gamearea.scrollEnabled = YES;
}
-(BOOL)shouldAddToGameArea:(UIView*) view{
    return  (view.superview == self.palette &&
            view.center.y - view.frame.size.height/2 > self.palette.frame.size.height);
}
-(BOOL)notMovedOutOfPalette:(UIView*) view{
    return   (view.center.y - view.frame.size.height/2 <= self.palette.frame.size.height &&
             view.superview == self.palette);
}
-(void)addToGameArea:(UIView*) view{
    
    view.center = CGPointMake(self.gamearea.contentOffset.x + view.center.x,
                              view.center.y - self.palette.frame.size.height);
    
    [self.gamearea addSubview:view];
    
}
-(void)addToPalette:(UIView*) view{

    [self.palette addSubview:view];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)resetButtonPressed:(id)sender {
    
    
    [self reset];
    
}

- (IBAction)saveButtonPressed:(id)sender {
   
    [self save];
}


- (IBAction)loadButtonPressed:(id)sender {
    

    
    NSArray *files = [self getAllFilesUnderGameDirectory];
    
    if(files.count == 0){ //currently no file saved
        
        UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:NO_DATA_STORED
                                                         message:Nil
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [dialog show];
    }
    else{
        
        UIActionSheet *browseActionSheet = [[UIActionSheet alloc] initWithTitle:CHOOSE_FILE_TO_LOAD
                                                                  delegate:self
                                                                  cancelButtonTitle:nil
                                                                  destructiveButtonTitle:nil
                                                                  otherButtonTitles:nil];
        
        for (NSString* name in files) {
            
            [browseActionSheet addButtonWithTitle: name];
            
        }
        
        browseActionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        
        [browseActionSheet showFromBarButtonItem: self.myLoadButton animated:YES];
        
    }

}



- (IBAction)deleteButtonPressed:(id)sender {
    
    NSArray *files = [self getAllFilesUnderGameDirectory];

    if(files.count == 0){
        
        UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:NO_DATA_STORED
                                                        message:Nil
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [dialog show];
        
    }
    else{
    
    UIActionSheet *browseActionSheet = [[UIActionSheet alloc] initWithTitle:CHOOSE_FILE_TO_DELETE
                                                              delegate:self
                                                              cancelButtonTitle:nil
                                                              destructiveButtonTitle:nil
                                                              otherButtonTitles:nil];
        for (NSString* name in files)  
              [browseActionSheet addButtonWithTitle: name];
        
    browseActionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [browseActionSheet showFromBarButtonItem: self.myDeleteButton animated:YES];
    
    }
    
   
}








@end
