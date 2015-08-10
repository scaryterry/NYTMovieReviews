//
//  MovieSearch.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Results;
@class NYTMovieSearch;
@interface MovieSearch : NSManagedObject <NSCoding, NSCopying>

@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *copyright;
@property (nonatomic, retain) NSNumber *numResults;
@property (nonatomic, retain) NSSet *results;


@end

@interface MovieSearch (JSONModelerGeneratedAccessors)
+ (MovieSearch *)initFromModel:(NYTMovieSearch *)model;
- (void)addResultsObject:(Results *)value;
- (void)removeResultsObject:(Results *)value;
- (void)addResults:(NSSet *)value;
- (void)removeResults:(NSSet *)value;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end