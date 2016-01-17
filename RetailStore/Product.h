//
//  Product.h
//  RetailStore
//
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(readonly,strong)NSString*name;
@property(readonly,strong)NSString*cat;
@property(readonly,strong)NSString*img;
@property(readonly,strong)NSString*dec;
@property(readonly)NSNumber *cost;
-(id)initWithProductWithDic:(NSDictionary*)dec;
@end
