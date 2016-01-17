//
//  Product.m
//  RetailStore
//

//

#import "Product.h"

@implementation Product
-(id)initWithProductWithDic:(NSDictionary*)dec{
if (![super init]) {
		return nil;
	}
    _name = [dec valueForKey:@"name"];
    _cat = [dec valueForKey:@"cat"];
    _cost = [NSNumber numberWithInt:[[dec valueForKey:@"cost"] intValue]];
    _img = [dec valueForKey:@"img"];
    _dec = [dec valueForKey:@"dec"];
    return self;
}
@end
