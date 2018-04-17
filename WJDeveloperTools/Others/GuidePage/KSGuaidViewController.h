

#import <UIKit/UIViewController.h>
#import <UIKit/UIScreen.h>
#import <UIKit/UIPageControl.h>
#import <UIKit/UIButton.h>
#import <UIKit/UICollectionViewFlowLayout.h>

@interface KSGuaidViewController : UIViewController

@property (nonatomic, copy) dispatch_block_t willDismissHandler;

@end
