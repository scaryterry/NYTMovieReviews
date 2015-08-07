//
//  InteractWithAPI.m
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "InteractWithAPI.h"
#import <AFNetworking.h>
#import "NSError+Additions.h"
#import "AppDelegate.h"
#import "DataModels.h"

@implementation InteractWithAPI
static NSString *const MovieAPIBaseUrl = @"http://api.nytimes.com/svc/movies/v2/reviews/search.json?";
static NSString *const MovieAPIParametersQuery = @"query";
static NSString *const MovieAPIParametersThousandBest = @"thousand-best";
static NSString *const MovieAPIOptionThousandBest = @"N";
static NSString *const MovieAPIParametersAPIKey = @"api-key";
static NSString *const MovieAPIOptionAPIKey = @"3fa8af7ecec8dfcd325cfbb8a8041866:3:72626282";

+ (void)searchNYTForMovies:(NSString *)movieName completion:(RetrievalCompleteBlock)completion;
{
    //http://api.nytimes.com/svc/movies/v2/reviews/search.json?query=avengers&thousand-best=N&api-key=3fa8af7ecec8dfcd325cfbb8a8041866%3A3%3A72626282
    //    if ([[AFNetworkReachabilityManager sharedManager] isReachable]) // has internet connection?
    //    {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *movieSearchParameters = @{MovieAPIParametersQuery: movieName, MovieAPIParametersThousandBest:MovieAPIOptionThousandBest, MovieAPIParametersAPIKey:MovieAPIOptionAPIKey,};
    [manager GET:MovieAPIBaseUrl parameters:movieSearchParameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *error = nil;
         NYTMovieSearch *result = [[NYTMovieSearch alloc] initWithDictionary:responseObject];
         if (result.status && [result.status isEqualToString:@"OK"])
         {
             NSLog(@"return just fine");
             if (completion)
             {
                 completion(result,nil);
             }
         }
         else
         {
             if (completion)
             {
                 completion(result,nil);
             }
         }
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         if (completion)
         {
             completion(nil,error);
         }
         NSLog(@"Error: %@", error);
     }];
    //    }
    //    else
    //    {
    //        NSError *error = [[NSError new] returnErrorNoInternet];
    //        if (completion)
    //        {
    //            completion(nil,error);
    //        }
    //
    //    }
    
}
@end
