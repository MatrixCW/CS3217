//
//  CollisionDetector.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/14/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "CollisionDetector.h"

@implementation CollisionDetector


-(id)initCoiisionDetector{
    
    self.contactPoints = [[NSMutableArray alloc] init];
    
    return self;
}


-(void)detectCollisionBetweenRectA:(PERectangle*) rectA andRectB:(PERectangle*) rectB{
    
    if(!rectA.identity && !rectB.identity)
    {
        
        NSLog(@"r15869");
        return;
    }
    //NSLog(@"%d",self.contactPoints.count);
    
    self.rectA = rectA;
    self.rectB = rectB;
    
    Vector2D* hA = [self.rectA hVector];
    Vector2D* hB = [self.rectB hVector];
    
    Vector2D* pA = [self.rectA centerOfRectangle];
    Vector2D* pB = [self.rectB centerOfRectangle];
    Vector2D* d = [pB subtract:pA];
    
    Matrix2D* RA = [self.rectA rotationMatrix];
    Matrix2D* RB = [self.rectB rotationMatrix];
    
    assert(fabs(RA.col1.x - 1) < floatComparisonEpsilon &&
           fabs(RA.col1.y) < floatComparisonEpsilon &&
           fabs(RA.col2.x) < floatComparisonEpsilon &&
           fabs(RA.col2.y - 1) < floatComparisonEpsilon);
    
    assert(fabs(RB.col1.x -1) < floatComparisonEpsilon &&
           fabs(RB.col1.y) < floatComparisonEpsilon &&
           fabs(RB.col2.x) < floatComparisonEpsilon &&
           fabs(RB.col2.y-1) < floatComparisonEpsilon);
    
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
    
    if(fax>=0 || fay >=0 || fbx>=0 || fby>=0) //rectangles not colliding
    {
        
        NSLog(@"r8888");
        return;
    }
    
    Vector2D* n;
    Vector2D* nf;
    Vector2D* ns;
    CGFloat Df;
    CGFloat Ds;
    CGFloat Dneg;
    CGFloat Dpos;
    
    if([self testValue:fax isLargerThan:fay and:fbx and:fby]){
        
        if(dA.x > 0){
            n = [RA multiplyVector:[C col1]];
        }
        else{
            n = [RA multiplyVector:[C col1]];
            n = [n negate];
        }
        
        nf = n;
        ns = [RA multiplyVector:[C col2]];
        Df = [pA dot:nf] + hA.x;
        Ds = [pA dot:ns];
        Dneg = hA.y - Ds;
        Dpos = hA.y + Ds;
    
    }else
        
        if([self testValue:fay isLargerThan:fax and:fbx and:fby]){
            
            if(dA.y > 0){
                n = [RA multiplyVector:[C col2]];
            }
            else{
                n = [RA multiplyVector:[C col2]];
                n = [n negate];
            }
            
            nf = n;
            ns = [RA multiplyVector:[C col1]];
            Df = [pA dot:nf] + hA.y;
            Ds = [pA dot:ns];
            Dneg = hA.x - Ds;
            Dpos = hA.x + Ds;
            
        }else
            if([self testValue:fbx isLargerThan:fax and:fay and:fby]){
                
                if(dB.x > 0){
                    n = [RB multiplyVector:[C col1]];
                }
                else{
                    n = [RB multiplyVector:[C col1]];
                    n = [n negate];
                }
                
                nf = [n negate];
                ns = [RB multiplyVector:[C col2]];
                Df = [pB dot:nf] + hB.x;
                Ds = [pB dot:ns];
                Dneg = hB.y - Ds;
                Dpos = hB.y + Ds;
                
            }
             else{
                 
                 assert([self testValue:fby isLargerThan:fax and:fay and:fbx]);
                 
                    if(dB.y > 0){
                        n = [RB multiplyVector:[C col2]];
                    }
                    else{
                        n = [RB multiplyVector:[C col2]];
                        n = [n negate];
                    }
                    
                    nf = [n negate];
                    ns = [RB multiplyVector:[C col1]];
                    Df = [pB dot:nf] + hB.y;
                    Ds = [pB dot:ns];
                    Dneg = hB.x - Ds;
                    Dpos = hB.x + Ds;
                    
                }
    
    Vector2D* ni;
    Vector2D* p;
    Matrix2D* R;
    Vector2D* h;
    
    if([self testValue:fax isLargerThan:fay and:fbx and:fby] || [self testValue:fay isLargerThan:fax and:fbx and:fby]){
        ni = [[[RB transpose] multiplyVector:nf] negate];
        p = pB;
        R = RB;
        h = hB;
    }
    
    if([self testValue:fbx isLargerThan:fax and:fay and:fby] || [self testValue:fby isLargerThan:fax and:fay and:fbx]){
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
        
    }
    else
        if(niAbs.x > niAbs.y && ni.x <= 0){
            v1 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:h.y]]];
            v2 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:-h.y]]];
            
        }
        else
            if(niAbs.x <= niAbs.y && ni.x > 0){
                v1 = [p add:[R multiplyVector:[Vector2D vectorWith:h.x y:h.y]]];
                v2 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:h.y]]];
        
        }
            else{
                assert(niAbs.x <= niAbs.y && ni.x <= 0);
                v1 = [p add:[R multiplyVector:[Vector2D vectorWith:-h.x y:-h.y]]];
                v2 = [p add:[R multiplyVector:[Vector2D vectorWith:h.x y:-h.y]]];
            }
    
    Vector2D* v1Prime;
    Vector2D* v2Prime;
    
    CGFloat dist1 = -[ns dot:v1] - Dneg;
    CGFloat dist2 = -[ns dot:v2] - Dneg;
    
    if(dist1 > 0 && dist2 > 0) //rectangles not colliding
    {
        
        NSLog(@"r00000");
        return;
    }
    
    if(dist1 < 0 && dist2 < 0){
        v1Prime = v1;
        v2Prime = v2;
    }
    else
        if(dist1 < 0 && dist2 > 0){
            v1Prime = v1;
            v2Prime = [[[v2 subtract:v1] multiply:dist1/(dist1-dist2)] add:v1];
        }
        else{
            //assert(dist1 >= 0 && dist2 <= 0);
            v1Prime = v2;
            v2Prime = [[[v2 subtract:v1] multiply:dist1/(dist1-dist2)] add:v1];
        }
    
    dist1 = [ns dot:v1Prime] - Dpos;
    dist2 = [ns dot:v2Prime] - Dpos;
    
    Vector2D* v1DoublePrime;
    Vector2D* v2DoublePrime;
    
    if(dist1 > 0 && dist2 > 0) //rectangles not colliding
    {
        
        NSLog(@"r11111");
        return;
    }
    
    if(dist1 < 0 && dist2 < 0){
        v1DoublePrime = v1Prime;
        v2DoublePrime = v2Prime;
    }
    else
        if(dist1 < 0 && dist2 > 0){
            v1DoublePrime = v1Prime;
            v2DoublePrime = [[[v2Prime subtract:v1Prime] multiply:dist1/(dist1-dist2)] add:v1Prime];
        }
        else{
            v1DoublePrime = v2Prime;
            v2DoublePrime = [[[v2Prime subtract:v1Prime] multiply:dist1/(dist1-dist2)] add:v1Prime];

        }
    
    
    if([self isSameVectorVectorA:v1DoublePrime VectorB:v2DoublePrime]) // not colliding
    {
        
        NSLog(@"r2222");
        return;
    }
    
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
        
        Vector2D* uA = [rectA.velocity add:[rA crossZ:rectA.angularVelocity]];
        Vector2D* uB = [rectB.velocity add:[rB crossZ:rectB.angularVelocity]];
        
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
        
        Vector2D* Pn = [point.n multiply:(fmin(0.0,mn*(1.0+e)*un))];
        CGFloat dPt = mt * ut;
        
        CGFloat Ptmax = rectA.frictionCoefficient * rectB.frictionCoefficient * [Pn length];
        
        dPt = fmax(fmin(dPt, Ptmax), -Ptmax);
        
        Vector2D* Pt = [point.t multiply:dPt];
        NSLog(@"a before %lf, %lf", Pn.x,Pn.y);
        rectA.velocity = [rectA.velocity add:[[Pn add:Pt] multiply:(1.0/rectA.mass)]];
        NSLog(@"%lf, %lf", Pt.x,Pt.y);
        
        NSLog(@"%lf, %lf", rectB.velocity.x,rectB.velocity.y);
        rectB.velocity = [rectB.velocity subtract:[[Pn add:Pt] multiply:(1.0/rectB.mass)]];
        NSLog(@"%lf, %lf", rectB.velocity.x,rectB.velocity.y);
        
       
        rectA.angularVelocity = rectA.angularVelocity + [[Pn add:Pt] cross:rA]/rectA.momentOfInetia ;
        rectB.angularVelocity = rectB.angularVelocity - [[Pn add:Pt] cross:rB]/rectB.momentOfInetia ;
        
       // NSLog(@"%lf, %lf, %lf, %lf", rectA.velocity.x,rectA.velocity.y,rectB.velocity.x,rectB.velocity.y);
       // NSLog(@"%lf, %lf", rectA.angularVelocity,rectB.angularVelocity);
    }
    
    [self.contactPoints removeAllObjects];
}

-(BOOL)testValue:(CGFloat)valueA isLargerThan:(CGFloat)valueB and:(CGFloat)valueC and:(CGFloat)valueD{
    return (valueA >= valueB && valueA >= valueC && valueA >= valueD);
}

-(BOOL)isSameVectorVectorA:(Vector2D*)vect1 VectorB:(Vector2D*)vect2{
    return (fabs(vect1.x - vect2.x) < floatComparisonEpsilon && fabs(vect1.y - vect2.y) < floatComparisonEpsilon);
}
@end
