//
//  MasterViewController.h
//  RetailStore
//

//

#import <UIKit/UIKit.h>
#import "ProductData.h"
#import "ProductData.h"
#import "CartData.h"
@interface ProductViewController : UITableViewController
@property(readwrite)BOOL isCustomCell;
-(void)initView;
-(ProductData * )getFetchedResultsController;
-(NSString*)getCostFormatWithNum:(int)aNum;
@end

