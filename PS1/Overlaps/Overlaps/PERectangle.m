//
//  PERectangle.m
//  
//  CS3217 || Assignment 1
//  Name: <Cui Wei>
//

#import "PERectangle.h"

#define floatComparisonEpsilon 0.00000000001  //used for floating point comparison

@interface PERectangle ()
//re-declare properties so they can be modified inside implementation

@property (nonatomic,readwrite) CGFloat width;
@property (nonatomic,readwrite) CGFloat height;
@property (nonatomic,readwrite) CGPoint* corners;

@end


@implementation PERectangle
// OVERVIEW: This class implements a rectangle and the associated
//             operations.

@synthesize rotation = _rotation, center = _center, origin = _origin;


-(void) setRotation:(CGFloat)degree{
    
    [self rotate:degree];
    
}

- (CGPoint)center {
  // EFFECTS: returns the coordinates of the centre of mass for this
  // rectangle.
    
    CGFloat x = _origin.x + _width/2;
    CGFloat y = _origin.y - _height/2;
    
    return CGPointMake(x, y);
    

}

- (CGPoint)cornerFrom:(CornerType)corner {
  // REQUIRES: corner is a enum constant defined in PEShape.h as follows:
  //           kTopLeftCorner, kTopRightCorner, kBottomLeftCorner,
  //		   kBottomRightCorner 
  // EFFECTS: returns the coordinates of the specified rotated rectangle corner after rotating
    
    CGFloat radianAngle = [self convertDegreeToRadian:self.rotation];
    
    CGPoint centerPoint = [self center];
    
    //printf("xixixixixix %f  %f", centerPoint.x, centerPoint.y);
     //printf("dddd %f  %f", _width, _height);
    
    
    CGFloat rotationMatrix[2][2] = {cos(radianAngle), -sin(radianAngle), sin(radianAngle), cos(radianAngle)};
    

    CGPoint topLeft = CGPointMake(centerPoint.x - _width / 2, centerPoint.y + _height/2);
    CGPoint topRight = CGPointMake(centerPoint.x + _width / 2, centerPoint.y + _height/2);
    CGPoint bottomLeft = CGPointMake(centerPoint.x - _width / 2, centerPoint.y - _height/2);
    CGPoint bottomRight = CGPointMake(centerPoint.x + _width / 2, centerPoint.y - _height/2);
    
    
    //printf("dddd %f %f", bottomRight.x, bottomRight.y);
    
    CGPoint returnPoint;
    CGFloat x = topLeft.x - centerPoint.x;
    CGFloat y = topLeft.y - centerPoint.y;
    
    switch (corner) {
        
        case kTopLeftCorner:
            
            x = topLeft.x - centerPoint.x;
            y = topLeft.y - centerPoint.y;
            
            returnPoint = CGPointMake(rotationMatrix[0][0] * x + rotationMatrix[0][1] * y + centerPoint.x,
                                      rotationMatrix[1][0] * x + rotationMatrix[1][1] * y + centerPoint.y);
            
            break;
            
        
        case kTopRightCorner:
            
            x = topRight.x - centerPoint.x;
            y = topRight.y - centerPoint.y;
            
            returnPoint = CGPointMake(rotationMatrix[0][0] * x + rotationMatrix[0][1] * y + centerPoint.x,
                                      rotationMatrix[1][0] * x + rotationMatrix[1][1] * y + centerPoint.y);
            
            break;

        
        case kBottomLeftCorner:
            
            x = bottomLeft.x - centerPoint.x;
            y = bottomLeft.y - centerPoint.y;
            
            returnPoint = CGPointMake(rotationMatrix[0][0] * x + rotationMatrix[0][1] * y + centerPoint.x,
                                      rotationMatrix[1][0] * x + rotationMatrix[1][1] * y + centerPoint.y);
            
            break;

        
        case kBottomRightCorner:
            
            x = bottomRight.x - centerPoint.x;
            y = bottomRight.y - centerPoint.y;
            
            returnPoint = CGPointMake(rotationMatrix[0][0] * x + rotationMatrix[0][1] * y + centerPoint.x,
                                      rotationMatrix[1][0] * x + rotationMatrix[1][1] * y + centerPoint.y);
            
            break;

            
        default:
            
            break;
            
    }


    return returnPoint;

}


