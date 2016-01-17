//
//  DetailViewController.m
//  RetailStore
//

//

#import "DetailViewController.h"
#import "CartData.h"
@interface DetailViewController ()
@property(readwrite)BOOL viewFromCart;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Product*)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        [self.currentName setText:self.detailItem.name];
        [self.currentImage setImage:[UIImage imageNamed:self.detailItem.img]];
        [self.currentCost setText:[NSString stringWithFormat:@"Cost: %@",[self getCostFormatWithNum:[self.detailItem.cost intValue]]]];
        [self.currentDec setText:self.detailItem.dec];
    }
}
-(NSString*)getCostFormatWithNum:(int)aNum{
    return [NSNumberFormatter localizedStringFromNumber:@(aNum)
                                                     numberStyle:NSNumberFormatterCurrencyStyle];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _viewFromCart = [self.detailItem  respondsToSelector:@selector(cat)];
    if(_viewFromCart){
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Cart" style:UIBarButtonItemStylePlain target:self action:@selector(viewCart)];
        self.navigationItem.rightBarButtonItem = addButton;
    }else{
        [_cartButton setHidden:TRUE];
    }
    [self configureView];
}
-(void)viewCart{
    [self performSegueWithIdentifier: @"showDetailCart" sender: self];
}
- (IBAction)addToCart:(id)sender {
    [[CartData sharedData] addProduct:_detailItem];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Product is added to you cart" message:[_detailItem valueForKey:@"name"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
