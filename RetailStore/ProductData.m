//
//  ProductData.m
//  RetailStore
//

//

#import "ProductData.h"
#import "AppDelegate.h"
@interface ProductData ()
@property(readonly,strong)NSDictionary*tampData;
@property (nonatomic, strong) void(^completionHandler)();
@end
@implementation ProductData
+(ProductData *)sharedData {
    static dispatch_once_t pred;
    static ProductData *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[ProductData alloc] init];
    });
     return shared;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setManagedObjectContext:[(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext]];
        _entityName = @"Product";
    }
    return self;
}
-(void)initVariables{
    _tampData = @{
                   @"data": @{
                           @"product": @[
                                   @{@"name": @"Microwave oven",
                                     @"cat": @"Electronics",
                                     @"dec": @"Type : Solo Capacity : 20 L Control Type : Touch Key pad Auto Cook Menu : NA Power Output : 800 W Dimensions (WxHxD) : 48.5 cm x 27.5 cm x 32 cm Weight : 10.5 kg Door Opening Mechanism : Push Button",
                                     @"cost": @"5222",
                                     @"img":@"micro_img.jpg"
                                     },
                                   @{@"name": @"Television",
                                     @"cat": @"Electronics",
                                     @"dec": @"81 centimeters HD Ready LED 1366 x 768 Connectivity - Input: 1*HDMI, a*USB Refresh Rate: 50 hertz Installation: For requesting installation/wall mounting/demo of this product once delivered, please directly call Haier support on 1800-200-9999 and provide product's model name as well as seller's details mentioned on the invoice. They will give you an installation reference number which can be used for any further followup. In case of any further clarification, please contact Amazon Customer Care Warranty information: 1 year warranty provided by the manufacturer from date of purchase",
                                     @"cost": @"19700",
                                     @"img":@"television_img.jpg"
                                     },
                                   @{@"name": @"Vacuum Cleaner",
                                     @"cat": @"Electronics",
                                     @"dec": @"Portable Vacuum cleaner with 800 watt motor power Both suction and blower functions Lightweight, handheld vacuum cleaner which is ideal for daily cleaning Special 18 feet long cord for easy reach around the house Blower accessory for multipurpose use Dust cup for easy disposal of garbage",
                                     @"cost": @"2499",
                                     @"img":@"vacuum_cleaner_img.jpg"
                                     },
                                   @{@"name": @"Table",
                                     @"cat": @"Furniture",
                                     @"dec": @"Easily Folds Up When not required Carries Enough weight for Surfing on your laptop or Having food or Coffee or doing normal day today activities Three different angles supported for using as Desk writer or Painting or for kids assignment session Easily can be dismantled and again fitted up to form the table One of the Most Ergonomical and Economical Foldable Study Desk to Have in the Market",
                                     @"cost": @"1075",
                                     @"img":@"table_img.jpg"
                                     },
                                   @{@"name": @"Chair",
                                     @"cat": @"Furniture",
                                     @"dec": @"Chair reclines or tilts/Seat height adjustability/Strong armrests Easy to assemble/Total back support/Strong wheels Strong armrests/Ergonomic designs/Weight Distribution Smart Support/Impact Balance",
                                     @"cost": @"4500",
                                     @"img":@"chair_img.jpg"
                                     },
                                   @{@"name": @"Almirah",
                                     @"cat": @"Furniture",
                                     @"dec": @"Material: Color on Wood Dimensions: 30.4 inch x 17.5 inch x 12 inch",
                                     @"cost": @"8500",
                                     @"img":@"almirah_img.jpg"
                                     }
                                   ]
                           }
                   };
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:@"populateData"]){
        [defaults setBool:true forKey:@"populateData"];
        [self populateData];
    }else{
        [self dataLoaded];
    }
}
-(void)populateData{
    NSArray *productAr = (NSArray*)[[_tampData valueForKey:@"data"] valueForKey:@"product"];
    int len = (int)[productAr count];
    for (int i=0; i<len; i++) {
        NSDictionary * product = [productAr objectAtIndex:i];
        Product *newProduct = [[Product alloc] initWithProductWithDic:product];
        [self addProduct:newProduct];
    }
    [self dataLoaded];
}
- (void)addProduct:(Product *)product{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    [newManagedObject setValue:product.name forKey:@"name"];
    if([_entityName isEqualToString:@"Product"]){
        [newManagedObject setValue:product.cat forKey:@"cat"];
    }
    [newManagedObject setValue:product.dec forKey:@"dec"];
    [newManagedObject setValue:product.img forKey:@"img"];
    [newManagedObject setValue:product.cost forKey:@"cost"];
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}
-(void)setDataReload:(UITableView*)tableView :(void (^)())handler{
    self.tableView = tableView;
    _completionHandler = handler;
    if (_managedObjectContext!=nil) {
        [self initVariables];
    }
}
-(void)dataLoaded{
    [self fetchedResultsController];
    _completionHandler();
}
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:_entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    NSString *cat = nil;
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    if([_entityName isEqualToString:@"Product"]){
        cat = @"cat";
    }
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:cat cacheName:@"Master"];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate Methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [self.tableView reloadData];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
-(int)calCulateTotal{
    //use this function in CartData
    return 0;
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"cartUpdated" object:nil];
    [self calCulateTotal];
    [self.tableView endUpdates];
}
@end
