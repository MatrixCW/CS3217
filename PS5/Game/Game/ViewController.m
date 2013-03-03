//
//  ViewController.m
//  Game
//
//  Created by Cui Wei on 1/23/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Extension.h"

#define defaultLives 50

typedef enum {whiteWind = 10,redWind = 11,blueWind = 12,greenWind = 13}windBlowType;


@interface ViewController ()

@property int puffsLeft;

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
    
    self.puffsLeft = defaultLives;
    
    self.simulatedWorld = [[MyWorld alloc] init];
    self.simulatedWorld.myDelegate = self;


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
    
    [[self getGameWolfViewController].view removeFromSuperview];
    [[self getGameWolfViewController] blow];
    
    [self performSelector:@selector(addPuff:) withObject:[NSNumber numberWithInt:power] afterDelay:0.6];
    
    
}

-(void)objectDestroyed:(GameObject*) uivc{
    
    if([uivc isKindOfClass:GamePig.class]){
        
        [self gamePigDestroyed];
    }
    else{
        
        [self.simulatedWorld.objectsInWorld removeObject:uivc.model];
        [uivc.view removeFromSuperview];
        [uivc removeFromParentViewController];
        
    }
    
}

-(void)removePuff{
    
    PECircleViewController* puffViewController = [self getPuffViewController];
    
    [puffViewController.view removeFromSuperview];
    
    int tag = whiteWind;
    
    for(UIView* vw in self.gamearea.subviews){
        if(vw.frame.origin.x == 60 && vw.frame.origin.y == 505)
            tag = vw.tag;
    }
    
    [puffViewController animate:tag];
    [self.simulatedWorld.objectsInWorld removeObject:puffViewController.model];
    [self performSelector:@selector(removePuffViewControl:) withObject:puffViewController afterDelay:1];
    
}


-(void)removePuffViewControl:(PECircleViewController*)puffViewController{
    [puffViewController removeFromParentViewController];
}


-(void)gamePigDestroyed{
    
    [[self getGamePigViewController] cry];
    
    UIAlertView *youWin = [[UIAlertView alloc] initWithTitle:@"Congratulations"
                                                    message:@"You have won the game"
                                                   delegate:self
                                          cancelButtonTitle:@"start new game"
                                          otherButtonTitles:Nil];
    [youWin show];
    
}



