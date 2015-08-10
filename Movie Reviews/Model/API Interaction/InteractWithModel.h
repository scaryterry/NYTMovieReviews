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

+ (NYTResults *)selectionFromResults:(NYTMovieSearch *)results selectedRow:(NSInteger)selectedRow;
+ (Results *)selectionFromFavourites:(MovieSearch *)results selectedRow:(NSInteger)selectedRow;

+ (Results *)initResultFromModel:(NYTResults *)result;
+ (Results *)initResultFromModel:(NYTResults *)result originatingSearch:(NYTMovieSearch *)movieSearch;
//+ (Results *)initResult:(Results *)resultForCoreData fromModel:(NYTResults *)result originatingSearch:(NYTMovieSearch *)movieSearch;

+ (MovieSearch *)initMovieSearchFromModel:(NYTMovieSearch *)movieSearch;;
+ (Multimedia *)initMultimediaFromModel:(NYTMultimedia *)model;
+ (RelatedUrls *)initRelatedUrlsFromModel:(NYTRelatedUrls *)relatedUrlsOrigin;

+ (void)setLinkForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result;
+ (void)setMultimediaForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result;
+ (void)setResourcesForDataModel:(Multimedia *)multimediaModel fromModel:(NYTResults *)result;
+ (void)addRelatedUrlsToCoreDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result;


+ (NYTResults *)initResultFromCoreDataModel:(Results *)result;
+ (NYTMovieSearch *)initMovieSearchFromCoreDataModel:(MovieSearch *)movieSearch;
+ (NYTMultimedia *)initMultimediaFromCoreDataModel:(Multimedia *)model;
+ (NYTRelatedUrls *)initRelatedUrlsFromCoreDataModel:(RelatedUrls *)relatedUrlsOrigin;

+ (void)setLinkForRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result;
+ (void)setMultimediaForRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result;
+ (void)setResourcesForRegularModel:(NYTMultimedia *)multimediaModel fromCoreDataModel:(Results *)result;
+ (void)addRelatedUrlsToRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result;
@end
