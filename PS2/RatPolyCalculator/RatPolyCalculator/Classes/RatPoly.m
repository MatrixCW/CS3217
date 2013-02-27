#import "RatPoly.h"


@implementation RatPoly

@synthesize terms;

// Note that since there is no variable called "degree" in our class,the compiler won't synthesize 
// the "getter" for "degree". and we have to write our own getter
-(int)degree{ // 5 points
    // EFFECTS: returns the degree of this RatPoly object. 
    

	[self checkRep];
    
    if(self.terms.count == 0)
        return 0;
    else
        return [[self.terms objectAtIndex:0] expt];
}

// Check that the representation invariant is satisfied
-(void)checkRep{ // 5 points
    // Representation Invariant for every RatPoly p:
    // terms != null &&
    // forall i such that (0 <= i < length(p)), C(p,i) != 0 &&
    // forall i such that (0 <= i < length(p)), E(p,i) >= 0 &&
    // forall i such that (0 <= i < length(p) - 1), E(p,i) > E(p, i+1)
    // In other words:
    // * The terms field always points to some usable object.
    // * No term in a RatPoly has a zero coefficient.
    // * No term in a RatPoly has a negative exponent.
    // * The terms in a RatPoly are sorted in descending exponent order.
    // (It is implied that 'terms' does not contain any null elements by the
    // above
    // invariant.)
	
    if(self.terms == NULL){
        [NSException raise:@"Error occurred!\n" format:@"RatPoly cannot have null objects"];
    }
    

    if([self.terms count] != 0){
        
        for(RatTerm *currentTerm in self.terms){
            
            if([currentTerm isZero])
                [NSException raise:@"Error occurred!\n" format:@"RatPoly cannot have terms with 0 coefficient!"];
            
            if(currentTerm.expt < 0)
                [NSException raise:@"Error occurred!\n" format:@"RatPoly cannot have terms with negative coefficient!"];
                
            }
        
        for(int i = 0; i < self.terms.count-1; i++){
            
            if(![self hasHigherDegreeThanNextTerm:[self.terms objectAtIndex:i] :[self.terms objectAtIndex:i+1]])
                [NSException raise:@"Error occurred!\n" format:@"RatPoly cannot have non-increasing terms!"];

        }

    
    }

	
}

-(BOOL)hasHigherDegreeThanNextTerm:(RatTerm*)previous :(RatTerm*)next{
    if(previous.expt > next.expt)
        return YES;
    else
        return NO;
}


-(id)init { // 5 points
    //EFFECTS: constructs a polynomial with zero terms, which is effectively the zero polynomial
    //           remember to call checkRep to check for representation invariant
    
    self = [super init];
    
    if(self){
        terms = [[NSArray alloc] init];
    }
    
    [self checkRep];
    
    return self;
}

-(id)initWithTerm:(RatTerm*)rt{ // 5 points
    //  REQUIRES: [rt expt] >= 0
    //  EFFECTS: constructs a new polynomial equal to rt. if rt's coefficient is zero, constructs
    //             a zero polynomial remember to call checkRep to check for representation invariant
    
    self = [super init];
    
    assert(rt != nil);
    
    if(self){
        
        if([rt isZero])
            return [self init];
        else
            terms = [[NSArray alloc] initWithObjects:rt, nil];
    }
    
    [self checkRep];
    
    return self;
    
    
}

-(id)initWithTerms:(NSArray*)ts{ // 5 points
    // REQUIRES: "ts" satisfies clauses given in the representation invariant
    // EFFECTS: constructs a new polynomial using "ts" as part of the representation.
    //            the method does not make a copy of "ts". remember to call checkRep to check for representation invariant
    
    self = [super init];
    
    assert(ts != nil);
    
    if(self){
        
        
        
        if(ts.count == 1 && [[ts objectAtIndex:0] isZero])  //cannot have array containing 0
            self = [self init];
        else
            terms = ts;
    }
    
    [self checkRep];
    
    return self;
    
}


-(RatTerm*)getTerm:(int)deg { // 5 points
    // REQUIRES: self != nil && ![self isNaN]
    // EFFECTS: returns the term associated with degree "deg". If no such term exists, return
    //            the zero RatTerm
    
    [self checkRep];
    
    for(RatTerm *currentTerm in self.terms){
        
        if(currentTerm.expt == deg)
            return currentTerm;
    }
    
    
    return [RatTerm initZERO];
    
}

