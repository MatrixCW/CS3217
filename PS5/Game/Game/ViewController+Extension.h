//
//  ViewController+Extension.h
//  Game
//
//  Created by Cui Wei on 1/31/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
#import "GameObject.h"
#import "Aimer.h"
#import "PowerMeter.h"


@interface ViewController (Extension)


- (void)save;
// REQUIRES: game in designer mode
// EFFECTS: game objects are saved

- (void)loadWithName:(NSString*)loadName;
// MODIFIES: self (game objects)
// REQUIRES: game in designer mode
// EFFECTS: game objects are loaded

- (void)reset;
// MODIFIES: self (game objects)
// REQUIRES: game in designer mode
// EFFECTS: current game objects are deleted and palette contains all objects

-(void) deleteFileWithName:(NSString*)fileName;
// MODIFIES: game data stored in document directory
// REQUIRES: fileName not null and not equals @""
// EFFECTS: delete the file with the specified name

-(NSArray*)getAllFilesUnderGameDirectory;
//EFFECTS: return an array of strings of the fileNames under the document directory

-(GameWolf*)getGameWolfViewController;

-(GamePig*)getGamePigViewController;

-(Aimer*)getAimerViewController;

-(PowerMeter*)getPowerMeterViewController;

-(PECircleViewController*)getPuffViewController;

-(void)loadDefaultLevel:(NSString*)fileName;

@end
