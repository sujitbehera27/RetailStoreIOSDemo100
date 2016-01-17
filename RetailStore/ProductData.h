//
//  ProductData.h
//  RetailStore
//

//

#import <Foundation/Foundation.h>
#import "Product.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
@interface ProductData : NSObject<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(readwrite,nonatomic)NSString *entityName;
@property(readwrite,strong,nonatomic)UITableView *tableView;
+(ProductData *)sharedData;
-(void)setDataReload:(UITableView*) tableView :(void (^)())handler;
- (void)addProduct:(Product *)product;
-(int)calCulateTotal;
@end