-(BOOL)isNaN { // 5 points
    // REQUIRES: self != nil
    //  EFFECTS: returns YES if this RatPoly is NaN
    //             i.e. returns YES if and only if some coefficient = "NaN".
    
    [self checkRep];
    
    for(RatTerm *currentTerm in self.terms){
        
        if([currentTerm.coeff isNaN])
            return YES;
    }
    
    
    return NO;
    
}


-(RatPoly*)negate { // 5 points
    // REQUIRES: self != nil 
    // EFFECTS: returns the additive inverse of this RatPoly.
    //            returns a RatPoly equal to "0 - self"; if [self isNaN], returns
    //            some r such that [r isNaN]
    
    [self checkRep];
    
    if([self isNaN])
        return [[RatPoly alloc] initWithTerm:[RatTerm initNaN]];
    
    if(self.terms.count == 0){
        return [[RatPoly alloc] init];
    }
    
    NSInteger size = self.terms.count;
    NSMutableArray *negaTerms = [[NSMutableArray alloc] initWithCapacity:size];
    
    for(RatTerm *currentTerm in self.terms){
        [negaTerms addObject:[currentTerm negate]];
    }
    
    NSArray *tempArray = [[NSArray alloc] initWithArray:negaTerms];
    
    return [[RatPoly alloc] initWithTerms:tempArray];
    
    
    
}


