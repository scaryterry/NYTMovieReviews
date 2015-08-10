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
static NSString *const kNYTMovieAPIBaseUrl = @"http://api.nytimes.com/svc/movies/v2/reviews/search.json?";
static NSString *const kNYTMovieAPIParametersQuery = @"query";
static NSString *const kNYTMovieAPIParametersThousandBest = @"thousand-best";
static NSString *const kNYTMovieAPIOptionThousandBest = @"N";
static NSString *const kNYTMovieAPIParametersOrder = @"order";
static NSString *const kNYTMovieAPIOptionOrder = @"by-title";
static NSString *const kNYTMovieAPIParametersAPIKey = @"api-key";
static NSString *const kNYTMovieAPIOptionAPIKey = @"3fa8af7ecec8dfcd325cfbb8a8041866:3:72626282";

+ (void)searchNYTForMovie:(NSString *)movieName completion:(RetrievalCompleteBlock)completion;
{
    //http://api.nytimes.com/svc/movies/v2/reviews/search.json?query=avengers&thousand-best=N&api-key=3fa8af7ecec8dfcd325cfbb8a8041866%3A3%3A72626282
    if ([AFNetworkReachabilityManager sharedManager].reachable) // has internet connection?
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *movieSearchParameters = @{kNYTMovieAPIParametersQuery: movieName, kNYTMovieAPIParametersOrder:kNYTMovieAPIOptionOrder, kNYTMovieAPIParametersAPIKey:kNYTMovieAPIOptionAPIKey,};
        [manager GET:kNYTMovieAPIBaseUrl parameters:movieSearchParameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
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
    }
    else
    {
        NSError *error = [[NSError new] returnErrorNoInternet];
        if (completion)
        {
            completion(nil,error);
        }
        
    }
    
}


@end
