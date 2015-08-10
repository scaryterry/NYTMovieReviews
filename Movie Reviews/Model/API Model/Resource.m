//
//  Resource.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "Resource.h"
#import "Multimedia.h"
NSString *const kResourceSrc = @"src";
NSString *const kResourceWidth = @"width";
NSString *const kResourceType = @"type";
NSString *const kResourceHeight = @"height";


@interface Resource ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end


@implementation Resource

@dynamic src;
@dynamic width;
@dynamic type;
@dynamic height;
@dynamic multimedia;
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
        self.src = [self objectOrNilForKey:kResourceSrc fromDictionary:dict];
        self.width = [self objectOrNilForKey:kResourceWidth fromDictionary:dict];
        self.type = [self objectOrNilForKey:kResourceType fromDictionary:dict];
        self.height = [self objectOrNilForKey:kResourceHeight fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.src forKey:kResourceSrc];
    [mutableDict setValue:self.width forKey:kResourceWidth];
    [mutableDict setValue:self.type forKey:kResourceType];
    [mutableDict setValue:self.height forKey:kResourceHeight];
    
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
    
    self.src = [aDecoder decodeObjectForKey:kResourceSrc];
    self.width = [aDecoder decodeObjectForKey:kResourceWidth];
    self.type = [aDecoder decodeObjectForKey:kResourceType];
    self.height = [aDecoder decodeObjectForKey:kResourceHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.src forKey:kResourceSrc];
    [aCoder encodeObject:self.width forKey:kResourceWidth];
    [aCoder encodeObject:self.type forKey:kResourceType];
    [aCoder encodeObject:self.height forKey:kResourceHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    Resource *copy = [[Resource alloc] init];
    
    if (copy) {
        
        copy.src = [self.src copyWithZone:zone];
        copy.width = self.width;
        copy.type = [self.type copyWithZone:zone];
        copy.height = self.height;
    }
    
    return copy;
}
@end
