//
//  MyWorld.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "MyWorld.h"

@implementation MyWorld

-(id)init{
    
    self.objectsInWorld = [[NSMutableArray alloc] init];
    self.gravity = [Vector2D vectorWith:0 y:defaultGravity];
    
    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.delegate = self;
    self.accelerometer.updateInterval = timeInterval;
    
    return self;
}


- (void)run{
    
    
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                               target:self
                                               selector:@selector(simulate:)
                                             userInfo:nil
                                              repeats:YES];
    
    
}



-(void)simulate:(NSTimer*)timer{
    [self applyGravity];
    [self updatePosition];
}


- (void)applyGravity{
    
    for(PERectangle* rect in self.objectsInWorld)
        if(rect.identity)
           rect.velocity = [rect.velocity  add:[self.gravity multiply:timeInterval] ];
    
    
}

-(void)updatePosition{
    
    for (PERectangle* rect in self.objectsInWorld){
        if(rect.identity){
           CGFloat x = rect.origin.x + rect.velocity.x * timeInterval;
           CGFloat y = rect.origin.y + rect.velocity.y * timeInterval;
           rect.origin = CGPointMake(x, y);
           [rect.myDelegate UpdatePosition];
        }
    }
    
}


- (void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)aceler {
    
    
    self.gravity = [Vector2D vectorWith:aceler.x*gravityScaleValue y:-aceler.y*gravityScaleValue];
    
    
}


@end
