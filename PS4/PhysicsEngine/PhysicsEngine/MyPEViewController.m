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
    
    [self setBounds];
    
    
    for(int i = 0; i< 2; i++)
        for(int j=0 ;j < 2; j++){
            
            PERectangleViewController* test = [[PERectangleViewController alloc] initPERectangleOrigin:CGPointMake(10*i, 10*j) Width:5 Height:5 mass:99 andColor:[UIColor greenColor]];
            [self addChildViewController:test];
            [self.simulatedWorld.objectsInWorld addObject:test.model];
            [self.view addSubview:test.view];
        }
    

    
    [self.simulatedWorld run];
    
}



-(void)setBounds{
    
    PERectangleViewController* upperHorizontal = [PERectangleViewController getUpperHorizontalBoundRectangle];
    PERectangleViewController* lowerHorizontal = [PERectangleViewController getLowerHorizontalBoundRectangle];
    PERectangleViewController* leftVertical = [PERectangleViewController getLeftVerticalBoundRectangle];
    PERectangleViewController* rightVertical = [PERectangleViewController getRightVerticalBoundRectangle];
    
    [self addChildViewController:upperHorizontal];
    [self addChildViewController:lowerHorizontal];
    [self addChildViewController:leftVertical];
    [self addChildViewController:rightVertical];
    
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