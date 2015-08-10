//
//  Link.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "Link.h"
#import "Results.h"


NSString *const kLinkType = @"type";
NSString *const kLinkUrl = @"url";
NSString *const kLinkSuggestedLinkText = @"suggested_link_text";


@interface Link ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end
@implementation Link

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
        self.type = [self objectOrNilForKey:kLinkType fromDictionary:dict];
        self.url = [self objectOrNilForKey:kLinkUrl fromDictionary:dict];
        self.suggestedLinkText = [self objectOrNilForKey:kLinkSuggestedLinkText fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kLinkType];
    [mutableDict setValue:self.url forKey:kLinkUrl];
    [mutableDict setValue:self.suggestedLinkText forKey:kLinkSuggestedLinkText];
    
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
    
    self.type = [aDecoder decodeObjectForKey:kLinkType];
    self.url = [aDecoder decodeObjectForKey:kLinkUrl];
    self.suggestedLinkText = [aDecoder decodeObjectForKey:kLinkSuggestedLinkText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.type forKey:kLinkType];
    [aCoder encodeObject:self.url forKey:kLinkUrl];
    [aCoder encodeObject:self.suggestedLinkText forKey:kLinkSuggestedLinkText];
}

- (id)copyWithZone:(NSZone *)zone
{
    Link *copy = [[Link alloc] init];
    
    if (copy) {
        
        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.suggestedLinkText = [self.suggestedLinkText copyWithZone:zone];
    }
    
    return copy;
}

@end
