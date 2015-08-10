//
//  InteractWithModel.m
//  Movie Reviews
//
//  Created by Christos C on 08/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "InteractWithModel.h"
#import "DataModels.h"
@implementation InteractWithModel

+ (NYTResults *)selectionFromResults:(NYTMovieSearch *)results selectedRow:(NSInteger)selectedRow
{
    return results.results[selectedRow];
}

+ (Results *)selectionFromFavourites:(MovieSearch *)results selectedRow:(NSInteger)selectedRow
{
    NSArray *temp = results.results.allObjects;
    return temp[selectedRow];
}

//+ (Results *)initResult:(Results *)resultForCoreData fromModel:(NYTResults *)result originatingSearch:(NYTMovieSearch *)movieSearch
+ (Results *)initResultFromModel:(NYTResults *)result
{
    return  [[self class] initResultFromModel:result originatingSearch:nil];
}

+ (Results *)initResultFromModel:(NYTResults *)result originatingSearch:(NYTMovieSearch *)movieSearch
{
    Results *resultForCoreData = [Results MR_createEntity];
    resultForCoreData.capsuleReview = result.capsuleReview;
    resultForCoreData.dateUpdated = result.dateUpdated;
    resultForCoreData.summaryShort = result.summaryShort;
    resultForCoreData.headline = result.headline;
    resultForCoreData.thousandBest = result.thousandBest;
    resultForCoreData.byline = result.byline;
    resultForCoreData.dvdReleaseDate = result.dvdReleaseDate;
    resultForCoreData.mpaaRating = result.mpaaRating;
    resultForCoreData.publicationDate = result.publicationDate;
    resultForCoreData.openingDate = result.openingDate;
    resultForCoreData.displayTitle = result.displayTitle;
    resultForCoreData.sortName = result.sortName;
    resultForCoreData.seoName = result.seoName;
    resultForCoreData.criticsPick = result.criticsPick;
    resultForCoreData.nytMovieId = result.nytMovieId;
    
    resultForCoreData.link = nil;
    if (result.link)
    {
        if (![[result.link dictionaryRepresentation] isEqual:[NSDictionary new]])
        {
        [[self class]setLinkForDataModel:resultForCoreData fromModel:result];
        }
    }

    
    resultForCoreData.multimedia = nil;
    if (result.multimedia)
    {
        if (![[result.multimedia dictionaryRepresentation] isEqual:[NSDictionary new]])
        {
            [[self class]setMultimediaForDataModel:resultForCoreData fromModel:result];
        }
    }
    
    resultForCoreData.relatedUrls = nil;
    if (result.relatedUrls)
    {
        if (![result.relatedUrls  isEqual:[NSArray new]])
        {
        [[self class] addRelatedUrlsToCoreDataModel:resultForCoreData fromModel:result];
        }
    }
    
    resultForCoreData.movieSearch = nil;
    if (movieSearch)
    {
        if (![[movieSearch dictionaryRepresentation] isEqual:[NSDictionary new]])
        {
        resultForCoreData.movieSearch = [InteractWithModel initMovieSearchFromModel:movieSearch];
        }
    }
        resultForCoreData.multimedia.results = resultForCoreData;
        resultForCoreData.link.results = resultForCoreData;
        return resultForCoreData;


}


+ (MovieSearch *)initMovieSearchFromModel:(NYTMovieSearch *)movieSearch;
{
    MovieSearch *resultForCoreData = [MovieSearch MR_createEntity];
    resultForCoreData.status = movieSearch.status;
    resultForCoreData.copyright = movieSearch.copyright;
    resultForCoreData.numResults = movieSearch.numResults;
    resultForCoreData.results = nil;
    if (movieSearch.results)
    {
        NSMutableSet *results = [NSMutableSet new];
        for (NYTResults *result in movieSearch.results)
        {
            Results *resultDestination = [[self class] initResultFromModel:result];
            [results addObject:resultDestination];
        }
        resultForCoreData.results = results;
        NSLog(@"resultForCoreData :%@",resultForCoreData);
        
    }
    return resultForCoreData;
}

