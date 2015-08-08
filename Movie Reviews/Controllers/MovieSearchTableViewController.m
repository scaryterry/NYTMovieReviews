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
#import <MagicalRecord/MagicalRecord.h>
#import <libextobjc/EXTScope.h>
#import "AlertUser.h"
#import "UIView+Additions.h"
#import <AFNetworking.h>
#import "UITableView+Additions.h"
#import "UITableViewCell+APICell.h"
#import "UIScrollView+EmptyDataSet.h"

@interface MovieSearchTableViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) Results *result;
@property (nonatomic, strong) NSArray *oldSearch;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NYTMovieSearch *searchResults;
@property (nonatomic, strong)NSString *searchTerm;
@property (nonatomic, strong,readonly,getter=getActiveTable)UITableView *activeTable;
@property (nonatomic, readonly,getter=getAlertPosition)CGPoint alertPosition;
@property (nonatomic, strong) NSManagedObjectContext *savingContext;

@end

@implementation MovieSearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.oldSearch = [MovieSearch MR_findAll];
    self.result = [Results MR_createEntity];
    if (self.oldSearch.count > 0)
    {
        {
            MovieSearch *oldSearch = [MovieSearch MR_createEntity];
            for (Results *result in [MovieSearch MR_findAll]) {
                NSLog(@"old result : %@",result);

            }
            NSLog(@"old movie : %@",[MovieSearch MR_findAll]);
            NSLog(@"old results : %@",[Results MR_findAll]);
            
            //        Results *result = [Results MR_createEntity];
            
        }
        
    }
    [self setupInterface];
    //some delay needed when checking for internet connection so that we can give Reachability a chance to get an accurate reading
    [self performSelector:@selector(setupConnectivityCheck) withObject:nil afterDelay:0.3f];
    
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
    return self.searchResults.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSString *reuseIdentifier = CellIdentifierNormal;
    // Configure the cell...
    //with the check below we can easily change the type of cell we want to display
    //by changing the reuseIdentifier we want the cell use
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        reuseIdentifier = CellIdentifierSearch;
    }
    cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NYTResults *result = [InteractWithModel selectionFromResults:self.searchResults selectedRow:indexPath.row];
    [cell configureWithResult:result];
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NYTResults *result = [InteractWithModel selectionFromResults:self.searchResults selectedRow:indexPath.row];

    self.result = [Results MR_createEntityInContext:self.savingContext];
    self.result = [InteractWithModel initResultFromModel:result originatingSearch:self.searchResults];
    NSLog(@"self.result :%@",self.result);
    [self saveContext];
    return indexPath;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - UITableViewDelegate Helper Methods
//-(NYTResults *)selectionFromResults:(NYTMovieSearch *)results selectedRow:(NSInteger)selectedRow
//{
////    NYTResults *selection = [NYTResults new];
////    selection = results.results[selectedRow];
//    return results.results[selectedRow];
//}

//-(void)configureCell:(UITableViewCell *)cell withResult:(Results *)result
//{
//    NSString *details;
//    //check reuseIdentifier so that we can display different content for each cell
//    if ([cell.reuseIdentifier isEqualToString:CellIdentifierNormal])
//    {
//        details = result.capsuleReview;
//    }
//    else
//    {
//        details = result.openingDate;
//    }
//    cell.textLabel.text = result.sortName;
//    cell.detailTextLabel.text = details;
//    
//}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
    self.searchResults = nil;
    if (![AFNetworkReachabilityManager sharedManager].reachable)
    {
        NSString *message = @"Internet Required To Search";
        [self.activeTable showTableMessage:message atPosition:self.alertPosition];
    }
//    else
//    {
//        self.activeTable.tableFooterView = [UIView new];
//    }
    //we need to use the property self.searchTerm when calling the method to search or when attempting to cancel it
    //so that we can ensure that the cancel operation uses the same object as the previously called search method,
    //otherwise if the objects arent identical the cancelling fails and we keep getting search results for every typed letter
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchForMovie:) object:self.searchTerm];
    self.searchTerm = searchText;
    [self performSelector:@selector(searchForMovie:) withObject:self.searchTerm afterDelay:0.3f];
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
             self.searchResults = searchResults;
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

- (void)saveContext
{
    //    NSLog(@"seoname:2 %@",self.result.seoName);
    [self.savingContext MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}


#pragma mark - Setup Methods
-(void)setupInterface
{
    [self.searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifierSearch];
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
//    self.searchDisplayController.searchResultsTableView.estimatedRowHeight = 44.0f;
//    self.searchDisplayController.searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
self.savingContext = [NSManagedObjectContext MR_rootSavingContext];

}

- (void)setupConnectivityCheck
{
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
                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 NSLog(@"The reachability status is reachable via WiFi");
                 break;
                 
             default:
                 break;
         }
     }];
}

#pragma mark - Empty TableView methods - DZNEmptyDataSetDelegate methods

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Please Allow Photo Access";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


@end
