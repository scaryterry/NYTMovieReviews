//
//  NYTLink.m
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NYTLink.h"


NSString *const kNYTLinkType = @"type";
NSString *const kNYTLinkUrl = @"url";
NSString *const kNYTLinkSuggestedLinkText = @"suggested_link_text";


@interface NYTLink ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYTLink

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
            self.type = [self objectOrNilForKey:kNYTLinkType fromDictionary:dict];
            self.url = [self objectOrNilForKey:kNYTLinkUrl fromDictionary:dict];
            self.suggestedLinkText = [self objectOrNilForKey:kNYTLinkSuggestedLinkText fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kNYTLinkType];
    [mutableDict setValue:self.url forKey:kNYTLinkUrl];
    [mutableDict setValue:self.suggestedLinkText forKey:kNYTLinkSuggestedLinkText];

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

    self.type = [aDecoder decodeObjectForKey:kNYTLinkType];
    self.url = [aDecoder decodeObjectForKey:kNYTLinkUrl];
    self.suggestedLinkText = [aDecoder decodeObjectForKey:kNYTLinkSuggestedLinkText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kNYTLinkType];
    [aCoder encodeObject:_url forKey:kNYTLinkUrl];
    [aCoder encodeObject:_suggestedLinkText forKey:kNYTLinkSuggestedLinkText];
}

- (id)copyWithZone:(NSZone *)zone
{
    NYTLink *copy = [[NYTLink alloc] init];
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.suggestedLinkText = [self.suggestedLinkText copyWithZone:zone];
    }
    
    return copy;
}


@end
