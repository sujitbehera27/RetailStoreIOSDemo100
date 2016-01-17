//
//  MVCell.h
//  RetailStore
//

//

#import <UIKit/UIKit.h>
@interface MVCell : UITableViewCell

@property(retain,nonatomic)IBOutlet UILabel *titleLabel;
@property(retain,nonatomic)IBOutlet UILabel *informationLabel;
@property(retain,nonatomic)IBOutlet UIImageView *imageView;
@property(retain,nonatomic)IBOutlet UIActivityIndicatorView *loading;
@property(retain,nonatomic)IBOutlet UIButton *addButton;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *information;
@property(copy,nonatomic)UIImage *picture;
@property (retain,readwrite)NSMutableDictionary *mydata;

-(void)setTitle:(NSString *)tit;
-(void)setInformation:(NSString *)inf;
-(void)setPicture:(UIImage *)pic;
-(IBAction)AddToCurrentPlayList:(UIButton*)sender;


@end
