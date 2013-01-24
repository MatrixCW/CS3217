//
//  Overlaps.m
//  
//  CS3217 || Assignment 1
//  Name: Cui Wei
//

#import <Foundation/Foundation.h>

// Import PERectangle here
#import "PERectangle.h"


int test(void);

// define structure Rectangle
// <definition for struct Rectangle here>

struct Rectangle{
    
    CGFloat topLeftX;
    CGFloat topLeftY;
    CGFloat width;
    CGFloat height;
    
} ;


int overlaps(struct Rectangle rect1, struct Rectangle rect2) {
  // EFFECTS: returns 1 if rectangles overlap and 0 otherwise
  
    
    //get the sides of the first rectangle
    CGFloat upSide1 = rect1.topLeftY;
    CGFloat downSide1 = upSide1 - rect1.height;
    CGFloat leftSide1 = rect1.topLeftX;
    CGFloat rightSide1 = leftSide1 + rect1.width;
    
    //get the sides of the second rectangle
    CGFloat upSide2 = rect2.topLeftY;
    CGFloat downSide2 = upSide2 - rect2.height;
    CGFloat leftSide2 = rect2.topLeftX;
    CGFloat rightSide2 = leftSide2 + rect2.width;
    
    //get the total region along the y-aixs that are occupied by the two rectangles
    CGFloat totalHeight = fmax(fabs(upSide1 - downSide2),fabs(upSide2 - downSide1));
    
    
    
    
    //get the total region along the x-axis that are occupied by the two rectangles
    CGFloat totalWidth = fmax(fabs(leftSide1 - rightSide2),fabs(leftSide2 - rightSide1));
    
    
    CGFloat heightSum = rect1.height + rect2.height;
    CGFloat widthSum = rect1.width + rect2.width;

    
    //no overlapping indicates must be a region between two rectangles
    //which will cause the totalHeight larger that heightSum or
    //totalWidth larger than widthSum
    if(totalHeight > heightSum || totalWidth > widthSum)
      return 0;
    else
      return 1;

}


int main (int argc, const char * argv[]) {
	
	/* Problem 1 code (C only!) */
    
    
    int indicator = test();
    
    if(indicator == 1)
        printf("all test cases passed !\n");
        
    // declare rectangle 1 and rectangle 2

    
    struct Rectangle rectangleOne;
    struct Rectangle rectangleTwo;
    
    // input origin for rectangle 1
    
	printf("Input <x y> coordinates for the origin of the first rectangle: ");
    scanf("%lf %lf", &rectangleOne.topLeftX, &rectangleOne.topLeftY);
	
    // input size (width and height) for rectangle 1
    
    printf("Input width and height for the first rectangle: ");
    scanf("%lf %lf",&rectangleOne.width, &rectangleOne.height);
    
    assert(rectangleOne.width>0 && rectangleOne.height>0);
	
	// input origin for rectangle 2
    
    printf("Input <x y> coordinates for the origin of the second rectangle: ");
    scanf("%lf %lf",&rectangleTwo.topLeftX, &rectangleTwo.topLeftY);
	
	// input size (width and height) for rectangle 2
    
    printf("Input width and height for the second rectangle: ");
    scanf("%lf %lf",&rectangleTwo.width, &rectangleTwo.height);
    
    assert(rectangleTwo.width>0 && rectangleTwo.height>0);
    
    
    // check if overlapping and write message
    
    if (overlaps(rectangleOne,rectangleTwo))
        printf("The two rectangles are overlapping! \n");
    else
        printf("The two rectangles are not overlapping \n");
     
  
/*----------------------------------------------------------------------------------------*/
    
    
    /* Problem 2 code (Objective-C) */
	// declare rectangle 1 and rectangle 2 objects
    
    
    
    
    CGPoint origin1 = CGPointMake(rectangleOne.topLeftX,rectangleOne.topLeftY);
    PERectangle* rect1 = [[PERectangle alloc] initWithOrigin:origin1 width:rectangleOne.width height:rectangleOne.height rotation:0];
    
    
    CGPoint origin2 = CGPointMake(rectangleTwo.topLeftX,rectangleTwo.topLeftY);
    PERectangle* rect2 = [[PERectangle alloc] initWithOrigin:origin2 width:rectangleTwo.width height:rectangleTwo.height rotation:0];
    
	
    // input rotation for rectangle 1 and 2
    CGFloat rotateAngle1, rotateAngle2;
    
    printf("Input rotation angle for the first rectangle: ");
    scanf("%lf", &rotateAngle1);
    
    printf("Input rotation angle for the second rectangle: ");
    scanf("%lf", &rotateAngle2);
    
    [rect1 rotate:rotateAngle1];
    [rect2 rotate:rotateAngle2];
	
	// check if rectangle objects overlap and write message
    
    if([rect1 overlapsWithShape:rect2])
        printf("The two rectangle objects are overlapping! \n");
    else
        printf("The two rectangle objects are not overlapping! \n");
    
        
    // clean up
    
    [rect1 dealloc];
    [rect2 dealloc];

	// exit program
    
    return 0;
    
}

