//
//  AMWSGetAcromines.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMWSGetAcromines.h"
#import "AMNetworkingClient.h"
#import "AMAcromines.h"

static NSString * const kAcromineRESTServiceURLString = @"http://www.nactem.ac.uk/";
static NSString * const kShortFormInputJSONKey = @"sf";

@implementation AMWSGetAcromines

+ (void) getAcrominesWithUrl:(NSString *)acronimeFinder
                forShortForm:(NSString *)shortForm
             completionBlock:(void (^)(NSArray *responseArray))successBlock
                     failure:(void (^)(NSError * inError))failureBlock {
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[kShortFormInputJSONKey] = shortForm;
    
    [[AMNetworkingClient sharedAMNetworkingClient] GET:acronimeFinder
                                            parameters:parameters
                                               success:^(NSURLSessionDataTask *task, id responseObject) {
         
         successBlock([AMAcromines prepareData:responseObject]);
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         
         failureBlock(error);
     }];
    
    
    
    
    
}

@end