- (CGPoint*)corners {
  // EFFECTS:  return an array with all the rectangle corners

  CGPoint *corners = (CGPoint*) malloc(4*sizeof(CGPoint));
  
  corners[0] = [self cornerFrom: kTopLeftCorner];
  corners[1] = [self cornerFrom: kTopRightCorner];
  corners[2] = [self cornerFrom: kBottomRightCorner];
  corners[3] = [self cornerFrom: kBottomLeftCorner];
  
  return corners;
    
}


- (id)initWithOrigin:(CGPoint)o width:(CGFloat)w height:(CGFloat)h rotation:(CGFloat)r{
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle with origin, width,
  //          height, and rotation angle in degrees
    
    self=[super init];
    
    if(self){
        
        self.origin = o;
        self.width = w;
        self.height = h;
        
        [self rotate:r];
        
    }
    
    return self;

}


- (id)initWithRect:(CGRect)rect {
  // MODIFIES: self
  // EFFECTS: initializes the state of this rectangle using a CGRect
    
    CGPoint o = rect.origin;
    CGFloat h = rect.size.height;
    CGFloat w = rect.size.width;
    CGFloat r = 0.0;
    
    return [self initWithOrigin:o width:w height:h rotation:r];

}


- (void)rotate:(CGFloat)angle {
  // MODIFIES: self
  // EFFECTS: rotates this shape anti-clockwise by the specified angle
  // around the center of mass
    
    _rotation = _rotation + angle;

}


- (void)translateX:(CGFloat)dx Y:(CGFloat)dy {
  // MODIFIES: self
  // EFFECTS: translates this shape by the specified dx (along the
  //            X-axis) and dy coordinates (along the Y-axis)
    
    CGPoint temp = CGPointMake(self.origin.x + dx, self.origin.y+dy);
    
    self.origin = temp;
    
    
}


- (BOOL)overlapsWithShape:(id<PEShape>)shape {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  
  if ([shape class] == [PERectangle class]) {
    return [self overlapsWithRect:(PERectangle *)shape];
  }

  return NO;
}


- (BOOL)overlapsWithRect:(PERectangle*)rect {
  // EFFECTS: returns YES if this shape overlaps with specified shape.
  // <add missing code here>
    
    CGPoint *rec1 = [self corners];
    CGPoint *rec2 = [rect corners];
    
    
    
    for(int i = 0;i < 4;i++){
        
    
        
        if([self isSameSideRectLinePointOne:rec1[i] LinePointTwo:rec1[(i + 1) % 4] Rectangle:rec2]   &&
           ![self isSameSideLinePointOne:rec1[i] LinePointTwo:rec1[(i + 1) % 4] testPointOne:rec1[(i + 2) % 4] testPointFour:rec2[0]]){
            
            
            
            for(int j = 0; j < 4;j++)
                if([self pointOnSegment:rec1[i] :rec1[(i + 1) % 4] :rec2[j]])
                  return YES;
        
        return NO;
        
        }
        
    }
    
    
    
    for(int i = 0;i < 4;i++){
        
        if([self isSameSideRectLinePointOne:rec2[i] LinePointTwo:rec2[(i + 1) % 4] Rectangle:rec1]   &&
           ![self isSameSideLinePointOne:rec2[i] LinePointTwo:rec2[(i + 1) % 4] testPointOne:rec2[(i+2)%4] testPointFour:rec1[0]]){
            
            for(int j=0; j < 4;j++)
                if([self pointOnSegment:rec2[i] :rec2[(i + 1) % 4] :rec1[j]])
                   return YES;
        
        return NO;
        
        }
        
    }
    
    
    return YES;
    
}
 


- (CGRect)boundingBox {
  // EFFECTS: returns the bounding box of this shape.

  // optional implementation (not graded)
    
    
    CGPoint *corners = [self corners];
    CGPoint corner1 = corners[0];
    CGPoint corner2 = corners[1];
    CGPoint corner3 = corners[2];
    CGPoint corner4 = corners[3];
    
    CGFloat x1 = fmax(corner1.x, corner2.x);
    CGFloat x2 = fmax(corner3.x, corner4.x);
    CGFloat xMax = fmax(x1, x2);
    
    CGFloat x3 = fmin(corner1.x, corner2.x);
    CGFloat x4 = fmin(corner3.x, corner4.x);
    CGFloat xMin = fmin(x3, x4);
    
    CGFloat y1 = fmax(corner1.y, corner2.y);
    CGFloat y2 = fmax(corner3.y, corner4.y);
    CGFloat yMax = fmax(y1, y2);
    
    CGFloat y3 = fmin(corner1.y, corner2.y);
    CGFloat y4 = fmin(corner3.y, corner4.y);
    CGFloat yMin = fmin(y3, y4);
    
    CGFloat width = xMax - xMin;
    CGFloat height = yMax - yMin;
    
    
    return CGRectMake(xMin, yMax, width, height);
}