+(Multimedia *)initMultimediaFromModel:(NYTMultimedia *)model;
{
    Multimedia *resultForCoreData = [Multimedia MR_createEntity];
    resultForCoreData.resource.src = model.resource.src;
    resultForCoreData.resource.width = model.resource.width;
    resultForCoreData.resource.type = model.resource.type;
    resultForCoreData.resource.height = model.resource.height;
    return resultForCoreData;
}

+ (void)setLinkForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result
{
    coreDataModel.link = [Link MR_createEntity];
    coreDataModel.link.type = result.link.type;
    coreDataModel.link.url = result.link.url;
    coreDataModel.link.suggestedLinkText = result.link.suggestedLinkText;
}

+ (void)setMultimediaForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result
{
    coreDataModel.multimedia = [Multimedia MR_createEntity];
    [[self class] setResourcesForDataModel:coreDataModel.multimedia fromModel:result];
}

+ (void)setResourcesForDataModel:(Multimedia *)multimediaModel fromModel:(NYTResults *)result
{
    multimediaModel.resource = [Resource MR_createEntity];
    multimediaModel.resource.src = result.multimedia.resource.src;
    multimediaModel.resource.width = result.multimedia.resource.width;
    multimediaModel.resource.type = result.multimedia.resource.type;
    multimediaModel.resource.height = result.multimedia.resource.height;
    multimediaModel.resource.multimedia = multimediaModel;
    
}
+ (RelatedUrls *)initRelatedUrlsFromModel:(NYTRelatedUrls *)relatedUrlsOrigin
{
    RelatedUrls *relatedUrlsDestination = [RelatedUrls MR_createEntity];
    relatedUrlsDestination.type = relatedUrlsOrigin.type;
    relatedUrlsDestination.suggestedLinkText = relatedUrlsOrigin.suggestedLinkText;
    relatedUrlsDestination.url = relatedUrlsOrigin.url;
    return relatedUrlsDestination;
}

+ (void)addRelatedUrlsToCoreDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result
{
    if (coreDataModel && result.relatedUrls)
    {
        NSMutableSet *relatedURLS = [NSMutableSet new];
        for (NYTRelatedUrls *relatedUrlsOrigin in result.relatedUrls)
        {
            RelatedUrls *relatedUrlsDestination = [[self class]initRelatedUrlsFromModel:relatedUrlsOrigin];
            relatedUrlsDestination.results = coreDataModel;
            [relatedURLS addObject:relatedUrlsDestination];
        }
        coreDataModel.relatedUrls = relatedURLS;
        
    }
}
+ (NYTResults *)initResultFromCoreDataModel:(Results *)result
{
    NYTResults *regularModel = [NYTResults new];
    regularModel.capsuleReview = result.capsuleReview;
    regularModel.dateUpdated = result.dateUpdated;
    regularModel.summaryShort = result.summaryShort;
    regularModel.headline = result.headline;
    regularModel.thousandBest = result.thousandBest;
    regularModel.byline = result.byline;
    regularModel.dvdReleaseDate = result.dvdReleaseDate;
    regularModel.mpaaRating = result.mpaaRating;
    regularModel.publicationDate = result.publicationDate;
    regularModel.openingDate = result.openingDate;
    regularModel.displayTitle = result.displayTitle;
    regularModel.sortName = result.sortName;
    regularModel.seoName = result.seoName;
    regularModel.criticsPick = result.criticsPick;
    regularModel.nytMovieId = result.nytMovieId;
    
    regularModel.link = nil;
    if (result.link)
    {
        //        if (![[result.link a] isEqual:[NSDictionary new]])
        {
            [[self class]setLinkForRegularModel:regularModel fromCoreDataModel:result];
        }
    }
    
    
    regularModel.multimedia = nil;
    if (result.multimedia)
    {
        //        if (![[result.multimedia dictionaryRepresentation] isEqual:[NSDictionary new]])
        {
            [[self class]setMultimediaForRegularModel:regularModel fromCoreDataModel:result];
        }
    }
    
    regularModel.relatedUrls = nil;
    if (result.relatedUrls)
    {
        if (![result.relatedUrls  isEqual:[NSArray new]])
        {
            [[self class] addRelatedUrlsToRegularModel:regularModel fromCoreDataModel:result];
        }
    }
    
    return regularModel;
    
    
}




