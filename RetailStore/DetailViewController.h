//
//  DetailViewController.h
//  RetailStore
//

//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Product *detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *currentImage;
@property (weak, nonatomic) IBOutlet UILabel *currentCost;
@property (weak, nonatomic) IBOutlet UILabel *currentName;
@property (weak, nonatomic) IBOutlet UITextView *currentDec;
@property (weak, nonatomic) IBOutlet UIButton *cartButton;

@end

