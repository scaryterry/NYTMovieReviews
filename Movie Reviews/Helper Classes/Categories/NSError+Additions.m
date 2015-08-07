//
//  NSError+Additions.m
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "NSError+Additions.h"
#import "NSDictionary+Additions.h"

@implementation NSError (Additions)
-(NSError *)returnErrorNoInternet
{
    NSError *error = [NSError errorWithDomain:(NSString *)kCFErrorDomainCFNetwork code:444 userInfo:[[NSDictionary new] errorDictionaryNoInternet]];
    return error;
}
@end
