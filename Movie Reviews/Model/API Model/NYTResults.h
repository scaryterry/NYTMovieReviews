//
//  NYTResults.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NYTLink, NYTMultimedia;
/**
 *  A Model object representing a movie from parsed from the JSON response of the NYT Movie reviews API
 */
@interface NYTResults : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *capsuleReview;
@property (nonatomic, copy) NSString *dateUpdated;
@property (nonatomic, copy) NSString *summaryShort;
@property (nonatomic, copy) NSString *headline;
@property (nonatomic, copy) NSString *thousandBest;
@property (nonatomic, copy) NSString *byline;
@property (nonatomic, copy) NSString *dvdReleaseDate;
@property (nonatomic, copy) NYTLink *link;
@property (nonatomic, copy) NSString *mpaaRating;
@property (nonatomic, copy) NYTMultimedia *multimedia;
@property (nonatomic, copy) NSString *publicationDate;
@property (nonatomic, copy) NSString *openingDate;
@property (nonatomic, copy) NSString *displayTitle;
@property (nonatomic, copy) NSArray *relatedUrls;
@property (nonatomic, copy) NSString *sortName;
@property (nonatomic, copy) NSString *seoName;
@property (nonatomic, copy) NSNumber *criticsPick;
@property (nonatomic, copy) NSNumber *nytMovieId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
