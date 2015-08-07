//
//  Resource.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Multimedia;

@interface Resource : NSManagedObject

@property (nonatomic, retain) NSString *src;
@property (nonatomic, retain) NSNumber *width;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSNumber *height;
@property (nonatomic, retain) Multimedia *multimedia;


@end