+ (NYTMovieSearch *)initMovieSearchFromCoreDataModel:(MovieSearch *)movieSearch;
{
    NYTMovieSearch *resultForCoreData = [NYTMovieSearch new];
    resultForCoreData.status = movieSearch.status;
    resultForCoreData.copyright = movieSearch.copyright;
    resultForCoreData.numResults = movieSearch.numResults;
    resultForCoreData.results = nil;
    if (movieSearch.results)
    {
        NSMutableArray *results = [NSMutableArray new];
        for (Results *result in movieSearch.results)
        {
            NYTResults *resultDestination = [[self class] initResultFromCoreDataModel:result];
            [results addObject:resultDestination];
        }
        resultForCoreData.results = results;
        NSLog(@"resultForCoreData :%@",resultForCoreData);
        
    }
    return resultForCoreData;
}

+(NYTMultimedia *)initMultimediaFromCoreDataModel:(Multimedia *)model;
{
    NYTMultimedia *resultForCoreData = [NYTMultimedia new];
    resultForCoreData.resource.src = model.resource.src;
    resultForCoreData.resource.width = model.resource.width;
    resultForCoreData.resource.type = model.resource.type;
    resultForCoreData.resource.height = model.resource.height;
    return resultForCoreData;
}

+ (void)setLinkForRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result
{
    regularModel.link = [NYTLink new];
    regularModel.link.type = result.link.type;
    regularModel.link.url = result.link.url;
    regularModel.link.suggestedLinkText = result.link.suggestedLinkText;
}

+ (void)setMultimediaForRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result
{
    regularModel.multimedia = [NYTMultimedia new];
    [[self class] setResourcesForRegularModel:regularModel.multimedia fromCoreDataModel:result];
}

+ (void)setResourcesForRegularModel:(NYTMultimedia *)multimediaModel fromCoreDataModel:(Results *)result
{
    multimediaModel.resource = [NYTResource new];
    multimediaModel.resource.src = result.multimedia.resource.src;
    multimediaModel.resource.width = result.multimedia.resource.width;
    multimediaModel.resource.type = result.multimedia.resource.type;
    multimediaModel.resource.height = result.multimedia.resource.height;
}
+ (NYTRelatedUrls *)initRelatedUrlsFromCoreDataModel:(RelatedUrls *)relatedUrlsOrigin
{
    NYTRelatedUrls *relatedUrlsDestination = [NYTRelatedUrls new];
    relatedUrlsDestination.type = relatedUrlsOrigin.type;
    relatedUrlsDestination.suggestedLinkText = relatedUrlsOrigin.suggestedLinkText;
    relatedUrlsDestination.url = relatedUrlsOrigin.url;
    return relatedUrlsDestination;
}

+ (void)addRelatedUrlsToRegularModel:(NYTResults *)regularModel fromCoreDataModel:(Results *)result
{
    if (regularModel && result.relatedUrls)
    {
        NSMutableArray *relatedURLS = [NSMutableArray new];
        for (RelatedUrls *relatedUrlsOrigin in result.relatedUrls)
        {
            NYTRelatedUrls *relatedUrlsDestination = [[self class]initRelatedUrlsFromCoreDataModel:relatedUrlsOrigin];
            [relatedURLS addObject:relatedUrlsDestination];
        }
        regularModel.relatedUrls = relatedURLS;
        
    }
}
@end
