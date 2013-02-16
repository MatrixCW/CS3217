//
//  MyPEViewController.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "MyPEViewController.h"



@implementation MyPEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _simulatedWorld = [[MyWorld alloc] init];
    
   
    
    
   
            
    PERectangleViewController* test = [[PERectangleViewController alloc] initPERectangleWithCenter:CGPointMake(300, 380)
                                                                                             Width:50
                                                                                            Height:50
                                                                                              mass:20
                                                                                          andColor:[UIColor greenColor]];
    [self addChildViewController:test];
    [self.simulatedWorld.objectsInWorld addObject:test.model];
    [self.view addSubview:test.view];
    
    
    PERectangleViewController* test2 = [[PERectangleViewController alloc] initPERectangleWithCenter:CGPointMake(620, 60)
                                                                                             Width:200
                                                                                            Height:80
                                                                                              mass:40
                                                                                          andColor:[UIColor blueColor]];
    [self addChildViewController:test2];
    [self.simulatedWorld.objectsInWorld addObject:test2.model];
    [self.view addSubview:test2.view];
    
    PERectangleViewController* test3 = [[PERectangleViewController alloc] initPERectangleWithCenter:CGPointMake(300, 180)
                                                                                              Width:150
                                                                                             Height:226
                                                                                               mass:45
                                                                                           andColor:[UIColor blackColor]];
    [self addChildViewController:test3];
    [self.simulatedWorld.objectsInWorld addObject:test3.model];
    [self.view addSubview:test3.view];
    
    
    PERectangleViewController* test4 = [[PERectangleViewController alloc] initPERectangleWithCenter:CGPointMake(340, 711)
                                                                                              Width:46
                                                                                             Height:230
                                                                                               mass:59
                                                                                           andColor:[UIColor redColor]];
    [self addChildViewController:test4];
    [self.simulatedWorld.objectsInWorld addObject:test4.model];
    [self.view addSubview:test4.view];
    
    
    PERectangleViewController* test5 = [[PERectangleViewController alloc] initPERectangleWithCenter:CGPointMake(130, 335)
                                                                                              Width:86
                                                                                             Height:154
                                                                                               mass:99
                                                                                           andColor:[UIColor yellowColor]];
    [self addChildViewController:test5];
    [self.simulatedWorld.objectsInWorld addObject:test5.model];
    [self.view addSubview:test5.view];
    
    
    PERectangleViewController* test6 = [[PERectangleViewController alloc] initPERectangleWithCenter:CGPointMake(560, 445)
                                                                                              Width:150
                                                                                             Height:325
                                                                                               mass:56
                                                                                           andColor:[UIColor grayColor]];
    [self addChildViewController:test6];
    [self.simulatedWorld.objectsInWorld addObject:test6.model];
    [self.view addSubview:test6.view];
    
        
            
    

     
    [self setBounds];
    
    [self.simulatedWorld run];
    
}



-(void)setBounds{
    
    PERectangleViewController* upperHorizontal = [PERectangleViewController getUpperHorizontalBoundRectangle];
    PERectangleViewController* lowerHorizontal = [PERectangleViewController getLowerHorizontalBoundRectangle];
    PERectangleViewController* leftVertical = [PERectangleViewController getLeftVerticalBoundRectangle];
    PERectangleViewController* rightVertical = [PERectangleViewController getRightVerticalBoundRectangle];
    /*
    [self addChildViewController:upperHorizontal];
    [self addChildViewController:lowerHorizontal];
    [self addChildViewController:leftVertical];
    [self addChildViewController:rightVertical];
     */
    
    [self.simulatedWorld.objectsInWorld addObject:upperHorizontal.model];
    [self.simulatedWorld.objectsInWorld addObject:lowerHorizontal.model];
    [self.simulatedWorld.objectsInWorld addObject:leftVertical.model];
    [self.simulatedWorld.objectsInWorld addObject:rightVertical.model];
    
    [self.view addSubview:upperHorizontal.view];
    [self.view addSubview:lowerHorizontal.view];
    [self.view addSubview:leftVertical.view];
    [self.view addSubview:rightVertical.view];
    
    
}


- (void)didReceiveMemoryWarning
{
    //PERectangle* rect1 = [PERectangle alloc];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
