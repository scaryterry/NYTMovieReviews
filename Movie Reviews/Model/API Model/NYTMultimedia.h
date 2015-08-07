//
//  NYTMultimedia.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NYTResource;

@interface NYTMultimedia : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NYTResource *resource;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