-(NSArray*)sortAccordingToExpt:(NSArray*)unsortedArray{ 
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"expt" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [unsortedArray sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
    
}

// Addition operation
-(RatPoly*)add:(RatPoly*)p { // 5 points
    // REQUIRES: p!=nil, self != nil
    // EFFECTS: returns a RatPoly r, such that r=self+p; if [self isNaN] or [p isNaN], returns
    //            some r such that [r isNaN]
    
    [self checkRep];
    [p checkRep];
    
    
    if([self isNaN] || [p isNaN])
        return [[RatPoly alloc] initWithTerm:[RatTerm initNaN]];
    
    if(self.terms.count == 0)
        return p;
    
    if(p.terms.count == 0)
        return self;
    
    NSMutableArray *sums = [[NSMutableArray alloc] init];
        
    for(RatTerm *currentTermSelf in self.terms){
        
        RatTerm *sameDegreeTerm = [p getTerm:currentTermSelf.expt];
        
        if([sameDegreeTerm isZero]){
            [sums addObject:currentTermSelf];
        }else{
            [sums addObject:[currentTermSelf add:sameDegreeTerm]];
        }
    }
    
    
    //un-summed RatTerm in p may be added
    for(RatTerm *currentTermP in p.terms){
        
        RatTerm *sameDegreeTerm = [self getTerm:currentTermP.expt];
        
        if([sameDegreeTerm isZero])
            [sums addObject:currentTermP];
            
    }
    
    //sum up may introduce 0 RatTerm, remove them
    NSMutableArray *removeZeroRatTerm = [[NSMutableArray alloc] init];
    for(RatTerm *term in sums){
        if([term isZero])
            [removeZeroRatTerm addObject:term];
    }
    for(RatTerm *term in removeZeroRatTerm){
        [sums removeObject:term];
    }
    
    
    NSArray *sumArray = [self sortAccordingToExpt:sums];
    
    return [[RatPoly alloc] initWithTerms:sumArray];
     
    
    
}

// Subtraction operation
-(RatPoly*)sub:(RatPoly*)p { // 5 points
    // REQUIRES: p!=nil, self != nil
    // EFFECTS: returns a RatPoly r, such that r=self-p; if [self isNaN] or [p isNaN], returns
    //            some r such that [r isNaN]
    
    [self checkRep];
    [p checkRep];
    
    if([self isNaN] || [p isNaN])
        return [[RatPoly alloc] initWithTerm:[RatTerm initNaN]];
    
    if(self.terms.count == 0)
        return [p negate];
    
    if(p.terms.count == 0)
        return self;
    
    
    return [self add:[p negate]];

    
}


// Multiplication operation
-(RatPoly*)mul:(RatPoly*)p { // 5 points
    // REQUIRES: p!=nil, self != nil
    // EFFECTS: returns a RatPoly r, such that r=self*p; if [self isNaN] or [p isNaN], returns
    // some r such that [r isNaN]
    
    [self checkRep];
    [p checkRep];
    
    if([self isNaN] || [p isNaN])
        return [[RatPoly alloc] initWithTerm:[RatTerm initNaN]];
    
    if(self.terms.count == 0 || p.terms.count == 0)
        return [[RatPoly alloc] init];
    
    /*
        foreach term tq in q
           foreach term tp in p
              r += tp * tq
    */
    
    RatPoly *sum = [[RatPoly alloc] init];
    RatPoly *temp = [[RatPoly alloc] init];
    
    for(RatTerm *currentTermSelf in self.terms){
        for(RatTerm *currentTermP in p.terms){
            temp = [[RatPoly alloc] initWithTerm:[currentTermSelf mul:currentTermP]];
            sum = [sum add:temp];
        }
    }
    
    [sum checkRep];
    
    
    return sum;
    


    
}


// Division operation (truncating).
-(RatPoly*)div:(RatPoly*)p{ // 5 points
    // REQUIRES: p != null, self != nil
    // EFFECTS: return a RatPoly, q, such that q = "this / p"; if p = 0 or [self isNaN]
    //           or [p isNaN], returns some q such that [q isNaN]
    //
    // Division of polynomials is defined as follows: Given two polynomials u
    // and v, with v != "0", we can divide u by v to obtain a quotient
    // polynomial q and a remainder polynomial r satisfying the condition u = "q *
    // v + r", where the degree of r is strictly less than the degree of v, the
    // degree of q is no greater than the degree of u, and r and q have no
    // negative exponents.
    // 
    // For the purposes of this class, the operation "u / v" returns q as
    // defined above.
    //
    // The following are examples of div's behavior: "x^3-2*x+3" / "3*x^2" =
    // "1/3*x" (with r = "-2*x+3"). "x^2+2*x+15 / 2*x^3" = "0" (with r =
    // "x^2+2*x+15"). "x^3+x-1 / x+1 = x^2-x+2 (with r = "-3").
    //
    // Note that this truncating behavior is similar to the behavior of integer
    // division on computers.
    
    [self checkRep];
    [p checkRep];
    
    /*
     set quotient=0 and reminder=self
     while r ≠ 0 AND degree(reminder) ≥ degree(p):
     t ← lead(reminder)/lead(p)     # Divide the leading terms
     quotient = quotient + t, reminder = reminder - (t * p))
     */
    
    
    if([self isNaN] || [p isNaN] || p.terms.count == 0)
        return [[RatPoly alloc] initWithTerm:[RatTerm initNaN]];
    
    if(self.terms.count == 0)
        return [[RatPoly alloc] init];

    RatPoly *quotient = [[RatPoly alloc] init];
    RatPoly *reminder = [[RatPoly alloc] initWithTerms:self.terms];
    
    RatTerm *leadingTermP = [p.terms objectAtIndex:0];
    
    while(reminder.terms.count !=0 && ([reminder degree] >= [p degree])){
        
        [quotient checkRep];
        [reminder checkRep];
        
        RatTerm *leadingTermReminder = [reminder.terms objectAtIndex:0];
        RatPoly *temp = [[RatPoly alloc] initWithTerm:[leadingTermReminder div:leadingTermP]];
        quotient = [quotient add:temp];
        RatPoly *decrementInReminder = [temp mul:p];
        reminder = [reminder sub:decrementInReminder];
        
        
    }
    
    [quotient checkRep];
    
    return quotient;
    
}

-(double)eval:(double)d { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: returns the value of this RatPoly, evaluated at d
    //            for example, "x+2" evaluated at 3 is 5, and "x^2-x" evaluated at 3 is 6.
    //            if [self isNaN], return NaN
    
    [self checkRep];
    
    if(self.terms.count == 0)
        return 0.0;
    
    if([self isNaN])
        return NAN;
    
    CGFloat sum = 0.0;
    
    for(RatTerm *currentTerm in self.terms){
        
        CGFloat temp = [currentTerm eval:d];
        sum += temp;
    }
    
    
    return sum;
}


// Returns a string representation of this RatPoly.
-(NSString*)stringValue { // 5 points
    // REQUIRES: self != nil
    // EFFECTS:
    // return A String representation of the expression represented by this,
    // with the terms sorted in order of degree from highest to lowest.
    //
    // There is no whitespace in the returned string.
    //        
    // If the polynomial is itself zero, the returned string will just
    // be "0".
    //         
    // If this.isNaN(), then the returned string will be just "NaN"
    //         
    // The string for a non-zero, non-NaN poly is in the form
    // "(-)T(+|-)T(+|-)...", where "(-)" refers to a possible minus
    // sign, if needed, and "(+|-)" refer to either a plus or minus
    // sign, as needed. For each term, T takes the form "C*x^E" or "C*x"
    // where C > 0, UNLESS: (1) the exponent E is zero, in which case T
    // takes the form "C", or (2) the coefficient C is one, in which
    // case T takes the form "x^E" or "x". In cases were both (1) and
    // (2) apply, (1) is used.
    //        
    // Valid example outputs include "x^17-3/2*x^2+1", "-x+1", "-1/2",
    // and "0".
    
    [self checkRep];
    
    if([self isNaN])
        return @"NaN";
    
    if(self.terms.count == 0)
        return @"0";
    
   
    NSString *result = @"";
    result = [result stringByAppendingString:[[self.terms objectAtIndex:0] stringValue]];
    
    
    for(int i=1; i<self.terms.count;i++){
        
        if([[[self.terms objectAtIndex:i] coeff] isNegative]){
            result = [result stringByAppendingString:[[self.terms objectAtIndex:i] stringValue]];
        }else{
            result = [result stringByAppendingString:@"+"];
            result = [result stringByAppendingString:[[self.terms objectAtIndex:i] stringValue]];
        }
        
    }
    
    
    return result;
    
    
    
}


// Builds a new RatPoly, given a descriptive String.
+(RatPoly*)valueOf:(NSString*)str { // 5 points
    // REQUIRES : 'str' is an instance of a string with no spaces that
    //              expresses a poly in the form defined in the stringValue method.
    //              Valid inputs include "0", "x-10", and "x^3-2*x^2+5/3*x+3", and "NaN".
    // EFFECTS : return a RatPoly p such that [p stringValue] = str
    
    
    if(str == nil ||[str isEqual:@""])
        return [[RatPoly alloc] init];
    
    if([str isEqual:@"NaN"])
        return [[RatPoly alloc] initWithTerm:[RatTerm initNaN]];
    
    if([str isEqual:@"0"])
        return [[RatPoly alloc] init];
    
    RatPoly *value = [[RatPoly alloc] init];
    
    NSString *firstChar = [str substringToIndex:1];
    
    NSArray *splitMinusSign = [str componentsSeparatedByString:@"-"];
    
    //NSInteger size = splitMinusSign.count;
    //NSString *o = [splitMinusSign objectAtIndex:0];
    //NSString *oo = [splitMinusSign objectAtIndex:1];
    
    
    
    NSMutableArray *splitMinusSignMutable = [NSMutableArray arrayWithCapacity:splitMinusSign.count];
    
    
    [splitMinusSignMutable addObject:[splitMinusSign objectAtIndex:0]];
    
    if([firstChar isEqual:@"-"])
        [splitMinusSignMutable removeObjectAtIndex:0];
    
    for(int i = 1; i < splitMinusSign.count; i++){
        
        NSString *toAppend = [splitMinusSign objectAtIndex:i];
        NSString *restoreMinusSign = [@"-" stringByAppendingString:toAppend];
        [splitMinusSignMutable addObject:restoreMinusSign];
    }
    
    for(NSString *strs in splitMinusSignMutable){
        NSArray *tokens = [strs componentsSeparatedByString:@"+"];
        for(NSString *subStrs in tokens){
            RatTerm *tempTerm = [RatTerm valueOf:subStrs];
            RatPoly *tempValue = [[RatPoly alloc] initWithTerm:tempTerm];
            value = [value add:tempValue];
        }
    }
    
    return value;
    
    
    
}

// Equality test
-(BOOL)isEqual:(id)obj { // 5 points
    // REQUIRES: self != nil
    // EFFECTS: returns YES if and only if "obj" is an instance of a RatPoly, which represents
    //            the same rational polynomial as self. All NaN polynomials are considered equal
    
    [self checkRep];
    
    if([obj isKindOfClass:[RatPoly class]]){
        
		RatPoly *rp = (RatPoly*)obj;
        
        [rp checkRep];
        
		if ([self isNaN] && [rp isNaN])
			return YES;
        
        if(self.terms.count == 0 && rp.terms.count == 0)
            return YES;
        
        if(self.terms.count != rp.terms.count)
            return NO;
        
        for(int i = 0; i < self.terms.count; i++)
            if(![[self.terms objectAtIndex:i] isEqual:[rp.terms objectAtIndex:i]])
                return NO;
        
        return YES;
		         
	}
    
        return NO;
    
}

@end

/* 
 
 Question 1(a)
 ========
 
 to computer r = p - q:
  
    foreach term tq in q
        nagate the coefficient
    computer r = p + q
 
 return r
 
 Question 1(b)
 ========
 
 to computer r = p * q:
 
    set r = 0;
 
    foreach term tq in q
        foreach term tp in p
             r += tp * tq 
   
 return r
 
    
 Question 1(c)
 ========
 
 let q be the quotient and r the reminder
 
 to computer p / d where d !=0
 
 set q=0 and r=p
 
 while r ≠ 0 AND degree(r) ≥ degree(d):
      t ← lead(r)/lead(d)     # Divide the leading terms
      q = q + t, r = r - (t * d))
 
 return (q, r)
 
 Question 2(a)
 ========
 
 When we pass a message to a NIL pointer, there will be no error happens in Objective-c, and what happens
 is that nothing really happens. The invoked method will return a 0, or 0.0 , or NIL, or NO, determined by the
 return typr of the method. So let's say if we do not check whether self is NIL or not, and we perform such an
 operation [self add:5/17], what will be returned will be another NIL ponter. This might result in further logic 
 errors. For example, if we try to call the  doubleValue method in the returned RatNum object(which is actually 
 a Nil), we get 0.0, then we might naturally think that self is -5/17, which is not true.
 
 adding and mulyiplying a Nan will return a Nan, because a Nan has denom 0, and adding, subtracting and multiplying 
 will not change this. However, to computer div, we need first inverse the arg, this will actually make a Nan becaome
  0/something, which is 0.0, and what we get is that self/Nan == 0.0, which is not mathematically correct.
 
 
 
 Question 2(b)
 ========
 
 A class method allows itself to be invoked without any instances created, and it cannot access any ivar of any instances
 of this class directly, unless passed as arguments. In this case, to get valueOf a string representing a rational number,
 we certainly do not need to access any instance, so a class method is good enough. (Actually it is even better than do it 
 as a instance method, because otherwise if need to invoke this method, we have to create a instance first, which might result 
 io memory waste.)
 
 We can also declare this valueOf method a instance method, the drawbacks have been discussed above. Another alternative is
 to put this method in the sorce file where int main (int argc, const char * argv[]) resides, this way we can treat it as the
 C language way.
 
 Question 2(c)
 ========
 
  -(void)checkRep no longer needs to check the gcd part, just delete the part involving gcd, 
                  resulting code willl be slightly clearer
  -(id)initWithNumer:(int)x Denom:(int)y needs not change x/y to reduced form, just delete the gcd part
                  resulting code willl be slightly clearer
  -(BOOL)isEqual:(id)object must be changed extensively, because now we have to change both rational number to reduced form
                  resulting code will be much more complex
  -(NSString*)stringValue should be changed because it might return something like 6/3 instead of 2. Check gcd first and use temp 
                  integer to store temp values first. Resulting code can be messy.
                  
                  
 
 Question 2(d)
 ========
 
 RatNum is immutable because both the numer and denom is readOnly, also for whatever methods provided in the
 class, it will not change the numer and denom property, so it is safe enough to checkRep once only at the end.
 
 
 Question 3(a)
 ========
 
 I put checkRep at the end of each initializer to make sure the returned value is valid.
 I put checkRep at the beginning of other method to make sure the method receives valid arguments.
 There is no need to checkRep at the end of the method, because the RatTerm is a immutable class, no methods
 can change the properties of the instances.
 
 Question 3(b)
 ========
 
 
 -(void) checkRep; must be changed, obviously, just deleting the checking code (RatNum == 0 -> expt ==0)
                  the resulting code is less complex because of this deletion
 -(id)initWithCoeff:(RatNum*)c Exp:(int)e; no longer requires explicitly change e to 0 if the input RatTerm is 0 and e != 0
                  the resulting code is less complex 
 +(id)initZero; the expt now can be any integer not so many changes.
 
 other methods, due to the way of implementation, I think they need not be modified.
 
 
 
 Question 3(c)
 ========

  -(void) checkRep must be changed, obviously, just adding the checking code (RatNum ==Nan -> expt ==0)
          the resulting code is more complex because of this extra codes
  -(id)initWithCoeff:(RatNum*)c Exp:(int)e; requires explicitly change e to 0 if the input RatTerm is Nan and e != 0
          the resulting code is more complex because of this extra codes 
  +(id)initNaN must let expt == 0, not so many changes.
 
 other methods, due to the way of implementation, I think they need not be modified.
 
 Question 3(d)
 ========
 
 Both. It is really mathematically meaningless to allow a polynomial term whose coefficient is NaN(infinity), but to make programme
 robust, and take cases like a polynomial divides by 0 into consideration, we have to allow Nan RatTerm. But we must also create a standard
 for such cases to make representation unambiguous. The same arguments also holds for zero RatTerm.
 
 Question 5: Reflection (Bonus Question)
 ==========================
 (a) How many hours did you spend on each problem of this problem set?
 
 more than 20 hours
 
 (b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?
 
 if I could follow the instrcutions more closely instead of sometimes experimenting with my own ideas, I could
 have saved plenty time.
 
 (c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?
 
 This time things are much better than PS1. The instrcutions are a lot more clearer, and the codes provided are really elegant!
 
 */
