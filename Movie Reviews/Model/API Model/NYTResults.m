//
//  NYTResults.m
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NYTResults.h"
#import "NYTLink.h"
#import "NYTMultimedia.h"
#import "NYTRelatedUrls.h"


NSString *const kNYTResultsCapsuleReview = @"capsule_review";
NSString *const kNYTResultsDateUpdated = @"date_updated";
NSString *const kNYTResultsSummaryShort = @"summary_short";
NSString *const kNYTResultsHeadline = @"headline";
NSString *const kNYTResultsThousandBest = @"thousand_best";
NSString *const kNYTResultsByline = @"byline";
NSString *const kNYTResultsDvdReleaseDate = @"dvd_release_date";
NSString *const kNYTResultsLink = @"link";
NSString *const kNYTResultsMpaaRating = @"mpaa_rating";
NSString *const kNYTResultsMultimedia = @"multimedia";
NSString *const kNYTResultsPublicationDate = @"publication_date";
NSString *const kNYTResultsOpeningDate = @"opening_date";
NSString *const kNYTResultsDisplayTitle = @"display_title";
NSString *const kNYTResultsRelatedUrls = @"related_urls";
NSString *const kNYTResultsSortName = @"sort_name";
NSString *const kNYTResultsSeoName = @"seo_name";
NSString *const kNYTResultsCriticsPick = @"critics_pick";
NSString *const kNYTResultsNytMovieId = @"nyt_movie_id";


@interface NYTResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYTResults

