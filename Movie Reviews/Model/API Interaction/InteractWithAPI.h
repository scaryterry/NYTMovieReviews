//
//  InteractWithAPI.h
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NYTMovieSearch;
/**
 *  Class responsible for interfacing with online API and parse the JSON response into a model object
 */
@interface InteractWithAPI : NSObject
/**
 *  Contains the response of the NYT API. By fetching the response in a block we are able to keep the UI from locking up while the method that fetches the results runs and it makes it trivial to be certain when the method has finished even though its run asynchronously
 *
 *  @param searchResults The response of the server after its being parsed to a local data model object
 *  @param error         If the error is not nil then it indicates that an issue has arisen and the calling method should take it into account
 */
typedef void (^RetrievalCompleteBlock)(NYTMovieSearch *searchResults, NSError *error);
/**
 *  The method that searches the NYT for a movie
 *
 *  @param movieName  The name of the movie we want to search for
 *  @param completion The completion block which returns the search results or an error with the description of what went wrong
 */
+ (void)searchNYTForMovie:(NSString *)movieName completion:(RetrievalCompleteBlock)completion;

@end
