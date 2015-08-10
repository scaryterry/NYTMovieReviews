//
//  Multimedia.m
//
//  Created by (null) (null) on 07/08/2015
//  Copyright (c) 2015 (null). All rights reserved.
//

#import "Multimedia.h"
#import "Resource.h"
#import "Results.h"

#import "DataModels.h"
NSString *const kMultimediaResource = @"resource";

@interface Multimedia ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Multimedia

@dynamic resource;
@dynamic results;

+(instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.resource = [Resource modelObjectWithDictionary:[dict objectForKey:kMultimediaResource]];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.resource dictionaryRepresentation] forKey:kMultimediaResource];
    
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
    
    self.resource = [aDecoder decodeObjectForKey:kMultimediaResource];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.resource forKey:kMultimediaResource];
}

- (id)copyWithZone:(NSZone *)zone
{
    Multimedia *copy = [[Multimedia alloc] init];
    
    if (copy) {
        
        copy.resource = [self.resource copyWithZone:zone];
    }
    
    return copy;
}


@end
