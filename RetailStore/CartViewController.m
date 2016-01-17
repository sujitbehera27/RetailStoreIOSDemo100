//
//  CartViewController.m
//  RetailStore
//

//

#import "CartViewController.h"
@interface CartViewController ()

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(updateTotal) name:@"cartUpdated" object:nil];
    // Do any additional setup after loading the view.
}
-(void)initView{
    self.isCustomCell = FALSE;
    [super initView];
    [self updateTotal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateTotal{
    int totalCost = [[self getFetchedResultsController] calCulateTotal];
    if(totalCost){
        [_totalCost setHidden:FALSE];
    }else{
        [_totalCost setHidden:TRUE];
    }
    [_totalCost setText:[NSString stringWithFormat:@"Total Cost : %@",[self getCostFormatWithNum:totalCost]]];
}

-(void)viewDidDisappear:(BOOL)animated{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:@"cartUpdated" object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
