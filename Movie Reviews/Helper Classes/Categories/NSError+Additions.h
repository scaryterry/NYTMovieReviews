//
//  NSError+Additions.h
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Helper category class that is used in conjuction with the NSDictionary+Additions category throughout the app whenever we want to inform the user that no internet activity is present; may be an overkill as a category, but as more custom errors are needed by the app, these categories should make it much easier to maintain them all
 */
@interface NSError (Additions)
/**
 *  Creates an NSError that describes that we dont have internet *
 *  @return The error describing that no internet is present
 */
-(NSError *)returnErrorNoInternet;
@end
