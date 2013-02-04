//
//  ViewController+Extension.m
//  Game
//
//  Created by Cui Wei on 1/31/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController+Extension.h"

@implementation ViewController (Extension)


-(void)popOutWindowForFileName{
    
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter file name "
                                                     message:@"Use same file name as an existing file to over-write it"
                                                    delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           otherButtonTitles:@"OK", nil];
    
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [dialog show];
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0){
        return;
    }
    else{
      
      UITextField* textField = [alertView textFieldAtIndex:0];
      NSLog(@"%@", textField.text);
      if(textField.text != Nil && textField.text != @"")
        [self saveWithFileName:textField.text];
      else{
          
          UIAlertView* savingAborted = [[UIAlertView alloc] initWithTitle:@"Saving aborted!"
                                                           message:Nil
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:Nil];
          [savingAborted show];
          }
                
     }

}


-(void) deleteFileWithName:(NSString*)fileName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *fileNameRm = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileName];
    if ([fileMgr removeItemAtPath:fileNameRm error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    
}


- (void)save {
    
    if(self.gamearea.subviews.count == 4){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"It seems that you haven't made any changes in current game view"
                                                       delegate:self
                                              cancelButtonTitle:@"Oh I see."
                                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }else{
        [self popOutWindowForFileName];
    }

}

-(void)saveWithFileName:(NSString*)myFileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", documentsDirectory,myFileName];
    
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    
    int keyCount = 0;
    NSString* keyValue = @"";
    
    for (UIView* view in self.gamearea.subviews) {
        
        if(view.tag >= 1){
            NSNumber* tag = [[NSNumber alloc] initWithInt:view.tag];
            NSNumber* X = [[NSNumber alloc] initWithFloat:view.center.x];
            NSNumber* Y = [[NSNumber alloc] initWithFloat:view.center.y];
            NSString* transform = [self getStringOfTransform:view.transform];
            NSArray* data = [[NSArray alloc] initWithObjects:tag,X,Y,transform, nil];
            NSString* key = [keyValue stringByAppendingFormat:@"%d",keyCount];
            keyCount++;
            [dictionary setObject:data forKey:key];
        }
        
        
        
        
    }
    
    
    if([dictionary writeToFile:fileName atomically:YES]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SUCCESS" message:@"Your game data has been stored." delegate:self cancelButtonTitle:@"Got it" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                        message:@"AnError occurred. Your game data did not save successfully"
                                                       delegate:self
                                                       cancelButtonTitle:@"Got it"
                                                       otherButtonTitles:nil];
        [alert show];
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
    
    [self reset];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/gameData",documentsDirectory];
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    
    
    NSNumber *wolfTag = [[NSNumber alloc] initWithInt:kGameObjectWolf];
    NSNumber *PigTag = [[NSNumber alloc] initWithInt:kGameObjectPig];
    
    
    for(NSString *key in [dictionary allKeys]){
        
        NSArray *data = [dictionary objectForKey:key];
        
        if([[data objectAtIndex:0] isEqual:wolfTag]){ //a wolf is found
            
            CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
            CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
            NSString* transformValue =(NSString*)[data objectAtIndex:3];
            
            [self.myWolf moveToTarget:CGPointMake(X, Y)
                         withTransform:CGAffineTransformFromString(transformValue)];
        }else
            if([[data objectAtIndex:0] isEqual:PigTag]){ // a pig is found
                
                CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
                CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
                NSString* transformValue =(NSString*)[data objectAtIndex:3];
                
                [self.myPig moveToTarget:CGPointMake(X, Y)
                            withTransform:CGAffineTransformFromString(transformValue)];
                
            }else{
                
                NSLog(@"%d", self.myCurrentBlock.view.superview == self.selectBar);
                
                int currentTag = [[data objectAtIndex:0] intValue];
                
                assert(currentTag==3 ||currentTag==4||currentTag==5);
                
                int count = (currentTag - kGameObjectBlock)%3;
                
                CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
                CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
                NSString* transformValue =(NSString*)[data objectAtIndex:3];
                                          
                [self.myCurrentBlock moveToTarget:CGPointMake(X, Y)withTransform:CGAffineTransformFromString(transformValue) andTexture:count];
                                          
                                          
                self.myCurrentBlock.nextGameBlock = [[GameBlock alloc] initWithBackground:self.gamearea :self.selectBar];
                
                self.myCurrentBlock = self.myCurrentBlock.nextGameBlock;
                
                assert(self.myCurrentBlock != nil);
                
                [self.selectBar addSubview:self.myCurrentBlock.view];

            }
      
    
    }
    
    
    
}



- (void)reset{
    
    
    [self.myWolf releaseObject];
    
    [self.myPig releaseObject];
    
    
    GameBlock *tempBlock = self.myRootBlock;
    
    while(tempBlock.view.superview != self.selectBar){
        
            [tempBlock releaseObject];
            tempBlock = tempBlock.nextGameBlock;
        
    }
    
    self.myCurrentBlock = tempBlock; //muCurrentBlock always points to the block located at the 
    
    
}




@end
