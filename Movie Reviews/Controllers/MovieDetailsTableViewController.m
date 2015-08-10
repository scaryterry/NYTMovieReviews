//
//  MovieDetailsTableViewController.m
//  Movie Reviews
//
//  Created by Christos C on 09/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "MovieDetailsTableViewController.h"
#import "DataModels.h"
#import "UITableViewCell+APICell.h"
#import "AlertUser.h"
#import <KINWebBrowser/KINWebBrowserViewController.h>
#import <AFNetworking.h>

@interface MovieDetailsTableViewController ()<KINWebBrowserDelegate>
@property (nonatomic,readonly,getter=isCapsuleReviewAvailable) BOOL capsuleReviewAvailable;

@end

@implementation MovieDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInterface];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger rowCount = 0;
    switch (section)
    {
        case 0:
        {
            rowCount = 3;
            if (!self.isCapsuleReviewAvailable)
            {
                rowCount = 2;
            }
            
            break;
        }
        case 1:
        {
            rowCount = self.selectedMovie.relatedUrls.count;
            break;
        }
        default:
            
            break;
    }
    return rowCount;
}


#pragma mark - UITableViewController Delegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self getMovieCellReuseIdentifierForRowAtIndexPath:indexPath] forIndexPath:indexPath];
    if (indexPath.section == 0)
    {

    [cell configureWithResult:self.selectedMovie];

    }
    else
    {
        [self configureOverviewSectionWithResult:self.selectedMovie forCell:cell atIndexPath:indexPath];
    }
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {

        NSString *urlToLoad = ((RelatedUrls *)self.selectedMovie.relatedUrls[indexPath.row]).url;
        [self performOpenMovieLink:urlToLoad];
    }
}

#pragma mark - UITableViewController Delegate Helper Methods
-(void)configureOverviewSectionWithResult:(NYTResults *)result forCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = ((RelatedUrls *)result.relatedUrls[indexPath.row]).suggestedLinkText;
}

-(BOOL)isCapsuleReviewAvailable
{
    NSString *capsuleReview;
    BOOL isAvailable = false;
    
    capsuleReview = self.selectedMovie.capsuleReview;
    if (capsuleReview && capsuleReview.length > 0 )
    {
        isAvailable = true;
    }
    return isAvailable;
}
-(NSString *)getMovieCellReuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = CellIdentifierNormal;
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                reuseIdentifier = CellIdentifierMovieDetailsHeader;
                break;
            }
            case 1:
            {
                if (self.isCapsuleReviewAvailable)
                {
                    reuseIdentifier = CellIdentifierMovieDetailsReview;
                    break;
                }
                // if there isnt a capsuleReview available then we dont break here so that the reuseIdentifier for the second cell will be that of the CellIdentifierMovieDetailsDescription
                
            }
            case 2:
            {
                reuseIdentifier = CellIdentifierMovieDetailsDescription;
                break;
            }
            default:
                break;
        }
    }
    else
    {
        reuseIdentifier = CellIdentifierMovieDetailsOverview;
    }
    return reuseIdentifier;
}
#pragma Helper Methods
#pragma Setup Methods
-(void)setupInterface
{
    self.tableView.tableFooterView = [UIView new];// trick to remove the empty cells at the bottom of the view
    
    self.title = @"Movie Details";
    // register the custom tableview cells we want to use
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieDetailsHeader bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieDetailsHeader];
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieDetailsReview bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieDetailsReview];
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieDetailsDescription bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieDetailsDescription];
    
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - IBActions

- (IBAction)performAddToFavourites:(id)sender
{
    Results *itemToSave = [InteractWithModel initResultFromModel:self.selectedMovie];
#warning add check if its in favourites
    //    if (itemToSave is not in favourites)
//    {
    [self saveContext];
//    }
    
}

- (void)performOpenMovieLink:(NSString *)link
{
    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) // has internet connection?
    {
        KINWebBrowserViewController *webBrowser = [KINWebBrowserViewController webBrowser];
        webBrowser.barTintColor = self.navigationController.navigationBar.barTintColor;
        webBrowser.tintColor = self.navigationController.navigationBar.tintColor;
        [webBrowser setDelegate:self];
        webBrowser.hidesBottomBarWhenPushed = true;
        [webBrowser loadURLString:link];
        [self.navigationController pushViewController:webBrowser animated:YES];
        
    }
    else
    {
        [AlertUser showError:@"No Internet Connection Available" customTitle:@"Can't Open Website"];
    }
    
    
    
    //                            webBrowser.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //                            webBrowser.modalPresentationStyle = UIModalPresentationFullScreen;
    //
    //                            [self presentViewController:webBrowser animated:YES completion:NULL];
    
}
- (void)saveContext
{
    //    NSLog(@"seoname:2 %@",self.result.seoName);
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
            [AlertUser showSuccess:@"Successfully added to favourites" customTitleMessage:nil];
        } else if (error) {
            [AlertUser showError:error.description customTitle:@"Error Adding to favourites"];
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

@end
