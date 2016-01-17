//
//  MVCell.m
//  RetailStore
//

//

#import "MVCell.h"
@implementation MVCell
@synthesize titleLabel;
@synthesize informationLabel;
@synthesize title;
@synthesize information;
@synthesize imageView;
@synthesize picture;
@synthesize loading;
@synthesize mydata;
@synthesize addButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        mydata = [[NSMutableDictionary alloc] initWithObjectsAndKeys: nil];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setTitle:(NSString *)tit{
    if (![tit isEqualToString:title]) {
        title=[tit copy];
        self.titleLabel.text=title;
    }
}


-(void)setInformation:(NSString *)inf{
    if (![inf isEqualToString:information]) {
        information=[inf copy];
        self.informationLabel.text=information;
    }
}

-(void)setPicture:(UIImage *)pic{
    if(![pic isEqual:picture]){
        picture=[pic copy];
        [self.imageView setImage:picture];
    }
}

-(IBAction)AddToCurrentPlayList:(UIButton*)sender{
    //[sender setEnabled:FALSE];
    //AwesomeAppDelegate *appDelegate = (AwesomeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDelegate AddToCurrentPlayList:mydata];
}

@end
