//
//  MovieSearch.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "MovieSearch.h"
#import "Results.h"
#import "MovieSearch.h"
#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
NSString *const kMovieSearchStatus = @"status";
NSString *const kMovieSearchResults = @"results";
NSString *const kMovieSearchCopyright = @"copyright";
NSString *const kMovieSearchNumResults = @"num_results";
@interface MovieSearch ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MovieSearch

@dynamic status;
@dynamic copyright;
@dynamic numResults;
@dynamic results;

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
        self.status = [self objectOrNilForKey:kMovieSearchStatus fromDictionary:dict];
        NSObject *receivedResults = [dict objectForKey:kMovieSearchResults];
        NSMutableArray *parsedResults = [NSMutableArray array];
        if ([receivedResults isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedResults) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedResults addObject:[Results modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedResults isKindOfClass:[NSDictionary class]]) {
            [parsedResults addObject:[Results modelObjectWithDictionary:(NSDictionary *)receivedResults]];
        }
        
        self.results = [NSSet setWithArray:parsedResults];
        self.copyright = [self objectOrNilForKey:kMovieSearchCopyright fromDictionary:dict];
        self.numResults = [self objectOrNilForKey:kMovieSearchNumResults fromDictionary:dict] ;
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kMovieSearchStatus];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kMovieSearchResults];
    [mutableDict setValue:self.copyright forKey:kMovieSearchCopyright];
    [mutableDict setValue:self.numResults forKey:kMovieSearchNumResults];
    
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
    
    self.status = [aDecoder decodeObjectForKey:kMovieSearchStatus];
    self.results = [aDecoder decodeObjectForKey:kMovieSearchResults];
    self.copyright = [aDecoder decodeObjectForKey:kMovieSearchCopyright];
    self.numResults = [aDecoder decodeObjectForKey:kMovieSearchNumResults];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.status forKey:kMovieSearchStatus];
    [aCoder encodeObject:self.results forKey:kMovieSearchResults];
    [aCoder encodeObject:self.copyright forKey:kMovieSearchCopyright];
    [aCoder encodeObject:self.numResults forKey:kMovieSearchNumResults];
}

- (id)copyWithZone:(NSZone *)zone
{
    MovieSearch *copy = [[MovieSearch alloc] init];
    
    if (copy) {
        
        copy.status = [self.status copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.copyright = [self.copyright copyWithZone:zone];
        copy.numResults = self.numResults;
    }
    
    return copy;
}

@end
