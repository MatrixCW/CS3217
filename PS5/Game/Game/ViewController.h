//
//  ViewController.h
//  Game
//
//  Created by Cui Wei on 1/23/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameObject.h"
#import "GameWolf.h"
#import "GamePig.h"
#import "GameBlock.h"
#import "MyWorld.h"
#import "GestureHandlerProtocol.h"
#import "PERectangleViewController.h"
#import "Aimer.h"
#import "PowerMeter.h"
#import "PECircleViewController.h"
#import "Vector2D.h"
#import "PigPuffInteractionProtocal.h"


#define NO_DATA_STORED         (@"You have no game data stored!")
#define CHOOSE_FILE_TO_LOAD    (@"Choose a file to load")
#define CHOOSE_FILE_TO_DELETE  (@"Choose a file to delete")
#define CALCEL_BUTTON          (@"Cancel")
#define OK_BUTTON              (@"OK")


@interface ViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate,GestureHandlerProtocol,PigPuffInteractionProtocal>

- (IBAction)loadLevels:(id)sender;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *myDeleteButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myLoadButton;


@property (strong, nonatomic) IBOutlet UIScrollView *gamearea;
@property (strong, nonatomic) IBOutlet UIView *palette;

@property MyWorld *simulatedWorld;


@property PERectangleViewController * lowerBound;
@property PERectangleViewController * leftBound;
@property PERectangleViewController * rightBound;

@property BOOL gameStarted;

- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)loadButtonPressed:(id)sender;
- (IBAction)deleteButtonPressed:(id)sender;
- (IBAction)startButtonPressed:(id)sender;

-(void)addRecognizer:(UIView*)view :(UIViewController*)controller;

@end
