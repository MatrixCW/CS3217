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
    
    self.simulatedWorld = [[MyWorld alloc] init];

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
    
    GameObject *test = [[GameWolf alloc] init];
    test.myDelegate = self;
    [self addChildViewController:test];
    [self.palette addSubview:test.view];
    [self addRecognizer:test.view :test];
    test.view.userInteractionEnabled = YES;
    
    
    GameObject *test2 = [[GamePig alloc] init];
    test2.myDelegate = self;
    [self addChildViewController:test2];
    [self.palette addSubview:test2.view];
    [self addRecognizer:test2.view :test2];
    test2.view.userInteractionEnabled = YES;
    
    
    GameObject *test3 = [[GameBlock alloc] init];
    test3.myDelegate = self;
    [self addChildViewController:test3];
    [self.palette addSubview:test3.view];
    [self addRecognizer:test3.view :test3];
    test3.view.userInteractionEnabled = YES;
    
    self.lowerBound = [PERectangleViewController getLowerHorizontalBoundRectangle];
    //[self.gamearea addSubview:self.lowerBound.view];
    self.leftBound = [PERectangleViewController getLeftVerticalBoundRectangle];
    //[self.gamearea addSubview:self.leftBound.view];
    self.rightBound = [PERectangleViewController getRightVerticalBoundRectangle];
    //[self.gamearea addSubview:self.rightBound.view];

    
    
    
        

    
}


-(void)addRecognizer:(UIView*)view :(UIViewController*)controller{
    
        
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:controller
                                                                              action:@selector(translate:)];
    [pan setMaximumNumberOfTouches:1];
    pan.delegate = (GameObject*)controller;
    [view addGestureRecognizer:pan];
    
    
    
    UIPinchGestureRecognizer *zoom = [[UIPinchGestureRecognizer alloc] initWithTarget:controller
                                                                               action:@selector(zoom:)];
    zoom.delegate = (GameObject*)controller;;
    [view addGestureRecognizer:zoom];
    
    
    
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:controller
                                                                                       action:@selector(rotate:)];
    rotate.delegate = (GameObject*)controller;
    [view addGestureRecognizer:rotate];
    
    
    
    UITapGestureRecognizer *singaleTap = [[UITapGestureRecognizer alloc] initWithTarget:controller
                                                                                 action:@selector(singleTap:)];
    [singaleTap setNumberOfTapsRequired:1];
    singaleTap.delegate = (GameObject*)controller;;
    [view addGestureRecognizer:singaleTap];
    
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:controller
                                                                                action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    doubleTap.delegate = (GameObject*)controller;;
    [view addGestureRecognizer:doubleTap];
    
    
        
                  
    
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
-(BOOL)isInPalette:(UIView*) view{
    return view.superview == self.palette;
}
-(BOOL)isInGameArea:(UIView*) view{
    return view.superview == self.gamearea;
}
-(void)createNewGameBlock{
    
    GameObject *test = [[GameBlock alloc] init];
    test.myDelegate = self;
    [self addChildViewController:test];
    [self.palette addSubview:test.view];
    [self addRecognizer:test.view :test];
    test.view.userInteractionEnabled = YES;
}
-(void)addDirectlyToGameArea:(UIView*) view{
    [self.gamearea addSubview:view];
}
-(BOOL)isInMiddleOfGame{
    return self.gameStarted;
}
-(void)firePuff:(int) power{
    
    UIImage* puffImages = [UIImage imageNamed:@"windblow.png"];
    CGImageRef imageRef = CGImageCreateWithImageInRect([puffImages CGImage], CGRectMake(338.25,0,112.75,104));
    UIImage* singlePuffImage = [UIImage imageWithCGImage:imageRef];
    
    Aimer* myAimer = [self getAimerViewController];
    
    Vector2D* fireDirection = myAimer.direction;
    NSLog(@"zzzzz %lf", atan2(fireDirection.x, fireDirection.y));
    PECircleViewController *puff = [[PECircleViewController alloc] initPECircleWithCenter:CGPointMake(myAimer.view.center.x + 80 ,
                                                                                                      myAimer.view.center.y - 15)
                                                                                     mass:100
                                                                                 andImage:singlePuffImage];
    [self addChildViewController:puff];
    [self.gamearea addSubview:puff.view];
    puff.model.velocity =  [Vector2D vectorWith:50*power*fireDirection.x y:-50*power*fireDirection.y];
    [self.simulatedWorld.objectsInWorld addObject:puff.model];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)resetButtonPressed:(id)sender {
    
    [self.simulatedWorld stopTimer];
    [self removeAimer];
    self.gameStarted = NO;
    [self reset];
    
}

