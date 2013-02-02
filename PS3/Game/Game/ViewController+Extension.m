//
//  ViewController+Extension.m
//  Game
//
//  Created by Cui Wei on 1/31/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController+Extension.h"

@implementation ViewController (Extension)
- (void)save {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你马了个逼"
                                                    message:@"You must be connected to the internet to use this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];    
    
}


- (void)load{
    NSLog(@"I can load");
}



- (void)reset{
    
    
    [self.myWolf releaseObject];
    
    [self.myPig releaseObject];
    
    GameBlock *tempBlock = self.myBlock;
    
    while(tempBlock != Nil){
        
        if(tempBlock.view.superview == self.selectBar)
            break;
        else{
           [tempBlock releaseObject];
            tempBlock = tempBlock.nextGameBlock;
        }
        
    }
    
    
     
    

}

@end