- (CGFloat) convertDegreeToRadian:(CGFloat)d{
    
    return (d / 180) * M_PI;

}



//this method tests if points p3 and p4 are on the same side of the line formed by p1 and p2
- (BOOL) isSameSideLinePointOne: (CGPoint)p1  LinePointTwo :(CGPoint)p2
                    testPointOne : (CGPoint)p3  testPointFour:(CGPoint)p4{
    
    
    assert(p1.x != p2.x || p1.y != p2.y);
    
    
    
    if(fabs(p1.x - p2.x) < floatComparisonEpsilon){
        
        if( ( [self lessThanOrEqualToValueOne:p3.x ValueTwo:p1.x] && [self lessThanOrEqualToValueOne:p4.x ValueTwo:p1.x]) ||
            ( [self lessThanOrEqualToValueOne:p1.x ValueTwo:p3.x] && [self lessThanOrEqualToValueOne:p1.x ValueTwo:p4.x])
          )
            
            return YES;
        
        else
            
            return NO;
    }
    
    
    
    if(fabs(p1.y - p2.y) < floatComparisonEpsilon){
        
        
        
        if( ( [self lessThanOrEqualToValueOne:p3.y ValueTwo:p1.y] && [self lessThanOrEqualToValueOne:p4.y ValueTwo:p1.y]) ||
            ( [self lessThanOrEqualToValueOne:p1.y ValueTwo:p3.y] && [self lessThanOrEqualToValueOne:p1.y ValueTwo:p4.y])
          )

            return YES;
        
        else
            
            return NO;
    }
    
    
    //else, this line is not parallel to any axis
    //so the equation for this line is y=(y2-y1)/(x2-x1) * (x - x1) +y1
    
    
    CGFloat p3OnLine = ( (p2.y - p1.y) / (p2.x - p1.x) ) * (p3.x - p1.x) + p1.x ;
    
    CGFloat p4OnLine = ( (p2.y - p1.y) / (p2.x - p1.x) ) * (p4.x - p1.x) + p1.x ;
    
    
    if(   ([self lessThanOrEqualToValueOne:p3.y ValueTwo:p3OnLine]  &&
           [self lessThanOrEqualToValueOne:p4.y ValueTwo:p4OnLine]) ||
          ([self lessThanOrEqualToValueOne:p4OnLine ValueTwo:p4.y]  &&
           [self lessThanOrEqualToValueOne:p3OnLine ValueTwo:p3.y])
       )
    
    return
        YES;
    else
        return NO;
    
}


//this method test if the four points are all on the same side with regards to the line formed by points p1 and p2
- (BOOL) isSameSideRectLinePointOne:(CGPoint)p1 LinePointTwo:(CGPoint)p2 Rectangle:(CGPoint *)rect{
    
    for(int i = 0; i < 4; i++){
        
        if(! [self isSameSideLinePointOne:p1 LinePointTwo:p2 testPointOne:rect[i] testPointFour:rect[(i + 1) % 4] ])
            
            return NO;
            }
              
    return YES;

                
}


//for floating-point number comparison
-(BOOL) lessThanOrEqualToValueOne:(CGFloat)x ValueTwo:(CGFloat) y{
    
    
    
    if(fabs(x - y) < floatComparisonEpsilon){
        return YES;
    }
    
    if(x < y){
        return YES;
    }
    
    return NO;
    
}


//this method tests if p3 is on the line formed by p1 and p2
- (BOOL) pointOnSegment:(CGPoint)p1 :(CGPoint)p2 :(CGPoint)p3{
    
    if(fabs(p1.x - p2.x) < floatComparisonEpsilon){
        if(fabs(p3.x - p1.x) < floatComparisonEpsilon)
                return YES;
    }
    
    if(fabs(p1.y - p2.y) < floatComparisonEpsilon){
        if(fabs(p3.y - p1.y) < floatComparisonEpsilon)
                return YES;
    }
    
    CGFloat p3OnLine = ( (p2.y - p1.y) / (p2.x - p1.x) ) * (p3.x - p1.x) + p1.x ;
    
    
    if(fabs(p3OnLine - p3.y) < floatComparisonEpsilon)
        return YES;
    
    
    return NO;
}

@end