- (IBAction)saveButtonPressed:(id)sender {
   
    [self save];
}


- (IBAction)loadButtonPressed:(id)sender {
    

    
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
        
        UIActionSheet *browseActionSheet = [[UIActionSheet alloc] initWithTitle:CHOOSE_FILE_TO_LOAD
                                                                  delegate:self
                                                                  cancelButtonTitle:nil
                                                                  destructiveButtonTitle:nil
                                                                  otherButtonTitles:nil];
        
        for (NSString* name in files)
            [browseActionSheet addButtonWithTitle: name];
            
        
        
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

- (IBAction)startButtonPressed:(id)sender {
    
   
    
    
    if([self canStartGame]){
    
        self.gameStarted = YES;
        [self drawBounds];
        [self drawAimer];
        
        for(UIViewController *controller in self.childViewControllers){
            if(controller.view.superview == self.gamearea && [controller isKindOfClass:GameObject.class]){
                GameObject* temp = (GameObject*) controller;
                [self.simulatedWorld.objectsInWorld addObject:temp.model];
              }
         }
    
       [self.simulatedWorld run];
    }
    
    
    
}

-(BOOL)canStartGame{
    return self.simulatedWorld.objectsInWorld.count == 0 &&
           [self getGameWolfViewController].view.superview == self.gamearea &&
           [self getGamePigViewController].view.superview == self.gamearea;    
}


-(void)drawAimer{
    
    GameWolf *myGameWolf = [self getGameWolfViewController];
    myGameWolf.view.center = CGPointMake(myGameWolf.view.center.x, 415);
    myGameWolf.model.center = myGameWolf.view.center;
    
    Aimer* myAimer = [[Aimer alloc] initWithPosition:CGPointMake(myGameWolf.view.center.x,
                                                                 myGameWolf.view.center.y)];
    [self.gamearea addSubview:myAimer.view];
    [self addChildViewController:myAimer];
    
    PowerMeter* myPowerMeter = [[PowerMeter alloc] initWithPosition:CGPointMake(myGameWolf.view.center.x - 50,
                                                                                myGameWolf.view.center.y)];
    myPowerMeter.myDelegate = self;
    [self addChildViewController:myPowerMeter];
    [self.gamearea addSubview:myPowerMeter.view];
    
    
    
    
    UIImage* directionDegree = [UIImage imageNamed:@"direction-degree.png"];
    UIImageView* directionDegreeView = [[UIImageView alloc]initWithImage:directionDegree];
    directionDegreeView.tag = -1;
    directionDegreeView.frame =  CGRectMake(myGameWolf.view.center.x + 30,
                                            myGameWolf.view.center.y - 190,
                                            directionDegree.size.width,
                                            directionDegree.size.height);
    
    [self.gamearea addSubview:directionDegreeView];
}

-(void)drawBounds{
    [self.simulatedWorld.objectsInWorld addObject:self.lowerBound.model];

    [self.simulatedWorld.objectsInWorld addObject:self.leftBound.model];

    [self.simulatedWorld.objectsInWorld addObject:self.rightBound.model];

    
}
-(void)removeAimer{
    
    [[self getAimerViewController].view removeFromSuperview];
    [[self getAimerViewController] removeFromParentViewController];
    
    [[self getPowerMeterViewController].view removeFromSuperview];
    [[self getPowerMeterViewController] removeFromParentViewController];
    
    for(UIView* vw in self.gamearea.subviews)
        if(vw.tag == -1)
            [vw removeFromSuperview];
}


@end
