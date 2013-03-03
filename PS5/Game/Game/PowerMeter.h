//
//  PowerMeter.h
//  Game
//
//  Created by Cui Wei on 3/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureHandlerProtocol.h"
@interface PowerMeter : UIViewController

-(id)initWithPosition:(CGPoint)center;


@property (weak) id<GestureHandlerProtocol> myDelegate;

@end
