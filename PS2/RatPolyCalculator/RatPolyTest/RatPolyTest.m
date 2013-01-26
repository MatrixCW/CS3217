//
//  RatPolyTest.m
//  RatPolyTest
//
//  Created by Cui Wei on 1/26/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "RatPolyTest.h"
#import "RatPoly.h"
#import "RatNum.h"
#import "RatTerm.h"

@implementation RatPolyTest

RatNum* num(int i) {
	return [[RatNum alloc] initWithInteger:i];
}

RatNum* numFrac(int numer, int denom) {
	return [[RatNum alloc] initWithNumer:numer Denom:denom];
}


RatTerm* term(int coeff, int expt) {
	return [[RatTerm alloc] initWithCoeff:num(coeff) Exp:expt];
}

RatTerm* termFrac(RatNum* num, int expt) {
	return [[RatTerm alloc] initWithCoeff:num Exp:expt];
}

-(void)testPass{
	STAssertTrue(1==1, @"", @"");
}

- (void)setUp
{
    //RatPoly *zero = [[RatPoly alloc] init];
   // RatNum *nanNum = [num(1) div:num(0)];
    //RatTerm *nanTerm = [[RatTerm alloc] initWithCoeff:nanNum Exp:3];
    //RatPoly *nanPoly = [[RatPoly alloc] initWithTerm:nanTerm];
    
}

-(void)testZeroPoly{
    RatPoly *zero = [[RatPoly alloc] init];
    
    STAssertTrue(zero.terms != nil, @"", @"");
    STAssertTrue(zero.terms.count == 0, @"", @"");
    
    RatPoly *polyOne = [[RatPoly alloc] initWithTerm:term(1, 1)];
    RatPoly *polyTwo = [[RatPoly alloc] initWithTerm:term(-1, 1)];
    
    [polyOne add:polyTwo];
    
}

-(void)testValueOf{
    
    RatPoly *test = [RatPoly valueOf:@"5*x^2-x+1"];
    
    RatTerm *term1 = term(5, 2);
    RatTerm *term2 = term(-1, 1);
    RatTerm *term3 = term(1, 0);
    
    NSArray *myarray = [[NSArray alloc] initWithObjects:term1,term2,term3, nil];
    RatPoly *compare = [[RatPoly alloc] initWithTerms:myarray];
    
    STAssertTrue([test isEqual:compare], @"", @"");
    
    
}
- (void)tearDown
{
   
}

- (void)testAdd
{
    
}

@end
