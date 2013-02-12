//
//  PERectangle.m
//
//  CS3217 || Assignment 1
//  Name: <Cui Wei>
//

#import "PERectangle.h"

@interface PERectangle()

@property (readwrite) int identity;

@end


@implementation PERectangle
// OVERVIEW: This class implements a rectangle and the associated
//             operations.


-(id)initPERectangleOrigin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height Mass:(CGFloat)mass andColor:(UIColor*) color{
    self = [super init];
    
    if(self){
        
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
        self.drawing = [[UIView alloc] init];
        self.drawing.frame = CGRectMake(origin.x, origin.y, width, height);
        [self.drawing setBackgroundColor:color];
        

    }
    
    return self;
}

+(id)getUpperHorizontalBoundRectangle{
    
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleOrigin:CGPointMake(0, 0) Width:768 Height:2 Mass:INFINITY andColor:[UIColor redColor]];
    temp.identity = 0;
    return temp;
    
}

+(id)getLowerHorizontalBoundRectangle{
    
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleOrigin:CGPointMake(0, 1002) Width:768 Height:2 Mass:INFINITY andColor:[UIColor redColor]];
    temp.identity = 0;
    return temp;
    
}

+(id)getLeftVerticalBoundRectangle{
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleOrigin:CGPointMake(0, 0) Width:2 Height:1024 Mass:INFINITY andColor:[UIColor redColor]];
    temp.identity = 0;
    return temp;
    
}
+(id)getRightVerticalBoundRectangle{
    PERectangle* temp = [PERectangle alloc];
    temp = [temp initPERectangleOrigin:CGPointMake(766, 0) Width:2 Height:1024 Mass:INFINITY andColor:[UIColor redColor]];
    temp.identity = 0;
    return temp;
    
}




@end

