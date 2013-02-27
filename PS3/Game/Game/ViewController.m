//
//  ViewController.m
//  Game
//
//  Created by Cui Wei on 1/23/13.
//  Copyright (c) 2013 nus.cs3217. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Extension.h"




@interface ViewController ()

@end

@implementation ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// Rotation 6.0

// Tell the system It should autorotate
- (BOOL) shouldAutorotate {
    return YES;
}

// Tell the system which initial orientation we want to have
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
    
}

// Tell the system what we support
-(NSUInteger)supportedInterfaceOrientations
{
    // return UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskAll;
    // return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    
    //Load the image into UIImage objects
    UIImage *bgImage = [UIImage imageNamed:@"background.png"];
    UIImage *groundImage = [UIImage imageNamed:@"ground.png"];
    
    //Place each of them into a UIImageView
    
    //CGRect rect = CGRectMake(0, 0, 1024, 748);
    ///CGImageRef imageRef = CGImageCreateWithImageInRect([bgImage CGImage], rect);
    ////UIImage *img = [UIImage imageWithCGImage:imageRef];
    //CGImageRelease(imageRef);
    
    UIImageView *background = [[UIImageView alloc] initWithImage:bgImage ];
    UIImageView *ground = [[UIImageView alloc] initWithImage:groundImage ];
    
    //Get the width and height of the two images
    CGFloat backgroundWidth = bgImage.size.width;
    CGFloat backgroundHeight = bgImage.size.height;
    CGFloat groundWidth = groundImage.size.width;
    CGFloat groundHeight = groundImage.size.height;
    
    //Compute the y position for the two UIImageView
    CGFloat groundY = _gamearea.frame.size.height - groundHeight;
    CGFloat backGroundY = groundY - backgroundHeight;
    
    //The frame property holds the position and size of the views
    //The CGRectMake methods arguments are : x position, y position, width, height
    background.frame = CGRectMake(0, backGroundY, backgroundWidth, backgroundHeight);
    ground.frame = CGRectMake(0, groundY, groundWidth, groundHeight);
    
    //Add these views as subviews of the gamearea
    [_gamearea addSubview:background];
    
    
    [_gamearea addSubview:ground];
   
    
    //Set the content size so the gamearea is scrollable
    //Otherwise it defaults to the current window size

    
    CGFloat gameareaHeight = backgroundHeight + groundHeight;  //Don't want scrollable vertically
    CGFloat gameareaWidth = backgroundWidth;
    [_gamearea setContentSize:CGSizeMake(gameareaWidth, gameareaHeight)];
    

    _myWolf = [[GameWolf alloc] initWithBackground:self.gamearea :self.selectBar];
    [_selectBar addSubview:_myWolf.view];
    
    
    
    _myPig = [[GamePig alloc] initWithBackground:self.gamearea :self.selectBar];
    [_selectBar addSubview:_myPig.view];
    
    
    _myRootBlock = [[GameBlock alloc] initWithBackground:self.gamearea :self.selectBar];
    [_selectBar addSubview:_myRootBlock.view];
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonPressed:(id)sender {
    
    
    [self reset];
    
}

- (IBAction)saveButtonPressed:(id)sender {
   
    [self save];
}


- (IBAction)loadButtonPressed:(id)sender {
    

    
    NSArray *files = [self getAllFilesUnderGameDirectory];
    
    if(files.count == 0){ //currently no file saved
        
        UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:NO_DATA_STORED
                                                         message:Nil
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [dialog show];
    }
    else{
        
        UIActionSheet *browseActionSheet = [[UIActionSheet alloc] initWithTitle:CHOOSE_FILE_TO_LOAD
                                                                  delegate:self
                                                                  cancelButtonTitle:nil
                                                                  destructiveButtonTitle:nil
                                                                  otherButtonTitles:nil];
        
        for (NSString* name in files) {
            
            [browseActionSheet addButtonWithTitle: name];
            
        }
        
        browseActionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        
        [browseActionSheet showFromBarButtonItem: self.myLoadButton animated:YES];
        
    }

}



- (IBAction)deleteButtonPressed:(id)sender {
    
    NSArray *files = [self getAllFilesUnderGameDirectory];

    if(files.count == 0){
        
        UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:NO_DATA_STORED
                                                        message:Nil
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [dialog show];
        
    }
    else{
    
    UIActionSheet *browseActionSheet = [[UIActionSheet alloc] initWithTitle:CHOOSE_FILE_TO_DELETE
                                                              delegate:self
                                                              cancelButtonTitle:nil
                                                              destructiveButtonTitle:nil
                                                              otherButtonTitles:nil];
        for (NSString* name in files)  
              [browseActionSheet addButtonWithTitle: name];
        
    browseActionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    [browseActionSheet showFromBarButtonItem: self.myDeleteButton animated:YES];
    
    }
    
   
}




- (void)viewDidUnload {
    [self setSelectBar:nil];
    [self setMyDeleteButton:nil];
    [self setMyLoadButton:nil];
    [super viewDidUnload];
}



@end
