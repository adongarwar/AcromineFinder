//
//  AMAcromine.h
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMAcromines : NSObject 

+(NSArray *)prepareData:(NSArray *)responseObject;

@end



@interface AMAcromine : NSObject <NSCoding>

@property (nonatomic, strong) NSString *shortForm;
@property (nonatomic, strong) NSArray *longForms;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface AMLongForm : NSObject <NSCoding>

@property (nonatomic, strong) NSString *longForm;
@property (nonatomic, strong) NSNumber *frequency;
@property (nonatomic, strong) NSNumber *since;
@property (nonatomic, strong) NSArray *longFormVariables;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
