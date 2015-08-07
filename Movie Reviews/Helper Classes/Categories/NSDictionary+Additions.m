//
//  NSDictionary+Additions.m
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)
-(NSDictionary *)errorDictionaryNoInternet
{
    NSDictionary *dictConnectionError = @{NSLocalizedDescriptionKey:@"No Internet Connection Is Available",
                                          NSLocalizedRecoverySuggestionErrorKey:@"Enable WiFi or your mobile data",NSLocalizedFailureReasonErrorKey:@"No Internet Connection Is Available"};
    return dictConnectionError;
}
@end
