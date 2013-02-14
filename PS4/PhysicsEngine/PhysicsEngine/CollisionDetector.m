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
    
}



-(BOOL)testValue:(CGFloat)valueA isLargerThan:(CGFloat)valueB and:(CGFloat)valueC and:(CGFloat)valueD{
    return (valueA >= valueB && valueA >= valueC && valueA >= valueD);
}
@end
