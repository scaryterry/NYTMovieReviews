//
//  NYTRelatedUrls.m
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NYTRelatedUrls.h"


NSString *const kNYTRelatedUrlsType = @"type";
NSString *const kNYTRelatedUrlsUrl = @"url";
NSString *const kNYTRelatedUrlsSuggestedLinkText = @"suggested_link_text";


@interface NYTRelatedUrls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYTRelatedUrls

@synthesize type = _type;
@synthesize url = _url;
@synthesize suggestedLinkText = _suggestedLinkText;


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
            self.type = [self objectOrNilForKey:kNYTRelatedUrlsType fromDictionary:dict];
            self.url = [self objectOrNilForKey:kNYTRelatedUrlsUrl fromDictionary:dict];
            self.suggestedLinkText = [self objectOrNilForKey:kNYTRelatedUrlsSuggestedLinkText fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kNYTRelatedUrlsType];
    [mutableDict setValue:self.url forKey:kNYTRelatedUrlsUrl];
    [mutableDict setValue:self.suggestedLinkText forKey:kNYTRelatedUrlsSuggestedLinkText];

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

    self.type = [aDecoder decodeObjectForKey:kNYTRelatedUrlsType];
    self.url = [aDecoder decodeObjectForKey:kNYTRelatedUrlsUrl];
    self.suggestedLinkText = [aDecoder decodeObjectForKey:kNYTRelatedUrlsSuggestedLinkText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kNYTRelatedUrlsType];
    [aCoder encodeObject:_url forKey:kNYTRelatedUrlsUrl];
    [aCoder encodeObject:_suggestedLinkText forKey:kNYTRelatedUrlsSuggestedLinkText];
}

- (id)copyWithZone:(NSZone *)zone
{
    NYTRelatedUrls *copy = [[NYTRelatedUrls alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.suggestedLinkText = [self.suggestedLinkText copyWithZone:zone];
    }
    
    return copy;
}


@end
