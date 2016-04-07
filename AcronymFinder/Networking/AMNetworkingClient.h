//
//  AMNetworkingClient.h
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AMNetworkingClient : AFHTTPSessionManager

+ (AMNetworkingClient *)sharedAMNetworkingClient;
+ (void)cancelAll;

@end
