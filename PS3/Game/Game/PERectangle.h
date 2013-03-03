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
// OVERVIEW: This class implements an rectangle object
// used for the view controller as a model



@property CGPoint center;
@property CGFloat width;
@property CGFloat height;
@property CGFloat mass;
@property CGFloat momentOfInetia;
@property CGFloat frictionCoefficient;
@property CGFloat restitutionCoefficient;
@property CGFloat rotation;
@property CGFloat angularVelocity;

@property int identity;

@property Vector2D* velocity;
@property (nonatomic) Matrix2D* rotationMatrix;

@property (nonatomic) Vector2D* hVector;



@property (weak) id<UpdatePositionInViewDelegate> myDelegate;


-(id)initPERectangleWithCenter:(CGPoint)center Width:(CGFloat)width Height:(CGFloat)height andMass:(CGFloat)mass;
-(id)initPECircleWithCenter:(CGPoint)center Width:(CGFloat)width Height:(CGFloat)height andMass:(CGFloat)mass;
-(void)updateMomentOfInertia;

-(Vector2D*)centerOfRectangle;


+(id)getUpperHorizontalBoundRectangle;
+(id)getLowerHorizontalBoundRectangle;
+(id)getLeftVerticalBoundRectangle;
+(id)getRightVerticalBoundRectangle;

@end
