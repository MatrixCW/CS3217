//
//  CollisionDetector.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/14/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "CollisionDetector.h"

@implementation CollisionDetector
// OVERVIEW: This class implements an collision detecter
// that can determine if two moving objects are colliding or not
// and it they do collide, find the colliding points
// it will keep track of all the colliding points and then laster
// apply impulse to the cossiding bodies

-(id)initCoiisionDetector{
    
    self.contactPoints = [NSMutableArray array];
    
    return self;
}


-(void)detectCollisionBetweenRectA:(PERectangle*) rectA andRectB:(PERectangle*) rectB{
    
    if(!rectA.identity && !rectB.identity)
        return;
   
    
    self.rectA = rectA;
    self.rectB = rectB;
    
    Vector2D* hA = [self.rectA hVector];
    Vector2D* hB = [self.rectB hVector];
    
    Vector2D* pA = [self.rectA centerOfRectangle];
    Vector2D* pB = [self.rectB centerOfRectangle];
    Vector2D* d = [pB subtract:pA];
   
    Matrix2D* RA = [self.rectA rotationMatrix];
    Matrix2D* RB = [self.rectB rotationMatrix];
    
        
    Vector2D* dA = [[RA transpose] multiplyVector:d];
    Vector2D* dB = [[RB transpose] multiplyVector:d];
    
    Matrix2D* C = [[RA transpose] multiply:RB];
    Matrix2D* CT = [C transpose];
    
    
    Vector2D* fA = [[[dA abs] subtract:hA] subtract:[[C abs] multiplyVector:hB]];
    Vector2D* fB = [[[dB abs] subtract:hB] subtract:[[CT abs] multiplyVector:hA]];
    
    
    CGFloat fax = fA.x;
    CGFloat fay = fA.y;
    CGFloat fbx = fB.x;
    CGFloat fby = fB.y;
    
    if(!(fax < 0 && fay < 0 && fbx< 0 && fby < 0)) //rectangles not colliding
        return;
    
    CGFloat deltaax = fA.x - kappa * (hA.x);
    CGFloat deltaay = fA.y - kappa * (hA.y);
    CGFloat deltabx = fB.x - kappa * (hB.x);
    CGFloat deltaby = fB.y - kappa * (hB.y);
    
    CGFloat array[4] = {deltaax, deltaay, deltabx, deltaby};
    
    BOOL hasBeenSet = NO;
    int  flag = -1;
    
    if([self isLargetRegardingEtaIndex:0 theArray:array]){
        flag = 1;
        hasBeenSet = YES;
    }
    else if([self isLargetRegardingEtaIndex:1 theArray:array]){
        flag = 2;
        hasBeenSet = YES;
    }
    else if([self isLargetRegardingEtaIndex:2 theArray:array]){
        flag = 3;
        hasBeenSet = YES;
    }
    else if([self isLargetRegardingEtaIndex:3 theArray:array]){
        flag = 4;
        hasBeenSet = YES;
    }
    
    
    if(!hasBeenSet){
        
        if([self testValue:fax isLargerThan:fay and:fbx and:fby]){
            flag = 1;
            hasBeenSet = YES;
        }
        else if([self testValue:fay isLargerThan:fax and:fbx and:fby]){
            flag = 2;
            hasBeenSet = YES;
        }else if([self testValue:fbx isLargerThan:fax and:fay and:fby]){
            flag = 3;
            hasBeenSet = YES;
        }else{
            assert([self testValue:fby isLargerThan:fax and:fay and:fbx]);
            flag = 4;
            hasBeenSet = YES;
        }

    }
    

    Vector2D* n;
    Vector2D* nf;

    Vector2D* ns; 
    CGFloat Df;
    CGFloat Ds;
    CGFloat Dneg;
    CGFloat Dpos;
    
    switch (flag) {
        case 1:
            if(dA.x > 0){
                n = RA.col1;
            }
            else{
                n = [RA.col1 negate];
            }
            
            nf = n;
            ns = RA.col2;
            Df = [pA dot:nf] + hA.x;
            Ds = [pA dot:ns];
            Dneg = hA.y - Ds;
            Dpos = hA.y + Ds;
            break;
        case 2:
            if(dA.y > 0){
                n = RA.col2;
                
            }
            else{
                n = [RA.col2 negate];
                
            }
            
            nf = n;
            ns = RA.col1;
            Df = [pA dot:nf] + hA.y;
            Ds = [pA dot:ns];
            Dneg = hA.x - Ds;
            Dpos = hA.x + Ds;
            break;
        case 3:
            if(dB.x > 0){
                n = RB.col1;
            }
            else{
                n = [RB.col1 negate];
            }
            
            nf = [n negate];
            ns = RB.col2;
            Df = [pB dot:nf] + hB.x;
            Ds = [pB dot:ns];
            Dneg = hB.y - Ds;
            Dpos = hB.y + Ds;
            break;
        case 4:
            if(dB.y > 0){
                n = RB.col2;
            }
            else{
                n = [RB.col2 negate];
            }
            
            nf = [n negate];
            ns = RB.col1;
            Df = [pB dot:nf] + hB.y;
            Ds = [pB dot:ns];
            Dneg = hB.x - Ds;
            Dpos = hB.x + Ds;
            break;
            
        default:
            break;
    }
    
    
    Vector2D* ni;
    Vector2D* p;
    Matrix2D* R;
    Vector2D* h;
   
    if(flag == 1 || flag == 2){
        ni = [[[RB transpose] multiplyVector:nf] negate];
        p = pB;
        R = RB;
        h = hB;
    }
    else{
        ni = [[[RA transpose] multiplyVector:nf] negate];
        p = pA;
        R = RA;
        h = hA;
    }
    
    Vector2D* niAbs = [ni abs];
    Vector2D* v1;
    Vector2D* v2;
    
    if(niAbs.x > niAbs.y && ni.x > 0){
            v1 = [p add:[R multiplyVector:[Vector2D vectorWith:h.x y:-h.y]]];
            v2 = [p add:[R multiplyVector:[Vector2D vectorWith:h.x y:h.y]]];
        
    }else if(niAbs.x > niAbs.y && ni.x <= 0){
            v1 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:h.y]]];
            v2 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:-h.y]]];
            
    }else if(niAbs.x <= niAbs.y && ni.y > 0){
            v1 = [p add:[R multiplyVector:[Vector2D vectorWith:h.x y:h.y]]];
            v2 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:h.y]]];
        
    }else{
            assert(niAbs.x <= niAbs.y && ni.y <= 0);
            v1 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:-h.y]]];
            v2 = [p add:[R multiplyVector:[Vector2D vectorWith: h.x y:-h.y]]];
    }
    
    Vector2D* v1Prime;
    Vector2D* v2Prime;
    
    CGFloat dist1 = -[ns dot:v1] - Dneg;
    CGFloat dist2 = -[ns dot:v2] - Dneg;
    
    if(dist1 > 0 && dist2 > 0) //rectangles not colliding
           return;
    
    
    
    
    if(dist1 < 0 && dist2 < 0){
        v1Prime = v1;
        v2Prime = v2;
    }else if(dist1 < 0 && dist2 > 0){
            v1Prime = v1;
            v2Prime = [[[v2 subtract:v1] multiply:dist1/(dist1-dist2)] add:v1];
    }else if(dist1 > 0 && dist2 < 0){
            
            v1Prime = v2;
            v2Prime = [[[v2 subtract:v1] multiply:dist1/(dist1-dist2)] add:v1];
    }else return;
    
    dist1 = [ns dot:v1Prime] - Dpos;
    dist2 = [ns dot:v2Prime] - Dpos;
    
    Vector2D* v1DoublePrime;
    Vector2D* v2DoublePrime;
    
    if(dist1 > 0 && dist2 > 0) //rectangles not colliding
           return;
       
    if(dist1 < 0 && dist2 < 0){
        v1DoublePrime = v1Prime;
        v2DoublePrime = v2Prime;
    }else if(dist1 < 0 && dist2 > 0){
            v1DoublePrime = v1Prime;
            v2DoublePrime = [[[v2Prime subtract:v1Prime] multiply:dist1/(dist1-dist2)] add:v1Prime];
    }else if(dist1 > 0 && dist2 < 0){
            v1DoublePrime = v2Prime;
            v2DoublePrime = [[[v2Prime subtract:v1Prime] multiply:dist1/(dist1-dist2)] add:v1Prime];

    }else return;
    
    
    if([self isSameVectorVectorA:v1DoublePrime VectorB:v2DoublePrime]) // not colliding
            return;
    
    
    CGFloat seperationC1 = [nf dot:v1DoublePrime] - Df;
    Vector2D* c1 = [v1DoublePrime subtract:[nf multiply:seperationC1]];
    
    CGFloat seperationC2 = [nf dot:v2DoublePrime] - Df;
    Vector2D* c2 = [v2DoublePrime subtract:[nf multiply:seperationC2]];
    
    

    if(seperationC1 < 0 ){
        
        ContactPoint* point = [[ContactPoint alloc] initWithRectA:self.rectA
                                                            RectB:self.rectB
                                                            Normal:n
                                                            Separation:seperationC1
                                                            Position:c1];
        
        [self.contactPoints addObject:point];
        
    }
    
    if(seperationC2 < 0 ){
        
        ContactPoint* point = [[ContactPoint alloc] initWithRectA:self.rectA
                                                            RectB:self.rectB
                                                           Normal:n
                                                       Separation:seperationC2
                                                         Position:c2];
        [self.contactPoints addObject:point];
        
    }
    
    
    
}


