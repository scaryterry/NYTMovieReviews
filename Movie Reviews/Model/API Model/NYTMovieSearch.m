//
//  NYTMovieSearch.m
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NYTMovieSearch.h"
#import "NYTResults.h"


NSString *const kNYTMovieSearchStatus = @"status";
NSString *const kNYTMovieSearchResults = @"results";
NSString *const kNYTMovieSearchCopyright = @"copyright";
NSString *const kNYTMovieSearchNumResults = @"num_results";


@interface NYTMovieSearch ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYTMovieSearch

@synthesize status = _status;
@synthesize results = _results;
@synthesize copyright = _copyright;
@synthesize numResults = _numResults;


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
            self.status = [self objectOrNilForKey:kNYTMovieSearchStatus fromDictionary:dict];
    NSObject *receivedNYTResults = [dict objectForKey:kNYTMovieSearchResults];
    NSMutableArray *parsedNYTResults = [NSMutableArray array];
    if ([receivedNYTResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNYTResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNYTResults addObject:[NYTResults modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNYTResults isKindOfClass:[NSDictionary class]]) {
       [parsedNYTResults addObject:[NYTResults modelObjectWithDictionary:(NSDictionary *)receivedNYTResults]];
    }

    self.results = [NSArray arrayWithArray:parsedNYTResults];
            self.copyright = [self objectOrNilForKey:kNYTMovieSearchCopyright fromDictionary:dict];
            self.numResults = [self objectOrNilForKey:kNYTMovieSearchNumResults fromDictionary:dict] ;

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kNYTMovieSearchStatus];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    for (NSObject *subArrayObject in self.results) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kNYTMovieSearchResults];
    [mutableDict setValue:self.copyright forKey:kNYTMovieSearchCopyright];
    [mutableDict setValue:self.numResults forKey:kNYTMovieSearchNumResults];

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

    self.status = [aDecoder decodeObjectForKey:kNYTMovieSearchStatus];
    self.results = [aDecoder decodeObjectForKey:kNYTMovieSearchResults];
    self.copyright = [aDecoder decodeObjectForKey:kNYTMovieSearchCopyright];
    self.numResults = [aDecoder decodeObjectForKey:kNYTMovieSearchNumResults];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kNYTMovieSearchStatus];
    [aCoder encodeObject:_results forKey:kNYTMovieSearchResults];
    [aCoder encodeObject:_copyright forKey:kNYTMovieSearchCopyright];
    [aCoder encodeObject:_numResults forKey:kNYTMovieSearchNumResults];
}

- (id)copyWithZone:(NSZone *)zone
{
    NYTMovieSearch *copy = [[NYTMovieSearch alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.copyright = [self.copyright copyWithZone:zone];
        copy.numResults = self.numResults;
    }
    
    return copy;
}


@end
