//
//  InteractWithAPI.h
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NYTMovieSearch;
@interface InteractWithAPI : NSObject
typedef void (^RetrievalCompleteBlock)(NYTMovieSearch *searchResults, NSError *error);
+ (void)searchNYTForMovie:(NSString *)movieName completion:(RetrievalCompleteBlock)completion;

@end
