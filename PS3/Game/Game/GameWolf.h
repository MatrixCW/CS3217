//
//  GameWolf.h
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameObject.h"

#define WOLFMASS 100

@interface GameWolf : GameObject<UIGestureRecognizerDelegate>

-(void)blow;

@end