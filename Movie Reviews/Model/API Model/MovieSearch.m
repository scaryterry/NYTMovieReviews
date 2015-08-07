//
//  MovieSearch.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "MovieSearch.h"
#import "Results.h"
#import "NYTMovieSearch.h"
#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation MovieSearch

@dynamic status;
@dynamic copyright;
@dynamic numResults;
@dynamic results;

+ (MovieSearch *)initFromModel:(NYTMovieSearch *)model
{
    if ([model isKindOfClass:[NYTMovieSearch class]])
    {
        MovieSearch * returnedModel = [MovieSearch MR_createEntity];
        returnedModel = (MovieSearch *)model;
        return returnedModel;
    }
    else
    {
        return nil;
    }
}

@end
