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
#import "UIDevice+Additions.h"

//#import "UITableViewCell+Additions.h"
static NSString *const SegueIdentifierOpenFavouritesDetails = @"openFavouriteDetails";

@interface MovieOfflineFavouritesTableViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


#warning iOS7 autoheight 1/4
@property (strong, nonatomic) UITableViewCell *heightCell;

@end

@implementation MovieOfflineFavouritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewCellType];
    [self setupInterface];
        [self setupFavourites];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    _fetchedResultsController = [Results MR_fetchAllSortedBy:@"displayTitle" ascending:true withPredicate:nil groupBy:nil delegate:self];
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //by registering for the _fetchedResultsControllerDelegate whenever an update happens the table gets reloaded so that it always displays current data
    [self.tableView endUpdates];
//    [self.tableView reloadData];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
 atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)theIndexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
//    UITableView *tableView = controller == self.fetchedResultsController ? self.tableView : self.searchDisplayController.searchResultsTableView;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:theIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [[self.tableView cellForRowAtIndexPath:theIndexPath] configureWithFavourite:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:theIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger  rowCount = [self.fetchedResultsController.sections[section] numberOfObjects];
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieList forIndexPath:indexPath];
    
    Results *result = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureWithFavourite:result];
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
    if (!tableView.isEditing)
    {
        [self performSegueWithIdentifier:SegueIdentifierOpenFavouritesDetails sender:nil];

    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell animateCellScrolling];
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([UIDevice majorSystemVersion] >= 8)
    {
        return UITableViewAutomaticDimension;
    }
    else
    {
#warning iOS7 autoheight 3/3
        CGFloat cellHeight = [self tableViewCellHeightForiOS7:tableView calculateHeightForIndexPath:indexPath];
        return cellHeight;
    }
}

- (CGFloat)tableViewCellHeightForiOS7:(UITableView *)tableView calculateHeightForIndexPath:(NSIndexPath *)indexPath
{
    [self.heightCell configureWithFavourite:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
#warning iOS7 autoheight 4/4
    CGFloat cellHeight = [self.heightCell returnCellAutoHeightForTableView:tableView];
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
        cellHeight += 1;
    
    return cellHeight;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[self.fetchedResultsController objectAtIndexPath:indexPath] MR_deleteEntity];
        [self saveContext];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierOpenFavouritesDetails])
    {
        MovieDetailsTableViewController *detailsController = segue.destinationViewController;
        Results *result = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
//        detailsController.selectedMovie = [InteractWithModel initResultFromCoreDataModel:result] ;
        detailsController.offlineSelection = result;
    }
}
#pragma mark - Setup Methods
-(void)setupInterface
{
    self.tableView.tableFooterView = [UIView new];// trick to hide empty cells
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.fetchedResultsController.delegate = self;
}
- (void)setupTableViewCellType
{
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieList bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieList];
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:CellIdentifierMovieList bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieList];
#warning iOS7 autoheight 2/4
    if ([UIDevice majorSystemVersion] < 8 )
    {
        self.heightCell  = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieList];
    }
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
    NSString *text = @"To add to your favourites switch tabs and search for a movie, then in its details tap on 'Add Favourite'";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)saveContext
{
    //    NSLog(@"seoname:2 %@",self.result.seoName);
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            [AlertUser showError:error.description customTitle:@"Error Removing From Favourites"];
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

@end
