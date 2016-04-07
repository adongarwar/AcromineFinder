//
//  AMWSGetAcromines.h
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AMWSGetAcromines : NSObject

+ (void) getAcrominesWithUrl:(NSString *)acronimeFinder
                forShortForm:(NSString *)shortForm
             completionBlock:(void (^)(NSArray *responseArray))successBlock
                     failure:(void (^)(NSError * inError))failureBlock;


@end
