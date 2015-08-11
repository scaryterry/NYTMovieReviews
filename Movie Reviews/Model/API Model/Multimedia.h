//
//  Multimedia.h
//
//  Created by   on 07/08/2015
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Resource, Results;

@interface Multimedia : NSManagedObject

@property (nonatomic, retain) Resource *resource;
@property (nonatomic, retain) Results *results;


@end

