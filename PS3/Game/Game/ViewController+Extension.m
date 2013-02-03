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
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/dictionay", documentsDirectory];
    
    NSArray* subviewsArray = [[NSArray alloc] initWithArray:self.gamearea.subviews];
    
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    
    int appendkey = 0;
    NSString* empty = @"";
    
    for (UIView* view in subviewsArray) {
        
        if (view.tag == 1||view.tag == 2||view.tag == 3) {
            printf("when save tag = %d\n",view.tag);
            NSNumber* tag = [[NSNumber alloc] initWithInt:view.tag];
            NSNumber* X = [[NSNumber alloc] initWithFloat:view.center.x];
            NSNumber* Y = [[NSNumber alloc] initWithFloat:view.center.y];
            NSString* transform = [self getStringOfTransform:view.transform];
            NSArray* object = [[NSArray alloc] initWithObjects:tag,X,Y,transform, nil];
            NSString* key = [empty stringByAppendingFormat:@"%d",appendkey];
            appendkey++;
            [dictionary setObject:object forKey:key];
        }
    }
    
    if([dictionary writeToFile:fileName atomically:YES]==YES){
        NSLog(@"恭喜，SAVE成功");
    }
   
    
}


-(NSString*)getStringOfTransform:(CGAffineTransform)transform{
    NSString* str = @"";
    CGFloat a = transform.a;
    CGFloat b = transform.b;
    CGFloat c = transform.c;
    CGFloat d = transform.d;
    CGFloat tx = transform.tx;
    CGFloat ty = transform.ty;
    str = [str stringByAppendingFormat:@"{%lf,%lf,%lf,%lf,%lf,%lf}",a,b,c,d,tx,ty];
    return str;
}





- (void)load{
    NSLog(@"I can load");
    
    NSLog(@"%@", [self.myWolf getStringRepresentation]);
    
    //[NSHomeDirectory()
                                   // stringByAppendingPathComponent:@"Documents"];
    
       
    //self.myWolf.view.center = CGPointMake(300, 300);
    //self.myWolf.view.transform = CGAffineTransformIdentity;
    //[self.gamearea addSubview:self.myWolf.view];
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
