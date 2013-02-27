//
//  ViewController+Extension.m
//  Game
//
//  Created by Cui Wei on 1/31/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController+Extension.h"

#define INITIAL_VIEW_COUNT 4


@implementation ViewController (Extension)



-(void)popOutWindowForFileName{
    
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter file name "
                                                     message:@"Use same file name as an existing file to over-write it"
                                                    delegate:self
                                           cancelButtonTitle:CALCEL_BUTTON
                                           otherButtonTitles:OK_BUTTON, nil];
    
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
        
      if(textField.text != Nil && ![textField.text isEqual:@""])
        [self saveWithFileName:textField.text];
      
      else{
          
          UIAlertView* savingAborted = [[UIAlertView alloc] initWithTitle:@"Saving aborted!"
                                                           message:Nil
                                                          delegate:self
                                                 cancelButtonTitle:OK_BUTTON
                                                 otherButtonTitles:Nil];
          [savingAborted show];
          }
                
     }

}



- (void)save {
    
    
    if(self.gamearea.subviews.count == INITIAL_VIEW_COUNT){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"It seems that you haven't made any changes in current game view"
                                                       delegate:self
                                              cancelButtonTitle:@"Oh I see."
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        
        [self popOutWindowForFileName];
        
    }

}





-(void)saveWithFileName:(NSString*)myFileName{
// REQUIRES: myFileName not null and not equals @""
// EFFECTS: save the game state as a dictionary to document directory
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SUCCESS"
                                                  message:@"Your game data has been stored."
                                                  delegate:self
                                                  cancelButtonTitle:@"Got it"
                                                  otherButtonTitles:nil];
        [alert show];
     }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                        message:@"An Error occurred. Your game data did not save successfully"
                                                       delegate:self
                                                       cancelButtonTitle:@"Got it"
                                                       otherButtonTitles:nil];
        [alert show];
    }

}




-(void) deleteFileWithName:(NSString*)fileName{
// MODIFIES: game data stored in document directory
// REQUIRES: fileName not null and not equals @""
// EFFECTS: delete the file with the specified name
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *fileNameRm = [NSString stringWithFormat:@"%@/%@", documentsDirectory,fileName];
    if ([fileMgr removeItemAtPath:fileNameRm error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    
}



- (void)loadWithName:(NSString*)loadName{
// MODIFIES: gameArea
// REQUIRES: loadName a valid name of a game data stored in the document directory
// EFFECTS: change to gameArea to the state as loadName file specifies
    
    [self reset];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@",documentsDirectory,loadName];
    
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
// REQUIRES: transform not equal to null
// EFFECTS: reset the gameArea
    
    [self.myWolf releaseObject];
    [self.myPig releaseObject];
    
    
    GameBlock *tempBlock = self.myRootBlock;
    
    while(tempBlock.view.superview != self.selectBar){
        
            [tempBlock releaseObject];
            tempBlock = tempBlock.nextGameBlock;
    }
    
    self.myCurrentBlock = tempBlock;
    self.myRootBlock = tempBlock;
    
}


-(NSArray*)getAllFilesUnderGameDirectory{
    //EFFECTS: return an array of strings of the fileNames under the document directory

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSError *browseError;
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray *files = [fileManager contentsOfDirectoryAtPath:documentsDirectory
                                                      error:&browseError];
    
    return files;
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//comform to the UIActionSheetDelegate protocal
    
    
    NSArray *files = [self getAllFilesUnderGameDirectory];
    
    
    if ([actionSheet.title isEqual:CHOOSE_FILE_TO_DELETE] && buttonIndex>=0 && buttonIndex < files.count){
        NSString *deleteFileName = [actionSheet buttonTitleAtIndex:buttonIndex];
        [self deleteFileWithName:deleteFileName];
        return;
    }
    
    
    if ([actionSheet.title isEqual:CHOOSE_FILE_TO_LOAD] && buttonIndex>=0 && buttonIndex < files.count){
        NSString *loadFileName = [actionSheet buttonTitleAtIndex:buttonIndex];
        [self loadWithName:loadFileName];
        return;
    }
    
    
}


-(NSString*)getStringOfTransform:(CGAffineTransform)transform{
// REQUIRES: transform not equal to null
// EFFECTS: return a string representation of the transform
    
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

@end
