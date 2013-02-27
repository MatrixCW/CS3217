//
//  GameStraw.h
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameObject.h"

@interface GameBlock : GameObject<UIGestureRecognizerDelegate>


@property (strong) GameBlock *nextGameBlock;
@property int count;


-(void) moveToTarget:(CGPoint)center withTransform:(CGAffineTransform)transform andTexture:(int)count;

@end
