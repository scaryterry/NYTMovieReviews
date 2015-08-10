//
//  Results.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "Results.h"
#import "Link.h"
#import "Multimedia.h"
#import "RelatedUrls.h"
#import "MovieSearch.h"

NSString *const kResultsCapsuleReview = @"capsule_review";
NSString *const kResultsDateUpdated = @"date_updated";
NSString *const kResultsSummaryShort = @"summary_short";
NSString *const kResultsHeadline = @"headline";
NSString *const kResultsThousandBest = @"thousand_best";
NSString *const kResultsByline = @"byline";
NSString *const kResultsDvdReleaseDate = @"dvd_release_date";
NSString *const kResultsLink = @"link";
NSString *const kResultsMpaaRating = @"mpaa_rating";
NSString *const kResultsMultimedia = @"multimedia";
NSString *const kResultsPublicationDate = @"publication_date";
NSString *const kResultsOpeningDate = @"opening_date";
NSString *const kResultsDisplayTitle = @"display_title";
NSString *const kResultsRelatedUrls = @"related_urls";
NSString *const kResultsSortName = @"sort_name";
NSString *const kResultsSeoName = @"seo_name";
NSString *const kResultsCriticsPick = @"critics_pick";
NSString *const kResultsNytMovieId = @"nyt_movie_id";


@interface Results ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Results

