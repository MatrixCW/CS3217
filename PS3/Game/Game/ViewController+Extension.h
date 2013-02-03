//
//  ViewController+Extension.h
//  Game
//
//  Created by Cui Wei on 1/31/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (Extension)


- (void)save;
// REQUIRES: game in designer mode
// EFFECTS: game objects are saved

- (void)load;
// MODIFIES: self (game objects)
// REQUIRES: game in designer mode
// EFFECTS: game objects are loaded

- (void)reset;
// MODIFIES: self (game objects)
// REQUIRES: game in designer mode
// EFFECTS: current game objects are deleted and palette contains all objects

@end
