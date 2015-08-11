//
//  MovieSearchTableViewController.m
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "MovieSearchTableViewController.h"
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
//#import "UITableViewCell+Additions.h"
#import "UIDevice+Additions.h"

static NSString *const SegueIdentifierOpenSearchDetails = @"openSearchDetails";

@interface MovieSearchTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NYTMovieSearch *movieSearch;
//@property (nonatomic, strong) NYTResults *searchResults;
@property (nonatomic, strong)NSString *searchTerm;
@property (nonatomic, strong,readonly,getter=getActiveTable)UITableView *activeTable;// we can simply call the method directly but this way we get to use the dot nottation as we do for accessing the regular tableview
@property (nonatomic, readonly,getter=getAlertPosition)CGPoint alertPosition;
@property (nonatomic, strong) NSManagedObjectContext *savingContext;
@property (nonatomic, readonly, getter=shouldDisplayFavourites)BOOL displayFavourites;
#warning iOS7 autoheight 1/4
@property (strong, nonatomic) UITableViewCell *heightCell;
@end

@implementation MovieSearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableViewCellType];
    [self setupInterface];
    [self performSelector:@selector(setupConnectivityCheck) withObject:nil afterDelay:0.3f];
    //some delay needed when checking for internet connection so that we can give Reachability a chance to get an accurate reading

//    self.oldSearch = [Results MR_findAll];
//    self.result = [Results MR_createEntity];
//    NSMutableArray *savedStuff = [NSMutableArray new];
//    if (self.oldSearch.count > 0)
//    {
//        {
//            self.saved = [MovieSearch MR_createEntity];
//            
//            for (Results *result in [Results MR_findAll]) {
//                if ([result isKindOfClass:[Results class]])
//                {
//                    if (result.displayTitle)
//                    {
//                        [savedStuff addObject:result];
//                    }
//                    NSLog(@"old result : %@",result.displayTitle);
//                }
//                
//            }
//            self.saved.results = [NSSet setWithArray:savedStuff];
//            [self.tableView reloadData];
////            self.movieSearch = [NYTMovieSearch modelObjectWithDictionary:savedStuff];
//
//            //        Results *result = [Results MR_createEntity];
//            
//        }
//        NSLog(@"old result : %@",savedStuff);
//
//    }

    //    NSLog(@"old results : %@",[self.oldSearch description]);
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    NSInteger count = (self.shouldDisplayFavourites) ? self.saved.results.count :self.movieSearch.results.count;
    
    return self.movieSearch.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSString *reuseIdentifier = CellIdentifierMovieList;
    // Configure the cell...
    //with the check below we can easily change the type of cell we want to display
    //by changing the reuseIdentifier we want the cell use
#warning Search cell change 1/3
    //uncomment the following 5 lines  to use the default search cells
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        reuseIdentifier = CellIdentifierSearch;
//
//    }
            cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    NYTResults *result = self.movieSearch.results[indexPath.row];
        [cell configureWithResult:result];

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.searchResults = self.movieSearch.results[indexPath.row];
//    [NSManagedObjectContext MR_resetDefaultContext];
//    self.result = [InteractWithModel initResultFromModel:result];
//    NSLog(@"self.result :%@",self.result);
    [self performSegueWithIdentifier:SegueIdentifierOpenSearchDetails sender:nil];
//    [self saveContext];
    

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
        CGFloat cellHeight = [self tableViewCellHeightForiOS7:tableView calculateHeightForIndexPath:indexPath];
        return cellHeight;
    }
}


#pragma mark - UITableViewDelegate Helper Methods
- (CGFloat)tableViewCellHeightForiOS7:(UITableView *)tableView calculateHeightForIndexPath:(NSIndexPath *)indexPath
{
#warning iOS7 autoheight 3/3

    [self.heightCell configureWithResult:self.movieSearch.results[indexPath.row]];
    
#warning iOS7 autoheight 4/4
    CGFloat cellHeight = [self.heightCell returnCellAutoHeightForTableView:tableView];
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    cellHeight += 1;
    
    return cellHeight;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierOpenSearchDetails])
    {
        MovieDetailsTableViewController *detailsController = segue.destinationViewController;
//        detailsController.selectedMovie = sender;
        
        detailsController.onlineSelection = self.movieSearch.results[self.activeTable.indexPathForSelectedRow.row];
        
    }
}