@dynamic capsuleReview;
@dynamic dateUpdated;
@dynamic summaryShort;
@dynamic headline;
@dynamic thousandBest;
@dynamic byline;
@dynamic dvdReleaseDate;
@dynamic mpaaRating;
@dynamic publicationDate;
@dynamic openingDate;
@dynamic displayTitle;
@dynamic sortName;
@dynamic seoName;
@dynamic criticsPick;
@dynamic nytMovieId;
@dynamic link;
@dynamic multimedia;
@dynamic relatedUrls;
@dynamic movieSearch;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.capsuleReview = [self objectOrNilForKey:kResultsCapsuleReview fromDictionary:dict];
        self.dateUpdated = [self objectOrNilForKey:kResultsDateUpdated fromDictionary:dict];
        self.summaryShort = [self objectOrNilForKey:kResultsSummaryShort fromDictionary:dict];
        self.headline = [self objectOrNilForKey:kResultsHeadline fromDictionary:dict];
        self.thousandBest = [self objectOrNilForKey:kResultsThousandBest fromDictionary:dict];
        self.byline = [self objectOrNilForKey:kResultsByline fromDictionary:dict];
        self.dvdReleaseDate = [self objectOrNilForKey:kResultsDvdReleaseDate fromDictionary:dict];
        self.link = [Link modelObjectWithDictionary:[dict objectForKey:kResultsLink]];
        self.mpaaRating = [self objectOrNilForKey:kResultsMpaaRating fromDictionary:dict];
        self.multimedia = [Multimedia modelObjectWithDictionary:[dict objectForKey:kResultsMultimedia]];
        self.publicationDate = [self objectOrNilForKey:kResultsPublicationDate fromDictionary:dict];
        self.openingDate = [self objectOrNilForKey:kResultsOpeningDate fromDictionary:dict];
        self.displayTitle = [self objectOrNilForKey:kResultsDisplayTitle fromDictionary:dict];
        NSObject *receivedRelatedUrls = [dict objectForKey:kResultsRelatedUrls];
        NSMutableArray *parsedRelatedUrls = [NSMutableArray array];
        if ([receivedRelatedUrls isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedRelatedUrls) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedRelatedUrls addObject:[RelatedUrls modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedRelatedUrls isKindOfClass:[NSDictionary class]]) {
            [parsedRelatedUrls addObject:[RelatedUrls modelObjectWithDictionary:(NSDictionary *)receivedRelatedUrls]];
        }
        
        self.relatedUrls = [NSSet setWithArray:parsedRelatedUrls];
        self.sortName = [self objectOrNilForKey:kResultsSortName fromDictionary:dict];
        self.seoName = [self objectOrNilForKey:kResultsSeoName fromDictionary:dict];
        self.criticsPick = [self objectOrNilForKey:kResultsCriticsPick fromDictionary:dict];
        self.nytMovieId = [self objectOrNilForKey:kResultsNytMovieId fromDictionary:dict] ;
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.capsuleReview forKey:kResultsCapsuleReview];
    [mutableDict setValue:self.dateUpdated forKey:kResultsDateUpdated];
    [mutableDict setValue:self.summaryShort forKey:kResultsSummaryShort];
    [mutableDict setValue:self.headline forKey:kResultsHeadline];
    [mutableDict setValue:self.thousandBest forKey:kResultsThousandBest];
    [mutableDict setValue:self.byline forKey:kResultsByline];
    [mutableDict setValue:self.dvdReleaseDate forKey:kResultsDvdReleaseDate];
    [mutableDict setValue:[self.link dictionaryRepresentation] forKey:kResultsLink];
    [mutableDict setValue:self.mpaaRating forKey:kResultsMpaaRating];
    [mutableDict setValue:[self.multimedia dictionaryRepresentation] forKey:kResultsMultimedia];
    [mutableDict setValue:self.publicationDate forKey:kResultsPublicationDate];
    [mutableDict setValue:self.openingDate forKey:kResultsOpeningDate];
    [mutableDict setValue:self.displayTitle forKey:kResultsDisplayTitle];
    NSMutableArray *tempArrayForRelatedUrls = [NSMutableArray array];
    for (NSObject *subArrayObject in self.relatedUrls) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRelatedUrls addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRelatedUrls addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelatedUrls] forKey:kResultsRelatedUrls];
    [mutableDict setValue:self.sortName forKey:kResultsSortName];
    [mutableDict setValue:self.seoName forKey:kResultsSeoName];
    [mutableDict setValue:self.criticsPick forKey:kResultsCriticsPick];
    [mutableDict setValue:self.nytMovieId forKey:kResultsNytMovieId];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.capsuleReview = [aDecoder decodeObjectForKey:kResultsCapsuleReview];
    self.dateUpdated = [aDecoder decodeObjectForKey:kResultsDateUpdated];
    self.summaryShort = [aDecoder decodeObjectForKey:kResultsSummaryShort];
    self.headline = [aDecoder decodeObjectForKey:kResultsHeadline];
    self.thousandBest = [aDecoder decodeObjectForKey:kResultsThousandBest];
    self.byline = [aDecoder decodeObjectForKey:kResultsByline];
    self.dvdReleaseDate = [aDecoder decodeObjectForKey:kResultsDvdReleaseDate];
    self.link = [aDecoder decodeObjectForKey:kResultsLink];
    self.mpaaRating = [aDecoder decodeObjectForKey:kResultsMpaaRating];
    self.multimedia = [aDecoder decodeObjectForKey:kResultsMultimedia];
    self.publicationDate = [aDecoder decodeObjectForKey:kResultsPublicationDate];
    self.openingDate = [aDecoder decodeObjectForKey:kResultsOpeningDate];
    self.displayTitle = [aDecoder decodeObjectForKey:kResultsDisplayTitle];
    self.relatedUrls = [aDecoder decodeObjectForKey:kResultsRelatedUrls];
    self.sortName = [aDecoder decodeObjectForKey:kResultsSortName];
    self.seoName = [aDecoder decodeObjectForKey:kResultsSeoName];
    self.criticsPick = [aDecoder decodeObjectForKey:kResultsCriticsPick];
    self.nytMovieId = [aDecoder decodeObjectForKey:kResultsNytMovieId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.capsuleReview forKey:kResultsCapsuleReview];
    [aCoder encodeObject:self.dateUpdated forKey:kResultsDateUpdated];
    [aCoder encodeObject:self.summaryShort forKey:kResultsSummaryShort];
    [aCoder encodeObject:self.headline forKey:kResultsHeadline];
    [aCoder encodeObject:self.thousandBest forKey:kResultsThousandBest];
    [aCoder encodeObject:self.byline forKey:kResultsByline];
    [aCoder encodeObject:self.dvdReleaseDate forKey:kResultsDvdReleaseDate];
    [aCoder encodeObject:self.link forKey:kResultsLink];
    [aCoder encodeObject:self.mpaaRating forKey:kResultsMpaaRating];
    [aCoder encodeObject:self.multimedia forKey:kResultsMultimedia];
    [aCoder encodeObject:self.publicationDate forKey:kResultsPublicationDate];
    [aCoder encodeObject:self.openingDate forKey:kResultsOpeningDate];
    [aCoder encodeObject:self.displayTitle forKey:kResultsDisplayTitle];
    [aCoder encodeObject:self.relatedUrls forKey:kResultsRelatedUrls];
    [aCoder encodeObject:self.sortName forKey:kResultsSortName];
    [aCoder encodeObject:self.seoName forKey:kResultsSeoName];
    [aCoder encodeObject:self.criticsPick forKey:kResultsCriticsPick];
    [aCoder encodeObject:self.nytMovieId forKey:kResultsNytMovieId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Results *copy = [[Results alloc] init];
    
    if (copy) {
        
        copy.capsuleReview = [self.capsuleReview copyWithZone:zone];
        copy.dateUpdated = [self.dateUpdated copyWithZone:zone];
        copy.summaryShort = [self.summaryShort copyWithZone:zone];
        copy.headline = [self.headline copyWithZone:zone];
        copy.thousandBest = [self.thousandBest copyWithZone:zone];
        copy.byline = [self.byline copyWithZone:zone];
        copy.dvdReleaseDate = [self.dvdReleaseDate copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
        copy.mpaaRating = [self.mpaaRating copyWithZone:zone];
        copy.multimedia = [self.multimedia copyWithZone:zone];
        copy.publicationDate = [self.publicationDate copyWithZone:zone];
        copy.openingDate = [self.openingDate copyWithZone:zone];
        copy.displayTitle = [self.displayTitle copyWithZone:zone];
        copy.relatedUrls = [self.relatedUrls copyWithZone:zone];
        copy.sortName = [self.sortName copyWithZone:zone];
        copy.seoName = [self.seoName copyWithZone:zone];
        copy.criticsPick = self.criticsPick;
        copy.nytMovieId = self.nytMovieId;
    }
    
    return copy;
}


@end
