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
        [[self class]setLinkForDataModel:resultForCoreData fromModel:result];
    }

    
    resultForCoreData.multimedia = nil;
    if (result.multimedia)
    {
        [[self class]setMultimediaForDataModel:resultForCoreData fromModel:result];
    }
    
    resultForCoreData.relatedUrls = nil;
    if (result.relatedUrls)
    {
        [[self class] addRelatedUrlsToCoreDataModel:resultForCoreData fromModel:result];
    }
    
    resultForCoreData.movieSearch = nil;
    if (movieSearch)
    {
        resultForCoreData.movieSearch = [InteractWithModel initMovieSearchFromModel:movieSearch];
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
            Results *resultDestination = [[self class] initResultFromModel:result originatingSearch:nil];
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
    coreDataModel.link.type = result.link.type;
    coreDataModel.link.url = result.link.url;
    coreDataModel.link.suggestedLinkText = result.link.suggestedLinkText;

}

+ (void)setMultimediaForDataModel:(Results *)coreDataModel fromModel:(NYTResults *)result
{
    [[self class] setResourcesForDataModel:coreDataModel.multimedia fromModel:result];
}

+ (void)setResourcesForDataModel:(Multimedia *)multimediaModel fromModel:(NYTResults *)result
{
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
    relatedUrlsDestination.url = relatedUrlsOrigin.suggestedLinkText;
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

@end
