#import "RatTerm.h"


@implementation RatTerm

@synthesize coeff;
@synthesize expt;

// Checks that the representation invariant holds.
-(void) checkRep{ // 5 points
    // You need to fill in the implementation of this method
    
    RatNum *ZERO = [RatNum initZERO];
    
    if (coeff == Nil){
		[NSException raise:@"RatNum rep error" format:
		 @"the coeff of a polynomial term can never be null!"];
	}
    
    if ([coeff isEqual:ZERO] && expt != 0){
		[NSException raise:@"RatNum rep error" format:
		 @"invalid coeff/expt combination! only (0,0) allowed"];
	}
	
	
}

-(id)initWithCoeff:(RatNum*)c Exp:(int)e{
    // REQUIRES: (c, e) is a valid RatTerm
    // EFFECTS: returns a RatTerm with coefficient c and exponent e
    
    RatNum *ZERO = [RatNum initZERO];
    
    // if coefficient is 0, exponent must also be 0
    // we'd like to keep the coefficient, so we must retain it
    
    if ([c isEqual:ZERO]) {
        coeff = ZERO;
        expt = 0;
    } else {
        coeff = c;
        expt = e;
    }
    [self checkRep];
    return self;
}

+(id)initZERO { // 5 points
    // EFFECTS: returns a zero ratterm
    
    RatNum *ZERO = [RatNum initZERO];
    RatTerm *returnedValue = [[RatTerm alloc] initWithCoeff:ZERO Exp:0];
    [returnedValue checkRep];
    
    return returnedValue;
    
}

+(id)initNaN { // 5 points
    // EFFECTS: returns a nan ratterm
    
    RatNum *NanCoeff = [RatNum initNaN];
    RatTerm *returnedValue = [[RatTerm alloc] initWithCoeff:NanCoeff Exp:0];
    [returnedValue checkRep];

    return returnedValue;
    
}

-(BOOL)isNaN { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: return YES if and only if coeff is NaN
    
    
    [self checkRep];

    return [self.coeff isNaN];
    
    
}

-(BOOL)isZero { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: return YES if and only if coeff is zero
    
    
    [self checkRep];
    
    RatNum *ZERO = [RatNum initZERO];
    return [self.coeff isEqual:ZERO];
    
    
}


// Returns the value of this RatTerm, evaluated at d.
-(double)eval:(double)d { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: return the value of this polynomial when evaluated at
    //            'd'. For example, "3*x^2" evaluated at 2 is 12. if 
    //            [self isNaN] returns YES, return NaN
    
    [self checkRep];
    
    if([self.coeff isNaN])
        return NAN;
    
    double xTerm = pow(d, (self.expt)*1.0);
    double coef = [self.coeff doubleValue];
    
    return xTerm * coef;
    
}

-(RatTerm*)negate{ // 5 points
    // REQUIRES: self != nil 
    // EFFECTS: return the negated term, return NaN if the term is NaN
    
    [self checkRep];
    
    if([self isNaN])
        return [RatTerm initNaN];
    
    RatNum *newCoeff = [self.coeff negate];
    
    return [[RatTerm alloc] initWithCoeff:newCoeff Exp:self.expt];
    
}



// Addition operation.
-(RatTerm*)add:(RatTerm*)arg { // 5 points
    // REQUIRES: (arg != null) && (self != nil) && ((self.expt == arg.expt) || (self.isZero() ||
    //            arg.isZero() || self.isNaN() || arg.isNaN())).
    // EFFECTS: returns a RatTerm equals to (self + arg). If either argument is NaN, then returns NaN.
    //            throws NSException if (self.expt != arg.expt) and neither argument is zero or NaN.
    
    [self checkRep];
    [arg checkRep];
    
    
    if(![self isNaN] && ![self isZero] && ![arg isNaN] && ![arg isZero])
        if(self.expt != arg.expt)
           [NSException raise:@"RatNum adding error" format:@"adding ratTerms require same order!"];
    
    if([self isNaN] || [arg isNaN])
        return [RatTerm initNaN];
    
    if([self isZero])
        return arg;
    
    if([arg isZero])
        return self;
    
    RatNum *ZERO = [RatNum initZERO];
    
    RatNum *newSum = [self.coeff add:arg.coeff];
    
    if(![newSum isEqual:ZERO]){  //only allow (0,0)
        RatTerm *returnValue = [[RatTerm alloc] initWithCoeff:newSum Exp:self.expt];
        [returnValue checkRep];
        return returnValue;
    }
    else{ 
        return [RatTerm initZERO];
    }
    
    
    
}


