//
//  InteractWithModel.h
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NYTResults, NYTMovieSearch,Results, MovieSearch,RelatedUrls,NYTRelatedUrls,Multimedia,NYTMultimedia;
@interface InteractWithModel : NSObject

//The methods below can parse a regular model object that came in from the NYT API to a coreData model object //
+ (Results *)initResultFromModel:(NYTResults *)result;
+ (Results *)initResultFromModel:(NYTResults *)result originatingSearch:(NYTMovieSearch *)movieSearch;
+ (MovieSearch *)initMovieSearchFromModel:(NYTMovieSearch *)movieSearch;;
+ (Multimedia *)initMultimediaFromModel:(NYTMultimedia *)model;
+ (RelatedUrls *)initRelatedUrlsFromModel:(NYTRelatedUrls *)relatedUrlsOrigin;

+ (void)setLinkForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result;
+ (void)setMultimediaForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result;
+ (void)setResourcesForDataModel:(Multimedia *)multimediaModel fromModel:(NYTResults *)result;
+ (void)addRelatedUrlsToCoreDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result;



//The methods below can map a coreData model object back to a regular model object //
//Although they work ok, due to a design decision they dont get used in the app. //
//Their purpose was to use them when trying to display a favourite using the MovieDetailsTableViewController //
//But in the end it was decided to simply duplicate the methods that configure the cells, so that the cells can read the core data model object directly and configure themselves, this way when we have a large amount of favourites to display we will be simply using them instead of trying to convert each one back to a regular model object//
//By duplicating all the cell configuration methods so that they can parse the core data model object we also get a better seperation of concerns and reduces ambiguity - whenever a coredata model object is used we are sure that its from our favourites, while whenever a regular data model object is used we can be sure that it just came in from searching the API //

+ (NYTResults *)initResultFromCoreDataModel:(Results *)result;
+ (NYTMovieSearch *)initMovieSearchFromCoreDataModel:(MovieSearch *)movieSearch;
+ (NYTMultimedia *)initMultimediaFromCoreDataModel:(Multimedia *)model;
+ (NYTRelatedUrls *)initRelatedUrlsFromCoreDataModel:(RelatedUrls *)relatedUrlsOrigin;

+ (void)setLinkForRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result;
+ (void)setMultimediaForRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result;
+ (void)setResourcesForRegularModel:(NYTMultimedia *)multimediaModel fromCoreDataModel:(Results *)result;
+ (void)addRelatedUrlsToRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result;
@end