// This is where you should put your test cases to test that your implementation is correct. 
int test() {
    // EFFECTS: returns 1 if all test cases are successfully passed and 0 otherwise
    struct Rectangle rect1, rect2;
    
    // Only one point is touching:
    rect1.topLeftX = 0;    rect1.topLeftY = 0;    rect1.width = 10;   rect1.height = 20;
    rect2.topLeftX = 10;   rect2.topLeftY = 10;   rect2.width = 20;   rect2.height = 10;
    if (!overlaps(rect1, rect2)){
        return 0;
    }
    
    // Two identical rectangles:
    rect1.topLeftX = 5;    rect1.topLeftY = 5;    rect1.width = 5;    rect1.height = 10;
    rect2.topLeftX = 5;    rect2.topLeftY = 5;    rect2.width = 5;    rect2.height = 10;
    if (!overlaps(rect1, rect2)){
        return 0;
    }
    
    // One is completely contained in another:
    rect1.topLeftX = 0;    rect1.topLeftY = 0;    rect1.width = 20;   rect1.height = 20;
    rect2.topLeftX = 5;    rect2.topLeftY = -5;   rect2.width = 10;   rect2.height = 10;
    if (!overlaps(rect1, rect2)){
        return 0;
    }
    
    // One edge is touching:
    rect1.topLeftX = 0;    rect1.topLeftY = 0;    rect1.width = 5;    rect1.height = 5;
    rect2.topLeftX = 5;    rect2.topLeftY = 3;    rect2.width = 8;    rect2.height = 5;
    if (!overlaps(rect1, rect2)){
        return 0;
    }
    
    // Cross overlapping (like a cross)
    rect1.topLeftX = 0;    rect1.topLeftY = 0;    rect1.width = 20;   rect1.height = 5;
    rect2.topLeftX = 10;   rect2.topLeftY = 10;   rect2.width = 5;    rect2.height = 20;
    if (!overlaps(rect1, rect2)){
        return 0;
    }
    
    // Two are seperated by one integer:
    rect1.topLeftX = 0;    rect1.topLeftY = 0;    rect1.width = 10;   rect1.height = 20;
    rect2.topLeftX = 11;   rect2.topLeftY = 10;   rect2.width = 20;   rect2.height = 10;
    if (overlaps(rect1, rect2)){
        return 0;
    }
    
    // Two are seperated trigonomically:
    rect1.topLeftX = -10;  rect1.topLeftY = 10;   rect1.width = 5;    rect1.height = 5;
    rect2.topLeftX = 0;    rect2.topLeftY = 0;    rect2.width = 5;    rect2.height = 5;
    if (overlaps(rect1, rect2)){
        return 0;
    }
    
    
    //test 1 and test 2 are disjoint rectangles:
    PERectangle* test1 = [[PERectangle alloc] initWithOrigin:CGPointMake(0, 0) width:2 height:2 rotation:0];
    PERectangle* test2 = [[PERectangle alloc] initWithOrigin:CGPointMake(5, 5) width:1 height:1 rotation:0];
    
    assert(test1.width == 2 && test1.height == 2 &&
           test2.rotation == 0 &&
           test2.origin.x == 5 && test2.origin.y == 5);
    
       
    //assert([test1 isSameSideRectLinePointOne:CGPointMake(-1.035, 3.5) LinePointTwo:CGPointMake(2.5, 7.035) Rectangle:[test2 corners]] == YES);
    assert([test1 isSameSideLinePointOne:CGPointMake(-1.035, 3.5) LinePointTwo:CGPointMake(2.5, 7.035) testPointOne:CGPointMake(0, 0) testPointFour:CGPointMake(6.035, 3.5)] ==YES);
    
    assert([test1 overlapsWithShape:test2] == NO);
    
    //test 3 is contained in test 4:
    PERectangle* test3 = [[PERectangle alloc] initWithOrigin:CGPointMake(1, -1) width:2 height:2 rotation:0];
    PERectangle* test4 = [[PERectangle alloc] initWithOrigin:CGPointMake(0, 0) width:5 height:5 rotation:0];
    
    assert(test3.width == 2 && test3.height == 2 &&
           test3.rotation == 0 &&
           test3.origin.x == 1 && test3.origin.y == -1);
    
    assert([test3 overlapsWithShape:test4] == YES);
     
    
    //test 5 not overlap with test6
    PERectangle* test5 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,6) width:5 height:5 rotation:0];
    PERectangle* test6 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,0) width:5 height:5 rotation:0];
    
    
    assert(test5.center.x == 2.5 && test5.center.y == 3.5);
    
    //assert([test5 overlapsWithShape:test6] == NO);
    
    //test 5  overlap with test6 after rotation 45 degrees:
    
    [test5 rotate:45];
    
   
    assert([test5 isSameSideLinePointOne:CGPointMake(0,0) LinePointTwo:CGPointMake(5,0) testPointOne:CGPointMake(2.5,-0.035534) testPointFour:CGPointMake(6.03,3.5)] == NO);

    
    assert([test5 overlapsWithShape:test6] == YES);
    
    //test7  overlap with test8
    PERectangle* test7 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,6) width:5 height:5 rotation:45];
    PERectangle* test8 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,0) width:5 height:5 rotation:0];
    assert([test7 overlapsWithShape:test8] == YES);
    assert(test7.rotation==45);
    
    //overlap with one vertex
    PERectangle* test9 = [[PERectangle alloc] initWithOrigin:CGPointMake(-5,5) width:5 height:5 rotation:0];
    PERectangle* test10 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,0) width:5 height:5 rotation:0];
    assert([test9 overlapsWithShape:test10] == YES);
    assert(test9.corners[0].x == -5 && test9.corners[0].y == 5 && test9.corners[1].x==0&&test9.corners[1].y==5&&
           test9.corners[2].x == 0&&test9.corners[2].y == 0&&test9.corners[3].x==-5&&test9.corners[3].y==0);
    //printf("case 10 passed\n");
    
    //overlap with one side
    PERectangle* test11 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,5) width:5 height:5 rotation:0];
    PERectangle* test12 = [[PERectangle alloc] initWithOrigin:CGPointMake(0,0) width:5 height:5 rotation:0];
    assert([test11 overlapsWithShape:test12]==YES);
    assert(test11.corners[0].x == 0&&test11.corners[0].y == 5&&test11.corners[1].x==5&&test11.corners[1].y==5&&
           test11.corners[2].x == 5&&test11.corners[2].y == 0&&test11.corners[3].x==0&&test11.corners[3].y==0);
    //printf("case 11 passed\n");
    
    
    [test11 translateX:5 Y:5];
    assert(test11.origin.x==5&&test11.origin.y==10);
    //printf("case 12 passed\n");
    
    PERectangle* test13 = [[PERectangle alloc] initWithRect:CGRectMake(0, 5, 5, 5)];
    assert(test13.width==5&&test13.height==5&&test13.origin.x==0&&test13.origin.y==5);
    assert([test13 overlapsWithShape:test12]==YES);
    assert([test13 center].x == 2.5 && [test13 center].y == 2.5);
    //printf("case 13 passed\n");
    
    
    // If all cases are correct, return 1:
    return 1;
}