@synthesize capsuleReview = _capsuleReview;
@synthesize dateUpdated = _dateUpdated;
@synthesize summaryShort = _summaryShort;
@synthesize headline = _headline;
@synthesize thousandBest = _thousandBest;
@synthesize byline = _byline;
@synthesize dvdReleaseDate = _dvdReleaseDate;
@synthesize link = _link;
@synthesize mpaaRating = _mpaaRating;
@synthesize multimedia = _multimedia;
@synthesize publicationDate = _publicationDate;
@synthesize openingDate = _openingDate;
@synthesize displayTitle = _displayTitle;
@synthesize relatedUrls = _relatedUrls;
@synthesize sortName = _sortName;
@synthesize seoName = _seoName;
@synthesize criticsPick = _criticsPick;
@synthesize nytMovieId = _nytMovieId;


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
            self.capsuleReview = [self objectOrNilForKey:kNYTResultsCapsuleReview fromDictionary:dict];
            self.dateUpdated = [self objectOrNilForKey:kNYTResultsDateUpdated fromDictionary:dict];
            self.summaryShort = [self objectOrNilForKey:kNYTResultsSummaryShort fromDictionary:dict];
            self.headline = [self objectOrNilForKey:kNYTResultsHeadline fromDictionary:dict];
            self.thousandBest = [self objectOrNilForKey:kNYTResultsThousandBest fromDictionary:dict];
            self.byline = [self objectOrNilForKey:kNYTResultsByline fromDictionary:dict];
            self.dvdReleaseDate = [self objectOrNilForKey:kNYTResultsDvdReleaseDate fromDictionary:dict];
            self.link = [NYTLink modelObjectWithDictionary:[dict objectForKey:kNYTResultsLink]];
            self.mpaaRating = [self objectOrNilForKey:kNYTResultsMpaaRating fromDictionary:dict];
            self.multimedia = [NYTMultimedia modelObjectWithDictionary:[dict objectForKey:kNYTResultsMultimedia]];
            self.publicationDate = [self objectOrNilForKey:kNYTResultsPublicationDate fromDictionary:dict];
            self.openingDate = [self objectOrNilForKey:kNYTResultsOpeningDate fromDictionary:dict];
            self.displayTitle = [self objectOrNilForKey:kNYTResultsDisplayTitle fromDictionary:dict];
    NSObject *receivedNYTRelatedUrls = [dict objectForKey:kNYTResultsRelatedUrls];
    NSMutableArray *parsedNYTRelatedUrls = [NSMutableArray array];
    if ([receivedNYTRelatedUrls isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNYTRelatedUrls) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNYTRelatedUrls addObject:[NYTRelatedUrls modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNYTRelatedUrls isKindOfClass:[NSDictionary class]]) {
       [parsedNYTRelatedUrls addObject:[NYTRelatedUrls modelObjectWithDictionary:(NSDictionary *)receivedNYTRelatedUrls]];
    }

    self.relatedUrls = [NSArray arrayWithArray:parsedNYTRelatedUrls];
            self.sortName = [self objectOrNilForKey:kNYTResultsSortName fromDictionary:dict];
            self.seoName = [self objectOrNilForKey:kNYTResultsSeoName fromDictionary:dict];
            self.criticsPick = [self objectOrNilForKey:kNYTResultsCriticsPick fromDictionary:dict];
            self.nytMovieId = [self objectOrNilForKey:kNYTResultsNytMovieId fromDictionary:dict] ;

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.capsuleReview forKey:kNYTResultsCapsuleReview];
    [mutableDict setValue:self.dateUpdated forKey:kNYTResultsDateUpdated];
    [mutableDict setValue:self.summaryShort forKey:kNYTResultsSummaryShort];
    [mutableDict setValue:self.headline forKey:kNYTResultsHeadline];
    [mutableDict setValue:self.thousandBest forKey:kNYTResultsThousandBest];
    [mutableDict setValue:self.byline forKey:kNYTResultsByline];
    [mutableDict setValue:self.dvdReleaseDate forKey:kNYTResultsDvdReleaseDate];
    [mutableDict setValue:[self.link dictionaryRepresentation] forKey:kNYTResultsLink];
    [mutableDict setValue:self.mpaaRating forKey:kNYTResultsMpaaRating];
    [mutableDict setValue:[self.multimedia dictionaryRepresentation] forKey:kNYTResultsMultimedia];
    [mutableDict setValue:self.publicationDate forKey:kNYTResultsPublicationDate];
    [mutableDict setValue:self.openingDate forKey:kNYTResultsOpeningDate];
    [mutableDict setValue:self.displayTitle forKey:kNYTResultsDisplayTitle];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRelatedUrls] forKey:kNYTResultsRelatedUrls];
    [mutableDict setValue:self.sortName forKey:kNYTResultsSortName];
    [mutableDict setValue:self.seoName forKey:kNYTResultsSeoName];
    [mutableDict setValue:self.criticsPick forKey:kNYTResultsCriticsPick];
    [mutableDict setValue:self.nytMovieId forKey:kNYTResultsNytMovieId];

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

    self.capsuleReview = [aDecoder decodeObjectForKey:kNYTResultsCapsuleReview];
    self.dateUpdated = [aDecoder decodeObjectForKey:kNYTResultsDateUpdated];
    self.summaryShort = [aDecoder decodeObjectForKey:kNYTResultsSummaryShort];
    self.headline = [aDecoder decodeObjectForKey:kNYTResultsHeadline];
    self.thousandBest = [aDecoder decodeObjectForKey:kNYTResultsThousandBest];
    self.byline = [aDecoder decodeObjectForKey:kNYTResultsByline];
    self.dvdReleaseDate = [aDecoder decodeObjectForKey:kNYTResultsDvdReleaseDate];
    self.link = [aDecoder decodeObjectForKey:kNYTResultsLink];
    self.mpaaRating = [aDecoder decodeObjectForKey:kNYTResultsMpaaRating];
    self.multimedia = [aDecoder decodeObjectForKey:kNYTResultsMultimedia];
    self.publicationDate = [aDecoder decodeObjectForKey:kNYTResultsPublicationDate];
    self.openingDate = [aDecoder decodeObjectForKey:kNYTResultsOpeningDate];
    self.displayTitle = [aDecoder decodeObjectForKey:kNYTResultsDisplayTitle];
    self.relatedUrls = [aDecoder decodeObjectForKey:kNYTResultsRelatedUrls];
    self.sortName = [aDecoder decodeObjectForKey:kNYTResultsSortName];
    self.seoName = [aDecoder decodeObjectForKey:kNYTResultsSeoName];
    self.criticsPick = [aDecoder decodeObjectForKey:kNYTResultsCriticsPick];
    self.nytMovieId = [aDecoder decodeObjectForKey:kNYTResultsNytMovieId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_capsuleReview forKey:kNYTResultsCapsuleReview];
    [aCoder encodeObject:_dateUpdated forKey:kNYTResultsDateUpdated];
    [aCoder encodeObject:_summaryShort forKey:kNYTResultsSummaryShort];
    [aCoder encodeObject:_headline forKey:kNYTResultsHeadline];
    [aCoder encodeObject:_thousandBest forKey:kNYTResultsThousandBest];
    [aCoder encodeObject:_byline forKey:kNYTResultsByline];
    [aCoder encodeObject:_dvdReleaseDate forKey:kNYTResultsDvdReleaseDate];
    [aCoder encodeObject:_link forKey:kNYTResultsLink];
    [aCoder encodeObject:_mpaaRating forKey:kNYTResultsMpaaRating];
    [aCoder encodeObject:_multimedia forKey:kNYTResultsMultimedia];
    [aCoder encodeObject:_publicationDate forKey:kNYTResultsPublicationDate];
    [aCoder encodeObject:_openingDate forKey:kNYTResultsOpeningDate];
    [aCoder encodeObject:_displayTitle forKey:kNYTResultsDisplayTitle];
    [aCoder encodeObject:_relatedUrls forKey:kNYTResultsRelatedUrls];
    [aCoder encodeObject:_sortName forKey:kNYTResultsSortName];
    [aCoder encodeObject:_seoName forKey:kNYTResultsSeoName];
    [aCoder encodeObject:_criticsPick forKey:kNYTResultsCriticsPick];
    [aCoder encodeObject:_nytMovieId forKey:kNYTResultsNytMovieId];
}

- (id)copyWithZone:(NSZone *)zone
{
    NYTResults *copy = [[NYTResults alloc] init];
    
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
