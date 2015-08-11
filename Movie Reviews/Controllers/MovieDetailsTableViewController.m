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
#import "UIDevice+Additions.h"
typedef NS_ENUM(NSUInteger, cellType) {
    cellTypeHeader ,
    cellTypeReview ,
    cellTypeDetails ,
};
typedef NS_ENUM(NSUInteger, cellTypeCount) {
    cellTypeCountAll = 3  ,
    cellTypeCountNoReview = 2 ,
};

typedef NS_ENUM(NSUInteger, sectionType) {
sectionTypeMovieInfo ,
    sectionTypeMovieLinks ,
};
//#import "UITableViewCell+Additions.h"
@interface MovieDetailsTableViewController ()<KINWebBrowserDelegate>
@property (nonatomic,readonly,getter=isCapsuleReviewAvailable) BOOL capsuleReviewAvailable;
@property (nonatomic,readonly,getter=isMovieInFavourites) BOOL movieInFavourites;
@property (nonatomic,assign) BOOL const initialCheckIsMovieInFavourites;

@property (nonatomic,strong)Results *itemToSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonAddRemove;
#warning iOS7 autoheight 1/4
@property (strong, nonatomic) UITableViewCell *heightCellHeader;
@property (strong, nonatomic) UITableViewCell *heightCellReviews;
@property (strong, nonatomic) UITableViewCell *heightCellDetails;


@end

@implementation MovieDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableViewCellType];
    [self setupInterface];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //we do this in willAppear so that if the favourite is removed via the favourites screen then this button will change accordingly
    [self setupBarButton];
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
        case sectionTypeMovieInfo:
        {
            rowCount = cellTypeCountAll;
            if (!self.isCapsuleReviewAvailable)
            {
                rowCount = cellTypeCountNoReview;
            }
            
            break;
        }
        case sectionTypeMovieLinks:
        {
            if (self.offlineSelection)
            {
                rowCount = self.offlineSelection.relatedUrls.count;
            }
            else
            {
                rowCount = self.onlineSelection.relatedUrls.count;
            }
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
    
    if (indexPath.section == sectionTypeMovieInfo)
    {
        if (self.offlineSelection)
        {
            [cell configureWithFavourite:self.offlineSelection];
        }
        else
        {
            [cell configureWithResult:self.onlineSelection];
            
        }
    }
    else
    {
        if (self.offlineSelection)
        {
            [self configureOverviewSectionWithFavourite:self.offlineSelection forCell:cell atIndexPath:indexPath];
        }
        else
        {
            [self configureOverviewSectionWithResult:self.onlineSelection forCell:cell atIndexPath:indexPath];
            
        }
        
    }
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == sectionTypeMovieLinks)
    {
        NSString *urlToLoad;
        
        if (self.offlineSelection)
        {
            urlToLoad = ((RelatedUrls *)self.offlineSelection.relatedUrls.allObjects[indexPath.row]).url;
        }
        else
        {
            urlToLoad = ((NYTRelatedUrls *)self.onlineSelection.relatedUrls[indexPath.row]).url;
        }
        
        [self performOpenMovieLink:urlToLoad];
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
    else if (indexPath.section == sectionTypeMovieInfo)
    {
#warning iOS7 autoheight 3/3
        CGFloat cellHeight = [self tableViewCellHeightForiOS7:tableView calculateHeightForIndexPath:indexPath];
        return cellHeight;
    }
    else // overview cells which use the default cells so we cant calculate it automatically like the rest of the cell types
    {
        return 60.0f;
    }
}

- (CGFloat)tableViewCellHeightForiOS7:(UITableView *)tableView calculateHeightForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 100;
    UITableViewCell *heightCell;
    switch (indexPath.row)
    {
        case cellTypeHeader:
        {
            heightCell = self.heightCellHeader;
            break;
        }
            
        case cellTypeReview:
        {
            heightCell = self.heightCellReviews;
            if (self.isCapsuleReviewAvailable) // if there isnt a capsule review then we dont break so that the cell will get configured as self.heightCellDetails from below
            {
                break;
            }
        }
            
        case cellTypeDetails:
        {
            heightCell = self.heightCellDetails;
            break;
        }
        default:
            break;
    }
    if (self.onlineSelection)
    {
        [heightCell configureWithResult:self.onlineSelection];
    }
    else
    {
        [heightCell configureWithFavourite:self.offlineSelection];
        
    }
#warning iOS7 autoheight 4/4
    cellHeight = [heightCell returnCellAutoHeightForTableView:tableView];

    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    cellHeight += 1;
    
    return cellHeight;
}

#pragma mark - UITableViewController Delegate Helper Methods
-(void)configureOverviewSectionWithResult:(NYTResults *)result forCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = ((NYTRelatedUrls *)result.relatedUrls[indexPath.row]).suggestedLinkText;
}
-(void)configureOverviewSectionWithFavourite:(Results *)result forCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = ((RelatedUrls *)result.relatedUrls.allObjects[indexPath.row]).suggestedLinkText;
}

