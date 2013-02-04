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


@interface ViewController : UIViewController<UIAlertViewDelegate>
//- (IBAction)buttonPressed:(id)sender;

@property (strong) GameWolf *myWolf;
@property (strong) GamePig *myPig;
@property (strong) GameBlock *myCurrentBlock;
@property (strong) GameBlock *myRootBlock;


@property (strong, nonatomic) IBOutlet UIScrollView *gamearea;
@property (strong, nonatomic) IBOutlet UIView *selectBar;



- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)loadButtonPressed:(id)sender;
- (IBAction)browseButtonPressed:(id)sender;


@end
