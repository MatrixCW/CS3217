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
    
    self.widthInPalette = 0.4 * singleWolfImage.size.width;
    self.heightInPalette = 0.4 * singleWolfImage.size.height;
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
    
    self.model.myDelegate = self;

    
}

- (void)singleTap:(UITapGestureRecognizer*) recognizer{
    
    if(![self.myDelegate isInGameArea:self.view] || ![self.myDelegate isInMiddleOfGame])
        return;
    
    [self.view removeFromSuperview];
    [self blow];
}



-(void)blow{
    
    
    
    
    UIImage* wolfsImage = [UIImage imageNamed:@"wolfs.png"];
    CGImageRef imageRef;
    UIImage* singleWolfImage;
    CGRect cropRect;
    
    NSMutableArray * animationArray = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 5; j++) {
            cropRect = CGRectMake(0+j*225, 0+i*150, 225,150);
            imageRef = CGImageCreateWithImageInRect([wolfsImage CGImage], cropRect);
            singleWolfImage = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);
            [animationArray addObject:singleWolfImage];
                    }
    }
    
    
    UIImageView *animationView=[[UIImageView alloc]initWithFrame:self.view.frame];
    
    
    animationView.animationImages=animationArray;
    animationView.animationDuration=1;
    animationView.animationRepeatCount=1;
    [animationView startAnimating];
    [self.myDelegate addDirectlyToGameArea:animationView];
    
    [self performSelector:@selector(restoreView) withObject:Nil afterDelay:animationView.animationDuration];
    
    
    
}


-(void)restoreView{
    [self.myDelegate addDirectlyToGameArea:self.view];
}

- (void)rotate:(UIGestureRecognizer *)gesture{
    
}
- (void)zoom:(UIGestureRecognizer *)gesture{
    
}



@end
