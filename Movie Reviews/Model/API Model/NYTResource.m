//
//  NYTResource.m
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NYTResource.h"


NSString *const kNYTResourceSrc = @"src";
NSString *const kNYTResourceWidth = @"width";
NSString *const kNYTResourceType = @"type";
NSString *const kNYTResourceHeight = @"height";


@interface NYTResource ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NYTResource

@synthesize src = _src;
@synthesize width = _width;
@synthesize type = _type;
@synthesize height = _height;


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
            self.src = [self objectOrNilForKey:kNYTResourceSrc fromDictionary:dict];
            self.width = [self objectOrNilForKey:kNYTResourceWidth fromDictionary:dict];
            self.type = [self objectOrNilForKey:kNYTResourceType fromDictionary:dict];
            self.height = [self objectOrNilForKey:kNYTResourceHeight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.src forKey:kNYTResourceSrc];
    [mutableDict setValue:self.width forKey:kNYTResourceWidth];
    [mutableDict setValue:self.type forKey:kNYTResourceType];
    [mutableDict setValue:self.height forKey:kNYTResourceHeight];

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

    self.src = [aDecoder decodeObjectForKey:kNYTResourceSrc];
    self.width = [aDecoder decodeObjectForKey:kNYTResourceWidth];
    self.type = [aDecoder decodeObjectForKey:kNYTResourceType];
    self.height = [aDecoder decodeObjectForKey:kNYTResourceHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_src forKey:kNYTResourceSrc];
    [aCoder encodeObject:_width forKey:kNYTResourceWidth];
    [aCoder encodeObject:_type forKey:kNYTResourceType];
    [aCoder encodeObject:_height forKey:kNYTResourceHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    NYTResource *copy = [[NYTResource alloc] init];
    
    if (copy) {

        copy.src = [self.src copyWithZone:zone];
        copy.width = self.width;
        copy.type = [self.type copyWithZone:zone];
        copy.height = self.height;
    }
    
    return copy;
}


@end
