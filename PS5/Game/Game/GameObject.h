//
//  GameObject.h
// 
// You can add your own prototypes in this file
//

#import <UIKit/UIKit.h>
#import "PERectangle.h"
#import "GestureHandlerProtocol.h"
@interface GameObject : UIViewController<UIGestureRecognizerDelegate,UpdatePositionInViewDelegate>
 

@property PERectangle *model;

@property (weak) id<GestureHandlerProtocol> myDelegate;

@property (readonly) CGFloat widthInPalette;
@property (readonly) CGFloat heightInPalette;
@property (readonly) CGPoint centerInPalette;

@property int canTakeNumberOfHit;

- (void)translate:(UIGestureRecognizer *)gesture;
  // MODIFIES: object model (coordinates)
  // REQUIRES: game in designer mode
  // EFFECTS: the user drags around the object with one finger
  //          if the object is in the palette, it will be moved in the game area

- (void)rotate:(UIGestureRecognizer *)gesture;
  // MODIFIES: object model (rotation)
  // REQUIRES: game in designer mode, object in game area
  // EFFECTS: the object is rotated with a two-finger rotation gesture

- (void)zoom:(UIGestureRecognizer *)gesture;
  // MODIFIES: object model (size)
  // REQUIRES: game in designer mode, object in game area
  // EFFECTS: the object is scaled up/down with a pinch gesture

-(void) restore;
// MODIFIES: views in gameArea
// EFFECTS: add the view back to the palette

//-(void) changeTexture;


@end
