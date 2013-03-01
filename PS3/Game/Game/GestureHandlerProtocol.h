//
//  GestureHandlerProtocol.h
//  Game
//
//  Created by Cui Wei on 3/1/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GestureHandlerProtocol <NSObject>

-(void)disableGamearea;
-(void)enableGamearea;
-(BOOL)shouldAddToGameArea:(UIView*) view;
-(BOOL)notMovedOutOfPalette:(UIView*) view;
-(BOOL)isInPalette:(UIView*) view;
-(void)addToGameArea:(UIView*) view;
-(void)addToPalette:(UIView*) view;
-(void)createNewGameBlock;

@end