-(BOOL)isCapsuleReviewAvailable
{
    NSString *capsuleReview;
    BOOL isAvailable = false;
    if (self.offlineSelection)
    {
        capsuleReview = self.offlineSelection.capsuleReview;
    }
    else
    {
        capsuleReview = self.onlineSelection.capsuleReview;
    }
    
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
#pragma mark - Helper Methods
//-(BOOL)isUsingFavourites
//{
//    BOOL usingFavourites = false;
//    if (self.offlineSelection)
//    {
//        usingFavourites = true;
//    }
//    else if (self.onlineSelection)
//    {
//        usingFavourites = false;
//    }
//    return usingFavourites;
//}
#pragma mark - Setup Methods
-(void)setupInterface
{
    self.tableView.tableFooterView = [UIView new];// trick to remove the empty cells at the bottom of the view
    self.initialCheckIsMovieInFavourites = self.isMovieInFavourites;
    self.title = @"Movie Details";
    
    self.tableView.estimatedRowHeight = 100.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
- (void)setupTableViewCellType
{
    // register the custom tableview cells we want to use
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieDetailsHeader bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieDetailsHeader];
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieDetailsReview bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieDetailsReview];
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifierMovieDetailsDescription bundle:[NSBundle mainBundle]]  forCellReuseIdentifier:CellIdentifierMovieDetailsDescription];
#warning iOS7 autoheight 2/4
    if ([UIDevice majorSystemVersion] < 8 )
    {
        self.heightCellHeader  = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieDetailsHeader];
        self.heightCellReviews  = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieDetailsReview];
        self.heightCellDetails  = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifierMovieDetailsDescription];

    }
}

-(void)setupBarButton
{
    if (self.offlineSelection)
    {
        self.barButtonAddRemove.title = @"Remove Favourite";
    }
    else
    {
        if (self.isMovieInFavourites)
        {
            self.barButtonAddRemove.title = @"Remove Favourite";
        }
        else
        {
            self.barButtonAddRemove.title = @"Add Favourite";
        }
    }
    
}
-(BOOL)isMovieInFavourites
{
    BOOL isInFavourites = false;
    NSArray *favouriteMoviesIDs = [[Results MR_findAll] valueForKey:@"nytMovieId"];
    //if array is empty we wont try and compare since that tells us that they dont have any favourites and if we try to compare using containsObject on a nil array - when no favourites are there - we will get a crash
    if (favouriteMoviesIDs && favouriteMoviesIDs.count > 0)
    {
        //check if any of the previously saved model objects has the same movieId, in that case it means we already saved it
        if (self.onlineSelection)
        {
            isInFavourites = [favouriteMoviesIDs containsObject:self.onlineSelection.nytMovieId];
        }
        else
        {
            isInFavourites = [favouriteMoviesIDs containsObject:self.offlineSelection.nytMovieId];
        }
    }
    return isInFavourites;
}


#pragma mark - IBActions
- (IBAction)performAddRemoveFavourite:(id)sender
{
    self.initialCheckIsMovieInFavourites = self.isMovieInFavourites;
    if (self.onlineSelection) {
        
        //check if the selected movie already exists in our favourites, if not then a model object is created to be saved
        if (!self.initialCheckIsMovieInFavourites)
        {
            //create the entity from the NYT model so that it gets added to the current context and its saved when the context is saved
            self.itemToSave = [InteractWithModel initResultFromModel:self.onlineSelection];
        }
        else
        {
            self.itemToSave = [Results MR_findFirstByAttribute:@"nytMovieId" withValue:self.onlineSelection.nytMovieId];
            NSLog(@"existing result: %@ opened result: %@",self.itemToSave.nytMovieId, self.onlineSelection.nytMovieId);
            [self.itemToSave MR_deleteEntity];
            
        }
    }
    else
    {
        //delete the entity from the current context
        [self.offlineSelection MR_deleteEntity];
        self.navigationItem.rightBarButtonItem = nil;
    }
    [self saveContext];
    
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
        NSString *alertMsg;
        if (success) {
            NSLog(@"You successfully saved your context.");
            if (!self.initialCheckIsMovieInFavourites)
            {
                alertMsg = @"Successfully added to favourites";
                self.barButtonAddRemove.title = @"Remove Favourite";
            }
            else
            {
                alertMsg = @"Successfully removed from favourites";
                self.barButtonAddRemove.title = @"Add Favourite";
            }
            [AlertUser showSuccess:alertMsg customTitleMessage:nil];
        } else if (error) {
            if (!self.initialCheckIsMovieInFavourites)
            {
                alertMsg = @"Error Adding To Favourites";
            }
            else
            {
                alertMsg = @"Error Removing From Favourites";
            }
            
            [AlertUser showError:error.description customTitle:alertMsg];
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

@end
