//
//  PERectangle.h
//  
//  CS3217 || Assignment 1
//

#import<Foundation/Foundation.h>
#import "Vector2D.h"
#import "Matrix2D.h"
#import "ConstantLibrary.h"
#import "UpdatePositionInViewDelegate.h"
 
@interface PERectangle : NSObject


@property CGPoint origin;
@property CGFloat rotation;
@property CGFloat width;
@property CGFloat height;
@property CGFloat mass;
@property CGFloat momentOfInetia;
@property NSString* shape;
@property CGFloat angularVelocity;
@property CGFloat frictionCoefficient;
@property CGFloat restitutionCoefficient;
@property (readonly) int identity;
@property Vector2D* velocity;
@property (nonatomic) Matrix2D* rotationMatrix;
@property UIColor* rectColor;
@property (weak) id<UpdatePositionInViewDelegate> myDelegate;


-(id)initPERectangleOrigin:(CGPoint)origin Width:(CGFloat)width Height:(CGFloat)height andMass:(CGFloat)mass;

+(id)getUpperHorizontalBoundRectangle;
+(id)getLowerHorizontalBoundRectangle;
+(id)getLeftVerticalBoundRectangle;
+(id)getRightVerticalBoundRectangle;

@end
