//
//  NYTMultimedia.m
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NYTMultimedia.h"
#import "NYTResource.h"


NSString *const kNYTMultimediaResource = @"resource";


@interface NYTMultimedia ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYTMultimedia

@synthesize resource = _resource;


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
            self.resource = [NYTResource modelObjectWithDictionary:[dict objectForKey:kNYTMultimediaResource]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.resource dictionaryRepresentation] forKey:kNYTMultimediaResource];

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

    self.resource = [aDecoder decodeObjectForKey:kNYTMultimediaResource];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resource forKey:kNYTMultimediaResource];
}

- (id)copyWithZone:(NSZone *)zone
{
    NYTMultimedia *copy = [[NYTMultimedia alloc] init];
    
    if (copy) {

        copy.resource = [self.resource copyWithZone:zone];
    }
    
    return copy;
}


@end
