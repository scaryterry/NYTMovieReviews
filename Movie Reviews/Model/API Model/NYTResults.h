//
//  NYTResults.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NYTLink, NYTMultimedia;

@interface NYTResults : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *capsuleReview;
@property (nonatomic, strong) NSString *dateUpdated;
@property (nonatomic, strong) NSString *summaryShort;
@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *thousandBest;
@property (nonatomic, strong) NSString *byline;
@property (nonatomic, strong) NSString *dvdReleaseDate;
@property (nonatomic, strong) NYTLink *link;
@property (nonatomic, strong) NSString *mpaaRating;
@property (nonatomic, strong) NYTMultimedia *multimedia;
@property (nonatomic, strong) NSString *publicationDate;
@property (nonatomic, strong) NSString *openingDate;
@property (nonatomic, strong) NSString *displayTitle;
@property (nonatomic, strong) NSArray *relatedUrls;
@property (nonatomic, strong) NSString *sortName;
@property (nonatomic, strong) NSString *seoName;
@property (nonatomic, assign) NSNumber *criticsPick;
@property (nonatomic, assign) NSNumber *nytMovieId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
