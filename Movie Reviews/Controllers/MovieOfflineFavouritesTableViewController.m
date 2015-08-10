//
//  MovieOfflineFavouritesTableViewController.m
//  Movie Reviews
//
//  Created by Christos C on 10/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "MovieOfflineFavouritesTableViewController.h"
#import "AppDelegate.h"
#import "InteractWithAPI.h"
#import "DataModels.h"
#import <libextobjc/EXTScope.h>
#import "AlertUser.h"
#import "UIView+Additions.h"
#import <AFNetworking.h>
#import "UITableView+Additions.h"
#import "UITableViewCell+APICell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MovieDetailsTableViewController.h"
static NSString *const SegueIdentifierOpenFavouritesDetails = @"openFavouriteDetails";

@interface MovieOfflineFavouritesTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) MovieSearch *resultsDataSource;
@end

@implementation MovieOfflineFavouritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
    [self setupFavourites];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [Results MR_fetchAllSortedBy:@"displayTitle" ascending:NO withPredicate:nil groupBy:nil delegate:self];
    return _fetchedResultsController;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieList forIndexPath:indexPath];
    NYTResults *result = [self.fetchedResultsController objectAtIndexPath:indexPath];

    [cell configureWithResult:result];
    // Configure the cell...
    
    return cell;
}
#pragma mark - UITableViewDelegate Methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:SegueIdentifierOpenFavouritesDetails sender:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierOpenFavouritesDetails])
    {
        MovieDetailsTableViewController *detailsController = segue.destinationViewController;
        Results *result = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
//        detailsController.selectedMovie = [InteractWithModel initResultFromCoreDataModel:result] ;
        detailsController.offlineSelection = result;
//        detailsController.selectedMovie = (NYTResults *)result;

//        NSMutableArray *urlArray = [NSMutableArray new];
//        for (RelatedUrls *url in result.relatedUrls)
//        {
//            NSLog(@"url %@", url.suggestedLinkText);
//            NYTRelatedUrls *newUrl = [NYTRelatedUrls new];
//            newUrl.suggestedLinkText = url.suggestedLinkText;
//            newUrl.type = url.type;
//            newUrl.url = url.url;
//            [urlArray addObject:newUrl];
//        }
//        detailsController.selectedMovie.relatedUrls = urlArray;
        
        
    }
}
#pragma mark - Setup Methods
-(void)setupInterface
{
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieList bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieList];
    
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
#warning Search cell change 3/3
    //unessesary with default search cell so delete below
    self.searchDisplayController.searchResultsTableView.estimatedRowHeight = 100.0f;
    self.searchDisplayController.searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
    //self.savingContext = [NSManagedObjectContext MR_rootSavingContext];
    
}

-(void)setupFavourites
{
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }

}
#pragma mark - Empty TableView methods - DZNEmptyDataSetDelegate methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Favourites Yet!";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"To add to your favourites switch tabs and search for a movie, then in its details tap on 'Save'";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end