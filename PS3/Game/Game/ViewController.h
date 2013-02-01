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


@interface ViewController : UIViewController
//- (IBAction)buttonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *gamearea;

@property (strong, nonatomic) IBOutlet UIView *selectBar;

@property (strong) GameObject *myWolf;

- (void)say;
- (IBAction)buttonPressed:(id)sender;

@end
