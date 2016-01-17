//
//  CartData.h
//  RetailStore
//

//

#import <Foundation/Foundation.h>
#import "ProductData.h"
@interface CartData : ProductData
+(CartData *)sharedData;
@end