/* 

Question 2(h)
========

a rectangle can also be represented by the top-left point and bottom right point
 
 pros: in this way a rectangle can be specified by only two variables instead of three
       and to compute center of mass is easy
 cons: in order to properly create a rectangle in this way, the variables must be checked:
       i.e., topLeft.x < bottomRight.x, and topLeft.y > bottomRight.y.
 
 pros: for this original way: natural and easy to understand, need not checking data validity
       as long as height and width are all positive values
 cons: not obvious cons, a good solution



Question 2(i): Reflection (Bonus Question)
==========================
(a) How many hours did you spend on each problem of this problem set?

   More than 20 hours.

(b) In retrospect, what could you have done better to reduce the time you spent solving this problem set?

   1.If I could be more familiar with Objective-C, everything will be much simpler.
   2.I spent quite some time figuring out how to use git and github.
   3.Perhaps I am not intelligent enough, but I feel the problem description is ambiguous, also the organization of the functions in PERectangle.m is really weird and unnatural, I spent quite some time discussing with my friends to get the idea. Perhaps the next time we should be given more freedom to implement the class in our own way instead of using template.

(c) What could the CS3217 teaching staff have done better to improve your learning experience in this problem set?

   1. I do not know who are our TAs, but I think I did not see enough answers posted in the forum by the TAs, most of the time
      it's Dr Sim Khe Chai answering our questions, which may not be enough because his time and energy are limited.
   2. I believe most of us CS3217 students this semester are new to Xcode and Objective-c, perhaps it would be better
    if we could spend less time introducing this module in week 1, but more time on the techinical stuff.
*/
