//
//  CollisionDetector.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/14/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "CollisionDetector.h"

@implementation CollisionDetector


-(void)detectCollision{
    
    Vector2D* hA = [self.rectA hVector];
    Vector2D* hB = [self.rectB hVector];
    
    Vector2D* pA = [self.rectA centerOfRectangleInUpRightCoordinateSystem];
    Vector2D* pB = [self.rectB centerOfRectangleInUpRightCoordinateSystem];
    Vector2D* d = [pB subtract:pA];
    
    Matrix2D* RA = [self.rectA rotationMatrix];
    Matrix2D* RB = [self.rectB rotationMatrix];
    
    Vector2D* dA = [[RA transpose] multiplyVector:d];
    Vector2D* dB = [[RB transpose] multiplyVector:d];
    
    Matrix2D* C = [[RA transpose] multiply:RB];
    Matrix2D* CT = [C transpose];
    
    Vector2D* fA = [[[dA abs] subtract:hA] subtract:[C multiplyVector:hB]];
    Vector2D* fB = [[[dB abs] subtract:hB] subtract:[CT multiplyVector:hA]];
    
    CGFloat fax = fA.x;
    CGFloat fay = fA.y;
    CGFloat fbx = fB.x;
    CGFloat fby = fB.y;
    
    if(fax>=0 || fay >=0 || fbx>=0 || fby>=0) //rectangles not colliding
        return;
    
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
            
            if(dA.x > 0){
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
        return;
    
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
            assert(dist1 > 0 && dist2 < 0);
            v1Prime = v2;
            v2Prime = [[[v2 subtract:v1] multiply:dist1/(dist1-dist2)] add:v1];
        }
    
    dist1 = [ns dot:v1Prime] - Dpos;
    dist2 = [ns dot:v2Prime] - Dpos;
    
    Vector2D* v1DoublePrime;
    Vector2D* v2DoublePrime;
    
    if(dist1 > 0 && dist2 > 0) //rectangles not colliding
        return;
    
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
            assert(dist1 > 0 && dist2 < 0);
            v1DoublePrime = v2Prime;
            v2DoublePrime = [[[v2Prime subtract:v1Prime] multiply:dist1/(dist1-dist2)] add:v1Prime];

        }
    
    CGFloat seperationC1 = [nf dot:v1DoublePrime] - Df;
    Vector2D* c1 = [v1DoublePrime subtract:[nf multiply:seperationC1]];
    
    CGFloat seperationC2 = [nf dot:v2DoublePrime] - Df;
    Vector2D* c2 = [v2DoublePrime subtract:[nf multiply:seperationC2]];
    
    
}



-(BOOL)testValue:(CGFloat)valueA isLargerThan:(CGFloat)valueB and:(CGFloat)valueC and:(CGFloat)valueD{
    return (valueA >= valueB && valueA >= valueC && valueA >= valueD);
}
@end
