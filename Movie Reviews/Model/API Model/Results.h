//
//  Results.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Link, Multimedia, RelatedUrls, MovieSearch;

@interface Results : NSManagedObject

@property (nonatomic, retain) NSString *capsuleReview;
@property (nonatomic, retain) NSString *dateUpdated;
@property (nonatomic, retain) NSString *summaryShort;
@property (nonatomic, retain) NSString *headline;
@property (nonatomic, retain) NSString *thousandBest;
@property (nonatomic, retain) NSString *byline;
@property (nonatomic, retain) NSString *mpaaRating;
@property (nonatomic, retain) NSString *publicationDate;
@property (nonatomic, retain) NSString *openingDate;
@property (nonatomic, retain) NSString *displayTitle;
@property (nonatomic, retain) NSString *sortName;
@property (nonatomic, retain) NSString *seoName;
@property (nonatomic, retain) NSNumber *criticsPick;
@property (nonatomic, retain) NSNumber *nytMovieId;
@property (nonatomic, retain) Link *link;
@property (nonatomic, retain) Multimedia *multimedia;
@property (nonatomic, retain) NSSet *relatedUrls;
@property (nonatomic, retain) MovieSearch *movieSearch;


@end

@interface Results (JSONModelerGeneratedAccessors)

- (void)addRelatedUrlsObject:(RelatedUrls *)value;
- (void)removeRelatedUrlsObject:(RelatedUrls *)value;
- (void)addRelatedUrls:(NSSet *)value;
- (void)removeRelatedUrls:(NSSet *)value;

@end