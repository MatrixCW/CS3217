//
//  GamePig.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GamePig.h"

@interface GamePig ()
@property (readwrite) CGFloat widthInPalette;
@property (readwrite) CGFloat heightInPalette;
@property (readwrite) CGPoint centerInPalette;

@end

@implementation GamePig

-(id)init{
    
    
    
    UIImage* pigImg = [UIImage imageNamed:@"pig.png"];
    UIImageView* pigView = [[UIImageView alloc]initWithImage:pigImg];
    
    self.widthInPalette =  pigImg.size.width;
    self.heightInPalette =  pigImg.size.height;
    self.centerInPalette = CGPointMake(150,50);
    
        
    pigView.frame = CGRectMake(self.centerInPalette.x - self.widthInPalette/2,
                               self.centerInPalette.y - self.heightInPalette/2,
                               self.widthInPalette,
                               self.heightInPalette);
    self.view = pigView;
    self.model = [[PERectangle alloc] initPERectangleWithCenter:self.view.center
                                                          Width:2*self.widthInPalette
                                                         Height:2*self.heightInPalette
                                                        andMass:100];
    
    return self;
}



@end
