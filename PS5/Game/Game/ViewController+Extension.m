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
                                           cancelButtonTitle:CALCEL_BUTTON
                                           otherButtonTitles:OK_BUTTON, nil];
    
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [dialog show];
}



- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if([alertView.title isEqualToString:@"Congratulations"]){
        assert(buttonIndex == 0);
        [self resetButtonPressed:Nil];
        return;
        
    }
    
    if([alertView.title isEqualToString:@"Oops, Game Over"]){
        assert(buttonIndex == 0);
        [self resetButtonPressed:Nil];
        return;
        
    }
    
    if(buttonIndex == 0)
        return;
    
    
    
    
    
    if([alertView.title isEqual:@"Enter file name "]){
      
        
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
    
    BOOL hasSomeThingToSave = NO;
    
    for(UIView* vw in self.gamearea.subviews){
        if(vw.tag >=1 && vw.tag <= 5){
            assert([vw.nextResponder isKindOfClass:GameObject.class]);
            hasSomeThingToSave = YES;
            break;
        }
    }
    
    if(!hasSomeThingToSave){
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
        
        if(view.tag >= 1 && view.tag <= 5){
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
        
        NSLog(@"%@", fileName);
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


-(void)loadDefaultLevel:(NSString*)fileName{
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    
    NSNumber *wolfTag = [[NSNumber alloc] initWithInt:1];
    NSNumber *PigTag = [[NSNumber alloc] initWithInt:2];
    

    
    for(NSString *key in [dictionary allKeys]){
        
        NSArray *data = [dictionary objectForKey:key];
        
        if([[data objectAtIndex:0] isEqual:wolfTag]){ //a wolf is found
            
            CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
            CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
            NSString* transformValue =(NSString*)[data objectAtIndex:3];
            
            GameWolf* tempViewControllerForWolf = [self getGameWolfViewController];
            
            tempViewControllerForWolf.view.center = CGPointMake(X, Y);
            tempViewControllerForWolf.view.bounds = CGRectMake(0, 0,
                                                               2*tempViewControllerForWolf.widthInPalette,
                                                               2*tempViewControllerForWolf.heightInPalette);
            
            CGAffineTransform t = CGAffineTransformFromString(transformValue);
            
            tempViewControllerForWolf.view.transform = t;
            
            tempViewControllerForWolf.view.tag = 1;
            [self.gamearea addSubview:tempViewControllerForWolf.view];
            
            
            tempViewControllerForWolf.model.center = tempViewControllerForWolf.view.center;
            
            CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
            CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
            tempViewControllerForWolf.model.width = 2*tempViewControllerForWolf.widthInPalette * xSize;
            tempViewControllerForWolf.model.height = 2*tempViewControllerForWolf.heightInPalette * ySize;
            tempViewControllerForWolf.model.rotation = -atan2(tempViewControllerForWolf.view.transform.b,
                                                              tempViewControllerForWolf.view.transform.a);
            [tempViewControllerForWolf.model updateMomentOfInertia];
            
            
            
        }
        else if([[data objectAtIndex:0] isEqual:PigTag]){ // a pig is found
            
            CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
            CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
            NSString* transformValue =(NSString*)[data objectAtIndex:3];
            
            GamePig* tempViewControllerForPig = [self getGamePigViewController];
            
            tempViewControllerForPig.view.center = CGPointMake(X, Y);
            tempViewControllerForPig.view.bounds = CGRectMake(0, 0,
                                                              2 * tempViewControllerForPig.widthInPalette,
                                                              2 * tempViewControllerForPig.heightInPalette);
            
            CGAffineTransform t = CGAffineTransformFromString(transformValue);
            
            tempViewControllerForPig.view.transform = t;
            
            tempViewControllerForPig.view.tag = 2;
            
            [self.gamearea addSubview:tempViewControllerForPig.view];
            
            
            tempViewControllerForPig.model.center = tempViewControllerForPig.view.center;
            
            CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
            CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
            tempViewControllerForPig.model.width = 2*tempViewControllerForPig.widthInPalette * xSize;
            tempViewControllerForPig.model.height = 2*tempViewControllerForPig.heightInPalette * ySize;
            tempViewControllerForPig.model.rotation = -atan2(tempViewControllerForPig.view.transform.b,
                                                             tempViewControllerForPig.view.transform.a);
            [tempViewControllerForPig.model updateMomentOfInertia];
            
            
        }else{
            
            int currentTag = [[data objectAtIndex:0] intValue];
            assert(currentTag==3 ||currentTag==4||currentTag==5);
            
            
            CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
            CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
            NSString* transformValue =(NSString*)[data objectAtIndex:3];
            CGAffineTransform t = CGAffineTransformFromString(transformValue);
            
            GameBlock *tempViewControllerForBlock = [[GameBlock alloc] init];
            tempViewControllerForBlock.myDelegate = self;
            [self addChildViewController:tempViewControllerForBlock];
            [self addRecognizer:tempViewControllerForBlock.view :tempViewControllerForBlock];
            tempViewControllerForBlock.view.userInteractionEnabled = YES;
            
            tempViewControllerForBlock.view.center = CGPointMake(X, Y);
            tempViewControllerForBlock.view.bounds = CGRectMake(0, 0,
                                                                tempViewControllerForBlock.widthInPalette,
                                                                4 * tempViewControllerForBlock.heightInPalette);
            tempViewControllerForBlock.view.transform = t;
            
            
            CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
            CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
            tempViewControllerForBlock.model.width = tempViewControllerForBlock.widthInPalette * xSize;
            tempViewControllerForBlock.model.height = 4*tempViewControllerForBlock.heightInPalette * ySize;
            tempViewControllerForBlock.model.rotation = -atan2(tempViewControllerForBlock.view.transform.b,
                                                               tempViewControllerForBlock.view.transform.a);
            [tempViewControllerForBlock.model updateMomentOfInertia];
            
            if(currentTag == 3)
                tempViewControllerForBlock.view.tag = 5;
            else if(currentTag == 4)
                tempViewControllerForBlock.view.tag = 3;
            else
                tempViewControllerForBlock.view.tag = 4;
            
            [tempViewControllerForBlock changeTexture];
            
            [self.gamearea addSubview:tempViewControllerForBlock.view];
            
            tempViewControllerForBlock.model.center = tempViewControllerForBlock.view.center;
            
        }
        
        
        
        
    }
    
    
    
    
}

- (void)loadWithName:(NSString*)loadName{

    [self reset];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@",documentsDirectory,loadName];
    
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
    
    
    NSNumber *wolfTag = [[NSNumber alloc] initWithInt:1];
    NSNumber *PigTag = [[NSNumber alloc] initWithInt:2];
    
    
    for(NSString *key in [dictionary allKeys]){
        
        NSArray *data = [dictionary objectForKey:key];
        
        if([[data objectAtIndex:0] isEqual:wolfTag]){ //a wolf is found
            
            CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
            CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
            NSString* transformValue =(NSString*)[data objectAtIndex:3];
            
            GameWolf* tempViewControllerForWolf = [self getGameWolfViewController];
            
            tempViewControllerForWolf.view.center = CGPointMake(X, Y);
            tempViewControllerForWolf.view.bounds = CGRectMake(0, 0,
                                                               2*tempViewControllerForWolf.widthInPalette,
                                                               2*tempViewControllerForWolf.heightInPalette);
            
            CGAffineTransform t = CGAffineTransformFromString(transformValue);
            
            tempViewControllerForWolf.view.transform = t;
            
            tempViewControllerForWolf.view.tag = 1;
            [self.gamearea addSubview:tempViewControllerForWolf.view];
            
            
            tempViewControllerForWolf.model.center = tempViewControllerForWolf.view.center;
            
            CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
            CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
            tempViewControllerForWolf.model.width = 2*tempViewControllerForWolf.widthInPalette * xSize;
            tempViewControllerForWolf.model.height = 2*tempViewControllerForWolf.heightInPalette * ySize;
            tempViewControllerForWolf.model.rotation = -atan2(tempViewControllerForWolf.view.transform.b,
                                                             tempViewControllerForWolf.view.transform.a);
            [tempViewControllerForWolf.model updateMomentOfInertia];
            
           
            
        }
        else if([[data objectAtIndex:0] isEqual:PigTag]){ // a pig is found
                
                CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
                CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
                NSString* transformValue =(NSString*)[data objectAtIndex:3];
                
            GamePig* tempViewControllerForPig = [self getGamePigViewController];
            
            tempViewControllerForPig.view.center = CGPointMake(X, Y);
            tempViewControllerForPig.view.bounds = CGRectMake(0, 0,
                                                              2 * tempViewControllerForPig.widthInPalette,
                                                              2 * tempViewControllerForPig.heightInPalette);
            
            CGAffineTransform t = CGAffineTransformFromString(transformValue);
            
            tempViewControllerForPig.view.transform = t;
            
            tempViewControllerForPig.view.tag = 2;
            
            [self.gamearea addSubview:tempViewControllerForPig.view];
            
            
            tempViewControllerForPig.model.center = tempViewControllerForPig.view.center;
            
            CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
            CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
            tempViewControllerForPig.model.width = 2*tempViewControllerForPig.widthInPalette * xSize;
            tempViewControllerForPig.model.height = 2*tempViewControllerForPig.heightInPalette * ySize;
            tempViewControllerForPig.model.rotation = -atan2(tempViewControllerForPig.view.transform.b,
                                                             tempViewControllerForPig.view.transform.a);
            [tempViewControllerForPig.model updateMomentOfInertia];

            
        }else{
                
                int currentTag = [[data objectAtIndex:0] intValue];
                assert(currentTag==3 ||currentTag==4||currentTag==5);
            
                
                CGFloat X = [(NSNumber*)[data objectAtIndex:1] floatValue];
                CGFloat Y = [(NSNumber*)[data objectAtIndex:2] floatValue];
                NSString* transformValue =(NSString*)[data objectAtIndex:3];
                CGAffineTransform t = CGAffineTransformFromString(transformValue);
            
               GameBlock *tempViewControllerForBlock = [[GameBlock alloc] init];
               tempViewControllerForBlock.myDelegate = self;
               [self addChildViewController:tempViewControllerForBlock];
               [self addRecognizer:tempViewControllerForBlock.view :tempViewControllerForBlock];
               tempViewControllerForBlock.view.userInteractionEnabled = YES;
            
               tempViewControllerForBlock.view.center = CGPointMake(X, Y);
               tempViewControllerForBlock.view.bounds = CGRectMake(0, 0,
                                                                   tempViewControllerForBlock.widthInPalette,
                                                                   4 * tempViewControllerForBlock.heightInPalette);
               tempViewControllerForBlock.view.transform = t;
            
            
               CGFloat xSize = sqrt(t.a * t.a + t.c * t.c);
               CGFloat ySize = sqrt(t.b * t.b + t.d * t.d);
               tempViewControllerForBlock.model.width = tempViewControllerForBlock.widthInPalette * xSize;
               tempViewControllerForBlock.model.height = 4*tempViewControllerForBlock.heightInPalette * ySize;
               tempViewControllerForBlock.model.rotation = -atan2(tempViewControllerForBlock.view.transform.b,
                                                            tempViewControllerForBlock.view.transform.a);
               [tempViewControllerForBlock.model updateMomentOfInertia];
            
               if(currentTag == 3)
                   tempViewControllerForBlock.view.tag = 5;
               else if(currentTag == 4)
                   tempViewControllerForBlock.view.tag = 3;
               else
                   tempViewControllerForBlock.view.tag = 4;
            
               [tempViewControllerForBlock changeTexture];
            
               [self.gamearea addSubview:tempViewControllerForBlock.view];
            
               tempViewControllerForBlock.model.center = tempViewControllerForBlock.view.center;

            }
         
          
      
    
    }
    
    
    
}



- (void)reset{

    for(UIViewController* controller in self.childViewControllers){
        if([controller isKindOfClass:GameObject.class])
            [(GameObject*)controller restore];
    }
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


-(GameWolf*)getGameWolfViewController{
    for(UIViewController *controller in self.childViewControllers)
        if([controller isKindOfClass:GameWolf.class])
            return (GameWolf*)controller;
    return Nil;
}

-(GamePig*)getGamePigViewController{
    for(UIViewController *controller in self.childViewControllers)
        if([controller isKindOfClass:GamePig.class])
            return (GamePig*)controller;
    
    return Nil;
}

-(Aimer*)getAimerViewController{
    for(UIViewController *controller in self.childViewControllers)
        if([controller isKindOfClass:Aimer.class])
            return (Aimer*)controller;
    
    return Nil;
}

-(PowerMeter*)getPowerMeterViewController{
    for(UIViewController *controller in self.childViewControllers)
        if([controller isKindOfClass:PowerMeter.class])
            return (PowerMeter*)controller;
    
    return Nil;
}

-(PECircleViewController*)getPuffViewController{
    for(UIViewController *controller in self.childViewControllers)
        if([controller isKindOfClass:PECircleViewController.class])
            return (PECircleViewController*)controller;
    
    return Nil;
}


@end