-(void)addPuff:(NSNumber*) powerValue{
    
    self.puffsLeft -- ;
    
    if(self.puffsLeft == -1){
        [self wolfDie];
        return;
    }
    
    [self showLivesLeft];
    
    int power = [powerValue intValue];
    
    int tag = whiteWind;
    
    for(UIView* vw in self.gamearea.subviews){
        if(vw.frame.origin.x == 60 && vw.frame.origin.y == 505)
            tag = vw.tag;
    }
    
    
    
    UIImage* puffImages;
    
    switch (tag) {
        case whiteWind:
            puffImages = [UIImage imageNamed:@"windblow.png"];
            break;
            
        case redWind:
            puffImages = [UIImage imageNamed:@"windblow1.png"];
            break;
            
        case blueWind:
            puffImages = [UIImage imageNamed:@"windblow2.png"];
            break;
            
        case greenWind:
            puffImages = [UIImage imageNamed:@"windblow3.png"];
            break;
            
        default:
            break;
    }

    
    CGImageRef imageRef = CGImageCreateWithImageInRect([puffImages CGImage], CGRectMake(338.25,0,112.75,104));
    UIImage* singlePuffImage = [UIImage imageWithCGImage:imageRef];
    
    Aimer* myAimer = [self getAimerViewController];
    
    Vector2D* fireDirection = myAimer.direction;
    PECircleViewController *puff = [[PECircleViewController alloc] initPECircleWithCenter:CGPointMake(myAimer.view.center.x + 100 ,
                                                                                                      myAimer.view.center.y - 20)
                                                                                     mass:100
                                                                                 andImage:singlePuffImage];
    puff.myDelegate = self;
    [self addChildViewController:puff];
    [self.gamearea addSubview:puff.view];
    puff.model.velocity =  [Vector2D vectorWith:70*power*fireDirection.x y:-70*power*fireDirection.y];
    [self.simulatedWorld.objectsInWorld addObject:puff.model];
    
    
    
    
    
    
}  
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)resetButtonPressed:(id)sender {
    
    NSMutableArray* viewsToBeMoved = [NSMutableArray array];
    
    for(UIView* vw in self.palette.subviews){
        if(vw.center.x > 600)
            [viewsToBeMoved addObject:vw];
    }
    
    for(UIView* vw in self.gamearea.subviews){
        if(vw.frame.origin.y == 520 || vw.frame.origin.y == 505)
            [viewsToBeMoved addObject:vw];
    }

    [viewsToBeMoved makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.simulatedWorld stopTimer];
    [self removeAimer];
    self.gameStarted = NO;
    self.puffsLeft = defaultLives;
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
        
        [self addBlowType];
        [self showLivesLeft];

        
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
    
    GamePig *myGamePig = [self getGamePigViewController];
    myGamePig.view.center = CGPointMake(myGamePig.view.center.x, 430);
    myGamePig.model.center = myGamePig.view.center;
    
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

-(void)addBlowType{
    
   
    UIImage* whitePuffImages = [UIImage imageNamed:@"windblow.png"];
    CGImageRef imageRef = CGImageCreateWithImageInRect([whitePuffImages CGImage], CGRectMake(338.25,0,112.75,104));
    UIImage* singlePuffImage = [UIImage imageWithCGImage:imageRef];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
    imageView.tag = whiteWind;
    imageView.frame = CGRectMake(200, 520, 56, 52);
    [self.gamearea addSubview:imageView];
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBlowType:)];
    [imageView addGestureRecognizer:tap1];
    imageView.userInteractionEnabled = YES;
    
    UIImage* redPuffImages = [UIImage imageNamed:@"windblow1.png"];
    imageRef = CGImageCreateWithImageInRect([redPuffImages CGImage], CGRectMake(338.25,0,112.75,104));
    singlePuffImage = [UIImage imageWithCGImage:imageRef];
    imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
    imageView.tag = redWind;
    imageView.frame = CGRectMake(270, 520, 56, 52);
    [self.gamearea addSubview:imageView];
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBlowType:)];
    [imageView addGestureRecognizer:tap2];
    imageView.userInteractionEnabled = YES;
    
    UIImage* bluePuffImages = [UIImage imageNamed:@"windblow2.png"];
    imageRef = CGImageCreateWithImageInRect([bluePuffImages CGImage], CGRectMake(338.25,0,112.75,104));
    singlePuffImage = [UIImage imageWithCGImage:imageRef];
    imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
    imageView.tag = blueWind;
    imageView.frame = CGRectMake(340, 520, 56, 52);
    [self.gamearea addSubview:imageView];
    UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBlowType:)];
    [imageView addGestureRecognizer:tap3];
    imageView.userInteractionEnabled = YES;
    
    UIImage* greenPuffImages = [UIImage imageNamed:@"windblow3.png"];
    imageRef = CGImageCreateWithImageInRect([greenPuffImages CGImage], CGRectMake(338.25,0,112.75,104));
    singlePuffImage = [UIImage imageWithCGImage:imageRef];
    imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
    imageView.tag = greenWind;
    imageView.frame = CGRectMake(410, 520, 56, 52);
    [self.gamearea addSubview:imageView];
    UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBlowType:)];
    [imageView addGestureRecognizer:tap4];
    imageView.userInteractionEnabled = YES;


}

-(void)chooseBlowType:(UIGestureRecognizer*)gesture{
    
    for(UIView* vw in self.gamearea.subviews){
        if(vw.frame.origin.x == 60 && vw.frame.origin.y == 505)
           [vw removeFromSuperview];
    }
    
    
    UIImage* puffImages;
    CGImageRef imageRef; 
    UIImage* singlePuffImage; 
    UIImageView* imageView;
    
    switch (gesture.view.tag) {
        case whiteWind:
            puffImages = [UIImage imageNamed:@"windblow.png"];
            imageRef = CGImageCreateWithImageInRect([puffImages CGImage], CGRectMake(338.25,0,112.75,104));
            singlePuffImage = [UIImage imageWithCGImage:imageRef];
            imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
            break;
            
        case redWind:
            puffImages = [UIImage imageNamed:@"windblow1.png"];
            imageRef = CGImageCreateWithImageInRect([puffImages CGImage], CGRectMake(338.25,0,112.75,104));
            singlePuffImage = [UIImage imageWithCGImage:imageRef];
            imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
            break;
            
        case blueWind:
            puffImages = [UIImage imageNamed:@"windblow2.png"];
            imageRef = CGImageCreateWithImageInRect([puffImages CGImage], CGRectMake(338.25,0,112.75,104));
            singlePuffImage = [UIImage imageWithCGImage:imageRef];
            imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
            break;
            
        case greenWind:
            puffImages = [UIImage imageNamed:@"windblow3.png"];
            imageRef = CGImageCreateWithImageInRect([puffImages CGImage], CGRectMake(338.25,0,112.75,104));
            singlePuffImage = [UIImage imageWithCGImage:imageRef];
            imageView = [[UIImageView alloc] initWithImage:singlePuffImage];
            break;
            
        default:
            break;
    }
    
    imageView.frame = CGRectMake(60, 505, 84, 78);
    imageView.tag = gesture.view.tag;
    [self.gamearea addSubview:imageView];
    


 
}

