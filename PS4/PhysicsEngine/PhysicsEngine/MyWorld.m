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
    UIAccelerometer* accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = timeInterval;
    
    return self;
}


- (void)run{
    
    _timer =  [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                               target:self
                                             selector:@selector(simulate)
                                             userInfo:nil
               
                                              repeats:YES];
    
    
}



-(void)simulate{
    [self applyGravity];
    [self updatePosition];
}


- (void)applyGravity{
    
    
    for (PERectangle* rect in self.objectsInWorld) {
        if(rect.identity)
          rect.velocity = [rect.velocity  add:[self.gravity multiply:timeInterval] ];
        
    }
    
}

-(void)updatePosition{
    
    for (PERectangle* rect in self.objectsInWorld){
        if(rect.identity){
           CGFloat x = rect.drawing.center.x + rect.velocity.x * timeInterval;
           CGFloat y = rect.drawing.center.y + rect.velocity.y * timeInterval;
           rect.drawing.center = CGPointMake(x, y);
           [self.updateViewDelegate UpdatePosition];
        }
    }
    
}


- (void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)aceler {
    
    
    self.gravity = [Vector2D vectorWith:aceler.x*gravityScaleValue y:-aceler.y*gravityScaleValue];
    
}

@end
