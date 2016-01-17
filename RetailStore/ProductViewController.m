//
//  MasterViewController.m
//  RetailStore
//

//

#import "ProductViewController.h"
#import "DetailViewController.h"
#import "Product.h"
#import "MVCell.h"
@interface ProductViewController ()
@property(readonly,strong) NSDictionary *tabledata;
@end

@implementation ProductViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isCustomCell = TRUE;
    [self initView];
}
-(void)initView{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Cart" style:UIBarButtonItemStylePlain target:self action:@selector(viewCart)];
    if(_isCustomCell){
        self.navigationItem.rightBarButtonItem = addButton;
    }else{
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    [[self getFetchedResultsController]setDataReload:self.tableView :^{
       [self.tableView reloadData];
    }];
}
-(void)viewCart{
    [self performSegueWithIdentifier: @"showDetailCart" sender: self];
}
-(ProductData * )getFetchedResultsController{
    return (_isCustomCell)?[ProductData sharedData]:[CartData sharedData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self getFetchedResultsController].fetchedResultsController objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:(Product*)object];
    }else{
        if([[segue destinationViewController] respondsToSelector:@selector(setIsCustomCell:)]){
            [[segue destinationViewController] setIsCustomCell:FALSE];
        }
    }
}

#pragma mark - Table View

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self getFetchedResultsController].fetchedResultsController sections][section];
    NSString *sectionHeader = [sectionInfo name];
    return sectionHeader;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[self getFetchedResultsController].fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self getFetchedResultsController].fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"showDetail" sender: self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(!_isCustomCell){
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    }else{
        NSString *cellIdentifier=nil;
        BOOL nibRegistered=NO;
        if(!nibRegistered){
            UINib *nib=[UINib nibWithNibName:@"MVCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:@"MVCellIdentifier"];
            nibRegistered=YES;
        }
        cellIdentifier=@"MVCellIdentifier";
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    [self configureCell:(MVCell*)cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return !_isCustomCell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [[self getFetchedResultsController].fetchedResultsController managedObjectContext];
        [context deleteObject:[[self getFetchedResultsController].fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(MVCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [[self getFetchedResultsController].fetchedResultsController objectAtIndexPath:indexPath];
    if(![cell isKindOfClass:[MVCell class]]){
        cell.textLabel.text = [[object valueForKey:@"name"] description];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self getCostFormatWithNum:[[[object valueForKey:@"cost"] description] intValue]]];
    }else{
        [cell setTitle:[[object valueForKey:@"name"] description]];
        [cell setPicture:[UIImage imageNamed:[[object valueForKey:@"img"] description]]];
        [cell setInformation:[[object valueForKey:@"dec"] description]];
    }
}
-(NSString*)getCostFormatWithNum:(int)aNum{
    return [NSNumberFormatter localizedStringFromNumber:@(aNum)
                                                     numberStyle:NSNumberFormatterCurrencyStyle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
