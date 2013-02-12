//
//  MyPEViewController.m
//  PhysicsEngine
//
//  Created by Cui Wei on 2/12/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "MyPEViewController.h"

@interface MyPEViewController ()

@end

@implementation MyPEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _simulatedWorld = [[MyWorld alloc] init];
    _simulatedWorld.updateViewDelegate = self;
    
    [self setBounds];
    
    PERectangle* rect1 = [[PERectangle alloc] initPERectangleOrigin:CGPointMake(50, 50) Width:60 Height:260 Mass:10 andColor:[UIColor yellowColor]];
    PERectangle* rect2 = [[PERectangle alloc] initPERectangleOrigin:CGPointMake(150, 450) Width:90 Height:30 Mass:10 andColor:[UIColor blueColor]];
    PERectangle* rect3 = [[PERectangle alloc] initPERectangleOrigin:CGPointMake(400, 450) Width:40 Height:200 Mass:10 andColor:[UIColor blackColor]];
    
        
    [self.view addSubview:rect1.drawing];
    [self.view addSubview:rect2.drawing];
    [self.view addSubview:rect3.drawing];
    
    [self.simulatedWorld.objectsInWorld addObject:rect1];
    [self.simulatedWorld.objectsInWorld addObject:rect2];
    [self.simulatedWorld.objectsInWorld addObject:rect3];
    
    [self.simulatedWorld run];
    
    
}


-(void)UpdatePosition{
    
    for (PERectangle* rect in self.simulatedWorld.objectsInWorld)
        [self.view addSubview:rect.drawing];
    
}

-(void)setBounds{
    
    self.upperBound = [PERectangle getUpperHorizontalBoundRectangle];
    self.lowerBound = [PERectangle getLowerHorizontalBoundRectangle];
    self.leftBound = [PERectangle getLeftVerticalBoundRectangle];
    self.rightBound = [PERectangle getRightVerticalBoundRectangle];
    
    [self.view addSubview:self.upperBound.drawing];
    [self.view addSubview:self.lowerBound.drawing];
    [self.view addSubview:self.leftBound.drawing];
    [self.view addSubview:self.rightBound.drawing];
   
    [self.simulatedWorld.objectsInWorld addObject:self.upperBound];
    [self.simulatedWorld.objectsInWorld addObject:self.lowerBound];
    [self.simulatedWorld.objectsInWorld addObject:self.leftBound];
    [self.simulatedWorld.objectsInWorld addObject:self.rightBound];
    
}


- (void)didReceiveMemoryWarning
{
    //PERectangle* rect1 = [PERectangle alloc];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
