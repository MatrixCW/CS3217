//
//  Aimer.h
//  Game
//
//  Created by Cui Wei on 3/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vector2D.h"

@interface Aimer : UIViewController

-(id)initWithPosition:(CGPoint)center;

-(Vector2D*)direction;

@end