#pragma mark - UISearchDisplayDelegate Methods
- (void)searchDisplayController:(UISearchDisplayController *)controller willHideSearchResultsTableView:(UITableView *)tableView
{
    //with this call here we enable the regular tableview to update so that it can also display the search results
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.placeholder=@"Search For Movie By Name";
    return true;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
       [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    // We want it to be no so that we reload it only after the asynchronous movie search has finished
    return NO;
}

#pragma mark - UISearchDisplayController Helper Methods
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    self.movieSearch = nil;
    if (![AFNetworkReachabilityManager sharedManager].reachable)
    {
        NSString *message = @"Internet Required To Search";
        [self.activeTable showTableMessage:message atPosition:self.alertPosition];
    }
    else
    {
        self.activeTable.tableFooterView = [UIView new];
    }
    //we need to use the property self.searchTerm when calling the method to search or when attempting to cancel it
    //so that we can ensure that the cancel operation uses the same object as the previously called search method,
    //otherwise if the objects arent identical the cancelling fails and we keep getting search results for every typed letter
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchForMovie:) object:self.searchTerm];
    self.searchTerm = searchText;
    [self performSelector:@selector(searchForMovie:) withObject:self.searchTerm afterDelay:0.4f];
}

- (void)searchForMovie:(NSString *)movieName
{
    @weakify(self);
    [self.activeTable showActivityIndicatorWithCenter:self.alertPosition];
    [InteractWithAPI searchNYTForMovie:movieName completion:^(NYTMovieSearch *searchResults, NSError *error)
     {
         @strongify(self);
         [self.activeTable hideActivityIndicator];
         if (error)
         {
             NSLog(@"error: %@",[error localizedDescription]);
         }
         else if (searchResults)
         {
             self.movieSearch = searchResults;
             self.searchTerm = movieName;
             [self.activeTable reloadData];
         }
     }];
}

#pragma mark - General Helper Methods

-(UITableView *)getActiveTable
{
    return (self.searchDisplayController.active) ? self.searchDisplayController.searchResultsTableView:self.tableView;
}

-(CGPoint)getAlertPosition
{
    return CGPointMake(self.activeTable.bounds.size.width/2, self.activeTable.bounds.size.height/4);
}

-(BOOL)shouldDisplayFavourites
{
    return  (self.movieSearch.results.count==0) ? true :false;
}


#pragma mark - Setup Methods
-(void)setupInterface
{
    self.tableView.tableFooterView = [UIView new];// trick to remove the empty cells at the bottom of the view

    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
#warning Search cell change 3/3
//unessesary with default search cell so delete below as well as their respective delegate methods
    self.searchDisplayController.searchResultsTableView.estimatedRowHeight = 100.0f;
    self.searchDisplayController.searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
//self.savingContext = [NSManagedObjectContext MR_rootSavingContext];

}
- (void)setupTableViewCellType
{
#warning Search cell change 2/3
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:CellIdentifierMovieList bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieList];
    //to use the default search cells uncomment below and delete the above line
    //    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifierSearch];
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieList bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieList];
#warning iOS7 autoheight 2/4
    if ([UIDevice majorSystemVersion] < 8 )
    {
        self.heightCell  = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieList];
    }
}
- (void)setupConnectivityCheck
{
    [self.tableView reloadData];
    //the reload operation is neccessary to ensure that the backround message displayed is correct - it changes if no internet is detected and without the reloadData above on the first launch it always displays the no internet message
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
         // Check the reachability status and show an alert if the internet connection is not available
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 // AFNetworkReachabilityStatusUnknown = -1,
                 NSLog(@"The reachability status is Unknown");
//                 break;
                 
             case AFNetworkReachabilityStatusNotReachable:
                 NSLog(@"The reachability status is not reachable");
                 [AlertUser showError:[[[NSError new] returnErrorNoInternet] localizedDescription] customTitle:nil];
                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 // AFNetworkReachabilityStatusReachableViaWWAN = 1
                 NSLog(@"The reachability status is reachable via WWAN");
//                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 NSLog(@"The reachability status is reachable via WiFi");
                 [self.tableView reloadData];
                 break;
                 
             default:
                 break;
         }
     }];
}

#pragma mark - Empty TableView methods - DZNEmptyDataSetDelegate methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = ([AFNetworkReachabilityManager sharedManager].isReachable)?@"Start Typing In The Search Box ":@"Please Connect to the Internet";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = ([AFNetworkReachabilityManager sharedManager].isReachable)?@"And as you type the results get updated ":@"If you want to search for a movie, otherwise switch to your favourites to search offline";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
@end
