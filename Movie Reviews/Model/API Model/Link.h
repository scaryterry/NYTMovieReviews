//
//  Link.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Results;

@interface Link : NSManagedObject <NSCoding, NSCopying>

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *suggestedLinkText;
@property (nonatomic, retain) Results *results;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