// Subtraction operation.
-(RatTerm*)sub:(RatTerm*)arg { // 5 points
    // REQUIRES: (arg != nil) && (self != nil) && ((self.expt == arg.expt) || (self.isZero() ||
    //             arg.isZero() || self.isNaN() || arg.isNaN())).
    // EFFECTS: returns a RatTerm equals to (self - arg). If either argument is NaN, then returns NaN.
    //            throws NSException if (self.expt != arg.expt) and neither argument is zero or NaN.
    
    [self checkRep];
    [arg checkRep];
    
    return [self add:[arg negate]];
    
}


// Multiplication operation
-(RatTerm*)mul:(RatTerm*)arg { // 5 points
    // REQUIRES: arg != null, self != nil
    // EFFECTS: return a RatTerm equals to (self*arg). If either argument is NaN, then return NaN
    
    
    [self checkRep];
    [arg checkRep];
    
    
    if([self isNaN] || [arg isNaN])
        return [RatTerm initNaN];
    
    RatNum *ZERO = [RatNum initZERO];
    RatNum *newMul = [self.coeff mul:arg.coeff];
    
    if(![newMul isEqual:ZERO]){  //only allow (0,0)
        RatTerm *returnValue = [[RatTerm alloc] initWithCoeff:newMul Exp:(self.expt + arg.expt)];
        [returnValue checkRep];
        return returnValue;
    }
    else{
        return [RatTerm initZERO];
    }
    
}


// Division operation
-(RatTerm*)div:(RatTerm*)arg { // 5 points
    // REQUIRES: arg != null, self != nil
    // EFFECTS: return a RatTerm equals to (self/arg). If either argument is NaN, then return NaN
    
    [self checkRep];
    [arg checkRep];
    
    
    
    if([self isNaN] || [arg isNaN])
        return [RatTerm initNaN];
    
    RatNum *ZERO = [RatNum initZERO];
    
    RatNum *newDiv = [self.coeff div:arg.coeff];
    
    if(![newDiv isEqual:ZERO]){
        RatTerm *returnValue = [[RatTerm alloc] initWithCoeff:newDiv Exp:(self.expt - arg.expt)];
        [returnValue checkRep];
        return returnValue;
    }
    else
       return [RatTerm initZERO];
    
}


// Returns a string representation of this RatTerm.
-(NSString*)stringValue { // 5 points
    //  REQUIRES: self != nil
    // EFFECTS: return A String representation of the expression represented by this.
    //           There is no whitespace in the returned string.
    //           If the term is itself zero, the returned string will just be "0".
    //           If this.isNaN(), then the returned string will be just "NaN"
    //		    
    //          The string for a non-zero, non-NaN RatTerm is in the form "C*x^E" where C
    //          is a valid string representation of a RatNum (see {@link ps1.RatNum}'s
    //          toString method) and E is an integer. UNLESS: (1) the exponent E is zero,
    //          in which case T takes the form "C" (2) the exponent E is one, in which
    //          case T takes the form "C*x" (3) the coefficient C is one, in which case T
    //          takes the form "x^E" or "x" (if E is one) or "1" (if E is zero).
    // 
    //          Valid example outputs include "3/2*x^2", "-1/2", "0", and "NaN".
    
        

    [self checkRep];
    
    RatNum *one = [[RatNum alloc] initWithInteger:1];
    RatNum *negaOne = [[RatNum alloc] initWithInteger:-1];
    
    if(self.expt == 0)  //a constant
        return [self.coeff stringValue];
    
    if(self.expt == 1){ //easy case first, C*x
        
        if([self.coeff isEqual: one])
            return @"x";
        if([self.coeff isEqual: negaOne])
            return @"-x";
        
        //C*x
        NSString *coe = [self.coeff stringValue];
        
        return [coe stringByAppendingString:@"*x"];
    }
    
    //degree not 0 and 1 from now
        
    if([self.coeff isEqual:one])
        return [NSString stringWithFormat:@"x^%d", self.expt];
    if([self.coeff isEqual:negaOne])
        return [NSString stringWithFormat:@"-x^%d", self.expt];
    
    //non-one, non-negaOne coefficient with degree != 0 or 1 now
    NSString *coe = [self.coeff stringValue];
    NSString *xTerm = [NSString stringWithFormat:@"*x^%d", self.expt];
    NSString *result = @"";
    result = [result stringByAppendingString:coe];
    result = [result stringByAppendingString:xTerm];
    
    
    return result;
}

