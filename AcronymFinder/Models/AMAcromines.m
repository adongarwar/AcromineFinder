//
//  AMAcromine.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMAcromines.h"


@implementation AMAcromines

+(NSArray *)prepareData:(NSArray *)responseObject
{
    if (!responseObject || ![responseObject count])
        return nil;
    
    __block NSMutableArray *tempArr = [NSMutableArray array];
    
    [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tempArr addObject:[[AMAcromine alloc] initWithDictionary:obj]];
        
    }];

    return tempArr;
}



@end




@implementation AMAcromine

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self)
    {
        self.shortForm = dictionary[@"sf"];
        
        
        __block NSMutableArray *tempArr = [NSMutableArray array];
        
        NSArray *variableArr = [dictionary objectForKey:@"lfs"];
        
        [variableArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            AMLongForm *temp = [[AMLongForm alloc] initWithDictionary:obj];
            [tempArr addObject:temp];
        }];
        
        self.longForms = [NSArray arrayWithArray:tempArr];
        
        return self;
    }
    
    return nil;
}


- (void)encodeWithCoder:(NSCoder *)enCoder {
    [enCoder encodeObject:self.shortForm forKey:@"Acromine.shortForm"];
    [enCoder encodeObject:self.longForms forKey:@"Acromine.longForms"];
}


- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.shortForm = [decoder decodeObjectOfClass:[NSString class] forKey:@"Acromine.shortForm"];
        self.longForms = [decoder decodeObjectOfClass:[NSString class] forKey:@"Acromine.longForms"];
        return self;
    }
    
    return nil;
}


@end


@implementation AMLongForm

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self)
    {
        self.longForm = dictionary[@"lf"];
        self.frequency = [NSNumber numberWithInt:[dictionary[@"freq"] intValue]];
        self.since = [NSNumber numberWithInt:[dictionary[@"since"] intValue]];
        
        if ([dictionary objectForKey:@"vars"])
        {
            __block NSMutableArray *tempArr = [NSMutableArray array];
            
            NSArray *variableArr = [dictionary objectForKey:@"vars"];
            
            [variableArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                AMLongForm *temp = [[AMLongForm alloc] initWithDictionary:obj];
                [tempArr addObject:temp];
            }];
            
            self.longFormVariables = [NSArray arrayWithArray:tempArr];
        }
        
        return self;
    }
    
    return nil;
}


- (void)encodeWithCoder:(NSCoder *)enCoder {
    [enCoder encodeObject:self.longForm forKey:@"Acromine.longForm"];
    [enCoder encodeObject:self.frequency forKey:@"Acromine.frequency"];
    [enCoder encodeObject:self.since forKey:@"Acromine.since"];
    [enCoder encodeObject:self.longFormVariables forKey:@"Acromine.longFormVariables"];
}


- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.longForm = [decoder decodeObjectOfClass:[NSString class] forKey:@"Acromine.shortForm"];
        self.frequency = [decoder decodeObjectOfClass:[NSString class] forKey:@"Acromine.longForms"];
        self.since = [decoder decodeObjectOfClass:[NSString class] forKey:@"Acromine.since"];
        self.longFormVariables = [decoder decodeObjectOfClass:[NSString class] forKey:@"Acromine.longFormVariables"];
        return self;
    }
    return nil;
}


@end