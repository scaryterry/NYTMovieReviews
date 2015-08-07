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

static NSString *const cellIdentifier = @"resultCell";
@interface MovieSearchTableViewController ()
@property (nonatomic, strong) Results *result;
@property (nonatomic, strong) NSArray *oldSearch;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NYTMovieSearch *searchResults;

@end

@implementation MovieSearchTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.oldSearch = [MovieSearch MR_findAll];
    self.result = [Results MR_createEntity];
    if ([self.oldSearch[0] isKindOfClass:[MovieSearch class]])
    {
        MovieSearch *oldSearch = [MovieSearch MR_createEntity];
        oldSearch = self.oldSearch[0];
        NSLog(@"old result : %@",[oldSearch description]);
        NSLog(@"old results : %@",oldSearch.results);
        
        
    }
    //    NSLog(@"old results : %@",[self.oldSearch description]);
    
    [InteractWithAPI searchNYTForMovies:@"Avengers" completion:^(NYTMovieSearch *searchResults, NSError *error) {
        if (error)
        {
            NSLog(@"error: %@",[error localizedDescription]);
        }
        else if (searchResults)
        {
            self.searchResults = searchResults;
            [self.tableView reloadData];
            //          MovieSearch *search = [MovieSearch initFromModel:searchResults];
            
            //            self.result = (Results *)search.results.anyObject;
            
            //            search = nil;
//            [self saveContext];
            
            
            //            ((NYTResults *)searchResults.results[0]).seoName
            //            search = searchResults;
            
        }
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)saveContext
{
    //    NSLog(@"seoname:2 %@",self.result.seoName);
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
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
    return [self.searchResults.numResults integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Results *result = self.searchResults.results[indexPath.row];
    cell.textLabel.text = result.sortName;
    // Configure the cell...
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