-(void)applyImpulse{
    
     
   
    
    for(ContactPoint* point in self.contactPoints){
       
        PERectangle* rectA = point.rectA;
        PERectangle* rectB = point.rectB;
        
        Vector2D* c = point.c;
        Vector2D* pA = [rectA centerOfRectangle];
        Vector2D* pB = [rectB centerOfRectangle];
        
        Vector2D* rA = [c subtract:pA];
        Vector2D* rB = [c subtract:pB];
        
        Vector2D* uA = [[rectA.velocity negateJustY] add:[[rA crossZ:rectA.angularVelocity] negate]];
        Vector2D* uB = [[rectB.velocity negateJustY] add:[[rB crossZ:rectB.angularVelocity] negate]];
        
        Vector2D* u = [uB subtract:uA];
        
        CGFloat un = [u dot:point.n];
        CGFloat ut = [u dot:point.t];
        
        
        CGFloat mn = 1.0/rectA.mass + 1.0/rectB.mass
                     + ([rA dot:rA] - pow([rA dot:point.n], 2.0))/rectA.momentOfInetia
                     + ([rB dot:rB] - pow([rB dot:point.n], 2.0))/rectB.momentOfInetia;
        mn = 1.0/mn;
        
        
        CGFloat mt = 1.0/rectA.mass + 1.0/rectB.mass
                     + ([rA dot:rA] - pow([rA dot:point.t], 2.0))/rectA.momentOfInetia
                     + ([rB dot:rB] - pow([rB dot:point.t], 2.0))/rectB.momentOfInetia;
        mt = 1.0/mt;
        
        
        CGFloat e = sqrt(rectA.restitutionCoefficient * rectB.restitutionCoefficient);
        
        
        CGFloat bias = 0.0;
        if(fabs(point.separation) > kappa)
            bias = fabs((kappa + point.separation) * epsilon / timeInterval);
            
        
        Vector2D* Pn = [point.n multiply:(fmin(mn*(1.0+e)*un - bias,0.0))];
        
       
        CGFloat dPt = mt * ut;
        CGFloat Ptmax = rectA.frictionCoefficient * rectB.frictionCoefficient * [Pn length];
        dPt = fmax(fmin( Ptmax,dPt), -Ptmax);
        
        Vector2D* Pt = [point.t multiply:dPt];
               
        
        if(rectA.identity){
           
           rectA.velocity = [[rectA.velocity negateJustY] add:[[Pn add:Pt] multiply:(1.0/rectA.mass)]];
           rectA.velocity = [rectA.velocity negateJustY];
           rectA.angularVelocity = rectA.angularVelocity + [rA cross:[Pn add:Pt]]/rectA.momentOfInetia;
            
        }
        
        
        if(rectB.identity){
            
           rectB.velocity = [[rectB.velocity negateJustY] subtract:[[Pn add:Pt] multiply:(1.0/rectB.mass)]];
           rectB.velocity = [rectB.velocity negateJustY];
           rectB.angularVelocity = rectB.angularVelocity - [rB cross:[Pn add:Pt]]/rectB.momentOfInetia ;
                      
        }
       
           
    }
    
    
}


-(BOOL)testValue:(CGFloat)valueA isLargerThan:(CGFloat)valueB and:(CGFloat)valueC and:(CGFloat)valueD{
    return (valueA >= valueB && valueA >= valueC && valueA >= valueD);
}



-(BOOL)isLargetRegardingEtaIndex:(int)index theArray:(CGFloat*) array{
    
    for(int i = 0 ; i < 4; i++){
        if( i != index)
            if(array[index] <= eta * array[i])
            return NO;
    }
    
    return YES;
}


-(BOOL)isSameVectorVectorA:(Vector2D*)vect1 VectorB:(Vector2D*)vect2{
    return (fabs(vect1.x - vect2.x) < floatComparisonEpsilon && fabs(vect1.y - vect2.y) < floatComparisonEpsilon);
}

@end
