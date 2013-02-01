//
//  GameObject.h
// 
// You can add your own prototypes in this file
//

#import <UIKit/UIKit.h>

// Constants for the three game objects to be implemented
typedef enum {kGameObjectWolf = 1, kGameObjectPig = 2, kGameObjectBlock = 3} GameObjectType;

//Constant for the three background of the straw
typedef enum {GameBlockWood = 4, GameBlockIron = 5, GameBlockStone = 6} StrawType;

@interface GameObject : UIViewController<UIGestureRecognizerDelegate> {
  // You might need to add state here.
    
    UIImageView* selfImgView;
    UIScrollView* gamearea;
    UIView* selectBar;
    CGPoint originalCenter;
    CGFloat originalWidth;
    CGFloat originalHeight;
    CGFloat currentWidth;
    CGFloat currentHeight;
    //GameObject* son;
    

}

@property (nonatomic, readonly) GameObjectType objectType;
@property (nonatomic) UIImageView* selfImgView;
@property (nonatomic) UIScrollView* gamearea;
@property (nonatomic) CGPoint originalCenter;
@property (nonatomic) UIView* selectBar;
@property (nonatomic) CGFloat originalWidth;
@property (nonatomic) CGFloat originalHeight;
@property (nonatomic) CGFloat currentWidth;
@property (nonatomic) CGFloat currentHeight;


//@property (nonatomic) Boolean isGetBackgroundInformation;
//@property (strong) GameObject* son;

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

// You will need to define more methods to complete the specification.

- (id)initWithBackground:(UIScrollView*) downArea:(UIView*)upArea;

- (void)setRecognizer;

@end
