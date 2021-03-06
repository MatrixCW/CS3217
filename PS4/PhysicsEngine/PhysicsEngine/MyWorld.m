//
//  MyWorld.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "MyWorld.h"

@implementation MyWorld
// OVERVIEW: This class implements an simulated world
// where all the object models are added and the interaction simulated

-(id)init{
    
    self.objectsInWorld = [[NSMutableArray alloc] init];
    self.gravity = [Vector2D vectorWith:0 y:defaultGravity];
    
    self.accelerometer = [UIAccelerometer sharedAccelerometer];
    self.accelerometer.delegate = self;
    self.accelerometer.updateInterval = timeInterval;
    
    self.conllisionDetector = [[CollisionDetector alloc] initCoiisionDetector];
    
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
    [self analyzeDetection];
    [self updatePosition];
}


- (void)applyGravity{
    
    for(PERectangle* rect in self.objectsInWorld)
        if(rect.identity)
           rect.velocity = [rect.velocity  add:[self.gravity multiply:timeInterval] ];
    
    
}

-(void)updatePosition{
    
    for (PERectangle* rect in self.objectsInWorld){
        if(rect.identity != 0){
           CGFloat x = rect.center.x + rect.velocity.x * timeInterval;
           CGFloat y = rect.center.y + rect.velocity.y * timeInterval;
           rect.center = CGPointMake(x, y);
            
           rect.rotation += rect.angularVelocity * timeInterval;
                   
            [rect.myDelegate UpdatePosition];
        }
    }
    
}


-(void)analyzeDetection{
    
    
    for(int i = 0; i < self.objectsInWorld.count; i++)
        for(int j = i + 1; j < self.objectsInWorld.count; j++){
            
            PERectangle* rectA = [self.objectsInWorld objectAtIndex:i];
            PERectangle* rectB = [self.objectsInWorld objectAtIndex:j];
            
            [self.conllisionDetector detectCollisionBetweenRectA:rectA andRectB:rectB];
            
    }
    
    
    if(self.conllisionDetector.contactPoints.count)
        for(int i = 0; i < numOfIteration ; i++)
           [self.conllisionDetector applyImpulse];
    
    [self.conllisionDetector.contactPoints removeAllObjects];
    
}

- (void)accelerometer:(UIAccelerometer *)acel didAccelerate:(UIAcceleration *)aceler {
    
    
    self.gravity = [Vector2D vectorWith:aceler.x*gravityScaleValue y:-aceler.y*gravityScaleValue];
    
    
}


@end
