//
//  ConstantLibrary.h
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"

extern CGFloat timeInterval;
extern CGFloat defaultFrictionCoefficient;
extern CGFloat groundFrictionCoefficient;
extern CGFloat defaultRestitutionCoefficient;
extern CGFloat groundRestitutionCoefficient;
extern CGFloat floatComparisonEpsilon;
extern CGFloat gravityScaleValue;
extern CGFloat defaultGravity;
extern CGFloat epsilon;
extern CGFloat kappa;
extern CGFloat eta;
extern CGFloat defaultDensity;
extern int numOfIteration;

@interface ConstantLibrary : NSObject

@end
