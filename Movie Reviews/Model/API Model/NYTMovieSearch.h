//
//  NYTMovieSearch.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYTMovieSearch : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSArray *results;
@property (nonatomic, copy) NSString *copyright;
@property (nonatomic, copy) NSNumber *numResults;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
