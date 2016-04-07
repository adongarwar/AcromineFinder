//
//  AMNetworkingClient.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMNetworkingClient.h"

static NSString * const kAcromineRESTServiceURLString = @"http://www.nactem.ac.uk";

@implementation AMNetworkingClient


+ (AMNetworkingClient *)sharedAMNetworkingClient
{
    static AMNetworkingClient *_sharedAMNetworkingClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAMNetworkingClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAcromineRESTServiceURLString]];
    });
    
    return _sharedAMNetworkingClient;
}


- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",nil];
    }
    
    return self;
}


+ (void)cancelAll
{
    [[AMNetworkingClient manager] invalidateSessionCancelingTasks:YES];
}

@end