// Build a new RatTerm, given a descriptive string.
+(RatTerm*)valueOf:(NSString*)str { // 5 points
    // REQUIRES: that self != nil and "str" is an instance of
    //             NSString with no spaces that expresses
    //             RatTerm in the form defined in the stringValue method.
    //             Valid inputs include "0", "x", "-5/3*x^3", and "NaN"
    // EFFECTS: returns a RatTerm t such that [t stringValue] = str
    
    
    RatNum *one = [[RatNum alloc] initWithInteger:1];
    RatNum *negaOne = [[RatNum alloc] initWithInteger:-1];
    
    if(str == nil || [str isEqual:@""])
        return [RatTerm initZERO];
    
    if([str isEqual:@"NaN"])
        return [RatTerm initNaN];
    
    if([str isEqual:@"0"])
        return [RatTerm initZERO];
    
    
    if([str rangeOfString:@"x"].location == NSNotFound){ //no x, means only a constant term, and not 0
    
        RatNum *coef = [RatNum valueOf:str];
        
        return [[RatTerm alloc] initWithCoeff:coef Exp:0];
    
    }
    else{  //contains a x
        
        if([str rangeOfString:@"*"].location == NSNotFound){   //coefficient == 1 or -1
            
            if([str rangeOfString:@"^"].location == NSNotFound){  // just x
                
                if([str rangeOfString:@"-"].location == NSNotFound) //positive
                   return [[RatTerm alloc] initWithCoeff:one Exp:1];
                else
                    return [[RatTerm alloc] initWithCoeff:negaOne Exp:1];
            
            }else{   //x^e
                
                NSArray *tokens = [str componentsSeparatedByString:@"^"];
                int exp = [[tokens objectAtIndex:1] intValue];
                
                if([str rangeOfString:@"-"].location == NSNotFound) //positive
                    return [[RatTerm alloc] initWithCoeff:one Exp:exp];
                else
                    return [[RatTerm alloc] initWithCoeff:negaOne Exp:exp];
            }
            
        }else{  //coefficient != 1 nor -1
            
            NSArray *tokens = [str componentsSeparatedByString:@"*"]; //must exits a "*"
            
            RatNum *coef = [RatNum valueOf:[tokens objectAtIndex:0]];
            NSString *xPower = [tokens objectAtIndex:1];
            
            if([xPower rangeOfString:@"^"].location == NSNotFound){  // just C*x
                return [[RatTerm alloc] initWithCoeff:coef Exp:1];
            }else{   //C*x^e
                
                NSArray *tokens2 = [xPower componentsSeparatedByString:@"^"];
                int exp = [[tokens2 objectAtIndex:1] intValue];
                
                return [[RatTerm alloc] initWithCoeff:coef Exp:exp];
            }
            
            
        }
        
    }
    
    
}

//  Equality test,
-(BOOL)isEqual:(id)obj { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: returns YES if "obj" is an instance of RatTerm, which represents
    //            the same RatTerm as self.
    
    [self checkRep];

    if([obj isKindOfClass:[RatTerm class]]){
        
		RatTerm *rt = (RatTerm*)obj;
        
        [rt checkRep];
        
		if ([self isNaN] && [rt isNaN]) {
			return YES;
		} else {
			return [self.coeff isEqual:rt.coeff] && self.expt == rt.expt;
		}
        
	}
    else
        return NO;
    
    
}

@end
