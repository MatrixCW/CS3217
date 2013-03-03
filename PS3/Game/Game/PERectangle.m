//
//  PERectangle.m
//
//  CS3217 || Assignment 1
//  Name: <Cui Wei>
//


#import "PERectangle.h"




@implementation PERectangle
// OVERVIEW: This class implements an rectangle object
// used for the view controller as a model

@synthesize rotationMatrix;


-(id)initPERectangleWithCenter:(CGPoint)center Width:(CGFloat)width Height:(CGFloat)height andMass:(CGFloat)mass{
    self = [super init];
    
    if(self){
        
        self.center = center;
        self.width = width;
        self.height = height;
        self.mass = mass;
        self.momentOfInetia = mass * (pow(width,2.0) + pow(height, 2.0))/12;
        self.rotation = 0.0;
        self.velocity = [Vector2D vectorWith:0 y:0];
        self.angularVelocity = 0.0;
        self.frictionCoefficient = defaultFrictionCoefficient;
        self.restitutionCoefficient = defaultRestitutionCoefficient;
        self.identity = 1;
        
    }
    
    return self;
}


-(void)updateMomentOfInertia{
    self.momentOfInetia = self.mass * (pow(self.width,2.0) + pow(self.height, 2.0))/12;
}

-(id)initPECircleWithCenter:(CGPoint)center Width:(CGFloat)width Height:(CGFloat)height andMass:(CGFloat)mass{
    self = [super init];
    
    if(self){
        
        self.center = center;
        self.width = width;
        self.height = height;
        self.mass = mass;
        self.momentOfInetia = M_PI * mass * (pow(width,2.0) + pow(height, 2.0))/48;
        self.rotation = 0.0;
        self.velocity = [Vector2D vectorWith:0 y:0];
        self.angularVelocity = 0.0;
        self.frictionCoefficient = defaultFrictionCoefficient;
        self.restitutionCoefficient = defaultRestitutionCoefficient;
        self.identity = -1;
        
    }
    
    return self;
}

+(id)getUpperHorizontalBoundRectangle{
    
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleWithCenter:CGPointMake(384, -150) Width:768 Height:300 andMass:INFINITY];
    temp.identity = 0;
    temp.frictionCoefficient = groundFrictionCoefficient;
    temp.restitutionCoefficient = groundRestitutionCoefficient;
    return temp;
    
}

+(id)getLowerHorizontalBoundRectangle{
    
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleWithCenter:CGPointMake(1000, 580) Width:3000 Height:200 andMass:INFINITY];
    temp.identity = 0;
    temp.frictionCoefficient = groundFrictionCoefficient;
    temp.restitutionCoefficient = groundRestitutionCoefficient;

    return temp;
    
}

+(id)getLeftVerticalBoundRectangle{
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleWithCenter:CGPointMake(-90, 300) Width:200 Height:1000 andMass:INFINITY];
    temp.identity = 0;
    temp.frictionCoefficient = groundFrictionCoefficient;
    temp.restitutionCoefficient = groundRestitutionCoefficient;

    return temp;
    
}
+(id)getRightVerticalBoundRectangle{
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleWithCenter:CGPointMake(1660, 512) Width:300 Height:1024 andMass:INFINITY];
    temp.identity = 0;
    temp.frictionCoefficient = groundFrictionCoefficient;
    temp.restitutionCoefficient = groundRestitutionCoefficient;

    return temp;
    
}

-(Vector2D*)centerOfRectangle{
    return [Vector2D vectorWith:self.center.x y:-self.center.y];
}

-(Matrix2D*)rotationMatrix{
    return [Matrix2D initRotationMatrix:self.rotation];
}

-(Vector2D*)hVector{
    return [Vector2D vectorWith:self.width/2.0 y:self.height/2.0];
}



@end

