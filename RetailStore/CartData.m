//
//  CartData.m
//  RetailStore
//

//

#import "CartData.h"
#import "AppDelegate.h"

@implementation CartData
+(CartData *)sharedData {
    static dispatch_once_t pred;
    static CartData *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[CartData alloc] init];
    });
     return shared;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.entityName = @"Cart";
    }
    return self;
}
-(int)calCulateTotal{
    NSArray *arr = [self.fetchedResultsController fetchedObjects];
    int len =   arr.count;
    int totalCost = 0;
    for (int i =0 ;i<len;i++) {
        NSManagedObject *manageObject = [[self.fetchedResultsController fetchedObjects] objectAtIndex:i];
        totalCost+= [[manageObject valueForKey:@"cost"] intValue];
    }
    return totalCost;
}
@end
