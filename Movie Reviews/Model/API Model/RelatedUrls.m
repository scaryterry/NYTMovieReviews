//
//  RelatedUrls.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "RelatedUrls.h"
#import "Results.h"
#import "DataModels.h"
NSString *const kRelatedUrlsType = @"type";
NSString *const kRelatedUrlsUrl = @"url";
NSString *const kRelatedUrlsSuggestedLinkText = @"suggested_link_text";


@interface RelatedUrls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RelatedUrls

@dynamic type;
@dynamic url;
@dynamic suggestedLinkText;
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
        self.type = [self objectOrNilForKey:kRelatedUrlsType fromDictionary:dict];
        self.url = [self objectOrNilForKey:kRelatedUrlsUrl fromDictionary:dict];
        self.suggestedLinkText = [self objectOrNilForKey:kRelatedUrlsSuggestedLinkText fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kRelatedUrlsType];
    [mutableDict setValue:self.url forKey:kRelatedUrlsUrl];
    [mutableDict setValue:self.suggestedLinkText forKey:kRelatedUrlsSuggestedLinkText];
    
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
    
    self.type = [aDecoder decodeObjectForKey:kRelatedUrlsType];
    self.url = [aDecoder decodeObjectForKey:kRelatedUrlsUrl];
    self.suggestedLinkText = [aDecoder decodeObjectForKey:kRelatedUrlsSuggestedLinkText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.type forKey:kRelatedUrlsType];
    [aCoder encodeObject:self.url forKey:kRelatedUrlsUrl];
    [aCoder encodeObject:self.suggestedLinkText forKey:kRelatedUrlsSuggestedLinkText];
}

- (id)copyWithZone:(NSZone *)zone
{
    RelatedUrls *copy = [[RelatedUrls alloc] init];
    
    if (copy) {
        
        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.suggestedLinkText = [self.suggestedLinkText copyWithZone:zone];
    }
    
    return copy;
}
@end
