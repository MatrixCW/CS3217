//
//  PERectangle.h
//  
//  CS3217 || Assignment 1
//

#import<Foundation/Foundation.h>
#import "Vector2D.h"
#import "ConstantLibrary.h"

 
@interface PERectangle : NSObject

@property (nonatomic) CGFloat rotation;

// rectangle width
@property (nonatomic) CGFloat width;

// rectangle height
@property (nonatomic) CGFloat height;

@property double mass;

@property double momentOfInetia;

@property (strong) NSString* shape;

@property double angularVelocity;

@property Vector2D* velocity;

@property double frictionCoefficient;

@property double restitutionCoefficient;

@property UIView* drawing;

@property (readonly) int identity;

-(id)initPERectangleOrigin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height Mass:(CGFloat)mass andColor:(UIColor*) color;

+(id)getUpperHorizontalBoundRectangle;
+(id)getLowerHorizontalBoundRectangle;
+(id)getLeftVerticalBoundRectangle;
+(id)getRightVerticalBoundRectangle;

@end
