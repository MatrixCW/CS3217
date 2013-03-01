//
//  GameWolf.m
//  Game
//
//  Created by Cui Wei on 2/2/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "GameWolf.h"

@interface GameWolf ()

@property (readwrite) CGFloat widthInPalette;
@property (readwrite) CGFloat heightInPalette;
@property (readwrite) CGPoint centerInPalette;

@end

@implementation GameWolf



-(id)init{
    
    
    UIImage* wolfsImage = [UIImage imageNamed:@"wolfs.png"];
    CGImageRef imageRef = CGImageCreateWithImageInRect([wolfsImage CGImage], CGRectMake(0,0,225,150));
    UIImage* singleWolfImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIImageView* wolf = [[UIImageView alloc] initWithImage:singleWolfImage];
    [wolf sizeToFit];
    
    NSLog(@"dada");
    self.widthInPalette = 0.5 * singleWolfImage.size.width;
    self.heightInPalette = 0.5 * singleWolfImage.size.height;
    self.centerInPalette = CGPointMake(50,50);
    
    wolf.frame = CGRectMake(self.centerInPalette.x - self.widthInPalette/2,
                            self.centerInPalette.y - self.heightInPalette/2,
                            self.widthInPalette,
                            self.heightInPalette);
    self.view = wolf;
    self.model = [[PERectangle alloc] initPERectangleWithCenter:self.view.center
                                                          Width:2*self.widthInPalette
                                                         Height:2*self.heightInPalette
                                                        andMass:WOLFMASS];
    self.model.myDelegate = self;
    
    
    self.view.tag = 1;
    
    
    return self;
    
}


-(void)restoreModel{
    
    self.model = [[PERectangle alloc] initPERectangleWithCenter:CGPointMake(50,50)
                                                          Width:2*self.widthInPalette
                                                         Height:2*self.heightInPalette
                                                        andMass:WOLFMASS];

    
}

@end
