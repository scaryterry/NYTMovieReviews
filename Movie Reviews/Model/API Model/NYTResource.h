//
//  NYTResource.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NYTResource : NSObject <NSCoding, NSCopying>

@property (nonatomic, copy) NSString *src;
@property (nonatomic, copy) NSNumber *width;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSNumber *height;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
