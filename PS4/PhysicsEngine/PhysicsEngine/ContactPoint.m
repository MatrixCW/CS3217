//
//  ContactPoint.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/16/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ContactPoint.h"

@implementation ContactPoint



-(id)initWithRectA:(PERectangle*)rectA RectB:(PERectangle*)rectB Normal:(Vector2D*)n Separation:(CGFloat)s Position:(Vector2D*)c{
    
    self = [super init];
    
    if(self){
        
        self.c = c;
        self.rectA = rectA;
        self.rectB = rectB;
        self.n = n;
        self.separation = s;
        self.t = [n crossZ:1.0];
        
    }
    return self;

}


@end