-(NSArray*)getNumberImages{
    
    UIImage *chars = [UIImage imageNamed:@"font.png"];
    
    CGRect cropRect = CGRectMake(460, 13, 25,26);
    CGImageRef imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * zero = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(492, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * one = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(518, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * two = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(555, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * three = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(590, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * four = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(625, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * five = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(660, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * six = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(695, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * seven = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(723, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * eight = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    cropRect = CGRectMake(756, 11, 25,30);
    imageRef = CGImageCreateWithImageInRect([chars CGImage], cropRect);
    UIImage * nine = [UIImage imageWithCGImage:imageRef scale:1 orientation:chars.imageOrientation];
    
    NSArray* numbers = [[NSArray alloc] initWithObjects:zero,one,two,three,four,five,six,seven,eight,nine, nil];
    
    return numbers;

}

-(void)showLivesLeft{
    
    NSMutableArray* viewsToBeMoved = [NSMutableArray array];
    
    for(UIView* vw in self.palette.subviews){
        if(vw.center.x > 600)
            [viewsToBeMoved addObject:vw];
    }
    
    [viewsToBeMoved makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray* digits = [self getNumberImages];
    
    if(self.puffsLeft / 10 >= 1){
        
        int firstDigit = self.puffsLeft / 10;
        int secondDigit = self.puffsLeft % 10;
        
        UIImage* heartImage = [UIImage imageNamed:@"heart.png"];
        UIImageView* heartView = [[UIImageView alloc] initWithImage:heartImage];
        heartView.frame = CGRectMake(800, 30, heartImage.size.width, heartImage.size.height);
        [self.palette addSubview:heartView];
        
        UIImage* multiplyImage = [UIImage imageNamed:@"multiply.png"];
        UIImageView* multiplyView = [[UIImageView alloc] initWithImage:multiplyImage];
        multiplyView.frame = CGRectMake(850, 30, multiplyImage.size.width, multiplyImage.size.height);
        [self.palette addSubview:multiplyView];

        
        UIImage* firstDigitImage = [digits objectAtIndex:firstDigit];
        UIImageView* firstDigitView = [[UIImageView alloc] initWithImage:firstDigitImage];
        firstDigitView.frame = CGRectMake(900, 30, firstDigitImage.size.width, firstDigitImage.size.height);
        [self.palette addSubview:firstDigitView];

        
        UIImage* secondDigitImage = [digits objectAtIndex:secondDigit];
        UIImageView* secondDigitView = [[UIImageView alloc] initWithImage:secondDigitImage];
        secondDigitView.frame = CGRectMake(920, 30, secondDigitImage.size.width, secondDigitImage.size.height);
        [self.palette addSubview:secondDigitView];


        
        
        
    }
    else{
        
        int digit = self.puffsLeft % 10;
        
        
        UIImage* heartImage = [UIImage imageNamed:@"heart.png"];
        UIImageView* heartView = [[UIImageView alloc] initWithImage:heartImage];
        heartView.frame = CGRectMake(800, 30, heartImage.size.width, heartImage.size.height);
        [self.palette addSubview:heartView];
        
        UIImage* multiplyImage = [UIImage imageNamed:@"multiply.png"];
        UIImageView* multiplyView = [[UIImageView alloc] initWithImage:multiplyImage];
        multiplyView.frame = CGRectMake(850, 30, multiplyImage.size.width, multiplyImage.size.height);
        [self.palette addSubview:multiplyView];
        
        
        UIImage* digitImage = [digits objectAtIndex:digit];
        UIImageView* digitView = [[UIImageView alloc] initWithImage:digitImage];
        digitView.frame = CGRectMake(900, 30, digitImage.size.width, digitImage.size.height);
        [self.palette addSubview:digitView];
        
        
                
    }
    
}

-(void)wolfDie{
    
    
    [[self getGameWolfViewController].view setAlpha:0.0];
    [[self getGameWolfViewController] wolfDie];
    
    
    UIAlertView *youLose = [[UIAlertView alloc] initWithTitle:@"Oops, Game Over"
                                                     message:@"You have lost the game"
                                                    delegate:self
                                           cancelButtonTitle:@"Try another round!"
                                           otherButtonTitles:Nil];
    [youLose show];
     
    
}

- (IBAction)loadLevels:(id)sender {
    
    
    
    UIBarButtonItem* myButton = (UIBarButtonItem*) sender;
    
    [self resetButtonPressed:Nil];
    NSString *filePath;
    if([myButton.title isEqualToString:@"Level1"])
        filePath = [[NSBundle mainBundle] pathForResource:@"Level1" ofType:@"plist"];
    if([myButton.title isEqualToString:@"Level2"])
        filePath = [[NSBundle mainBundle] pathForResource:@"Level2" ofType:@"plist"];
    if([myButton.title isEqualToString:@"Level3"])
        filePath = [[NSBundle mainBundle] pathForResource:@"Level3" ofType:@"plist"];
    
    
    [self loadDefaultLevel:filePath];
}
@end
