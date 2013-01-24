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
    
    return [[RatTerm alloc] initWithCoeff:ZERO Exp:0];
    
}

+(id)initNaN { // 5 points
    // EFFECTS: returns a nan ratterm
    
    RatNum *NanCoeff = [RatNum initNaN];
    
    return [[RatTerm alloc] initWithCoeff:NanCoeff Exp:1];
    
}

-(BOOL)isNaN { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: return YES if and only if coeff is NaN
    
    
    [self checkRep];
    
    if([self.coeff isNaN])
        return YES;
    else
        return NO;
    
}

-(BOOL)isZero { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: return YES if and only if coeff is zero
    
    
    [self checkRep];
    
    RatNum *ZERO = [RatNum initZERO];
    
    if([self.coeff isEqual:ZERO])
        return YES;
    else
        return NO;
    
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
    
    
    if((![self isNaN]) && (![arg isNaN]) && (self.expt != arg.expt))
        [NSException raise:@"RatNum adding error" format:
		 @"adding ratTerms require same order!"];
    
    if([self isNaN] || [arg isNaN])
        return [RatTerm initNaN];
    
    if([self isZero])
        return arg;
    
    if([arg isZero])
        return self;
    
    RatNum *newSum = [self.coeff add:arg.coeff];
    
    return [[RatTerm alloc] initWithCoeff:newSum Exp:self.expt];
    
    
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
    
    
    RatNum *newSum = [self.coeff mul:arg.coeff];
    
    return [[RatTerm alloc] initWithCoeff:newSum Exp:(self.expt+arg.expt)];
    
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
    
    RatNum *newSum = [self.coeff div:arg.coeff];
    
    if(![newSum isEqual:ZERO])
       return [[RatTerm alloc] initWithCoeff:newSum Exp:(self.expt-arg.expt)];
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
    
    if(self.expt == 0)
        return [NSString stringWithFormat:@"%d/%d", self.coeff.numer, self.coeff.denom];
    
    if(self.expt == 1)
        return [NSString stringWithFormat:@"%d/%d*x", self.coeff.numer, self.coeff.denom];
    
    
    if( [ self.coeff isEqual:[[RatNum alloc] initWithInteger:1] ]){
        
        switch (self.expt) {
            case 0:
                return @"1";
                break;
            case 1:
                return @"x";
                break;
            default:
                [NSString stringWithFormat:@"x^%d", self.expt];
                break;
        }
    }
        
    
    return [NSString stringWithFormat:@"%d/%d*x^%d", self.coeff.numer, self.coeff.denom,self.expt];
}

// Build a new RatTerm, given a descriptive string.
+(RatTerm*)valueOf:(NSString*)str { // 5 points
    // REQUIRES: that self != nil and "str" is an instance of
    //             NSString with no spaces that expresses
    //             RatTerm in the form defined in the stringValue method.
    //             Valid inputs include "0", "x", "-5/3*x^3", and "NaN"
    // EFFECTS: returns a RatTerm t such that [t stringValue] = str
    
}

//  Equality test,
-(BOOL)isEqual:(id)obj { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: returns YES if "obj" is an instance of RatTerm, which represents
    //            the same RatTerm as self.
    
    if([obj isKindOfClass:[RatTerm class]]){
        //isKindOfClass returns true if object can be considered as an
        //instance of the argument class. Each class has a method
        //called "class", which returns the class object. so [RatNum
        //class] returns the class object of RatNum class
        
		RatTerm *rt = (RatTerm*)obj;
		if ([self isNaN] && [rt isNaN]) {
			return YES;
		} else {
			return [self.coeff isEqual:rt.coeff] && self.expt==rt.expt;
		}
        
	} else return NO;
    
    
}

@end
