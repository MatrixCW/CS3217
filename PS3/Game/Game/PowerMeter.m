//
//  PowerMeter.m
//  Game
//
//  Created by Cui Wei on 3/3/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "PowerMeter.h"

@interface PowerMeter ()

@property int counter;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation PowerMeter

-(id)initWithPosition:(CGPoint)center{
    
    
    
    UIImage* breadthBar = [UIImage imageNamed:@"breath-bar.png"];
    UIImageView* breadthBarView = [[UIImageView alloc]initWithImage:breadthBar];
    
    breadthBarView.frame =  CGRectMake(center.x+25,
                                           157,
                                           breadthBar.size.width ,
                                           breadthBar.size.height);
    
    
    
    
    self.view = breadthBarView;
    
    [self addRecognizer:self.view];
    
    return self;
    
}

-(void)addRecognizer:(UIView*)view{
    
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(calculatePower:)];
    longPress.minimumPressDuration = 0;
    [view addGestureRecognizer:longPress];
    view.userInteractionEnabled = YES;
   
    
}



- (void)incrementCounter {
    self.counter++;
    if(self.counter == 20)
        self.counter = self.counter % 20;
    [self drawPowerMeter];
}


- (void)calculatePower:(UILongPressGestureRecognizer*) gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.counter = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(incrementCounter)
                                                    userInfo:nil repeats:YES];
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [self.timer invalidate];
        [self clean];
        [self.myDelegate firePuff:self.counter];
    }
    
    
}


-(void)drawPowerMeter{
    
    [self clean];
    CGFloat width = self.view.bounds.size.width * 0.7;
    CGFloat height = self.view.bounds.size.height * self.counter / 20;
    NSLog(@"xixixixix %lf ",self.view.bounds.size.height-height/2);
    UIView* power = [[UIView alloc] initWithFrame:CGRectMake(width/2 - 3,
                                                             self.view.bounds.size.height-height - 4,
                                                             width,
                                                             height)];
    
    power.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:power];
    
}

-(void)clean{
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


@end
