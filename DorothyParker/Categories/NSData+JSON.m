//
//  NSData+JSON.m
//  DorothyParker
//
//  Created by Janice Garingo on 11/21/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

+ (NSString *)loadJsonWithURL:(NSString *)urlToLoad withObjectName:(NSString *)objectName
{
    
    NSURL *url = [NSURL URLWithString:urlToLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSString *dataLoaded;
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *dictionary = (NSDictionary *)JSON;
        
        NSArray *data = [dictionary objectForKey:@"data"];
       
        for (id object in data) {
            NSLog(@"%@", object);
            dataLoaded = object;
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error : %@", [error localizedDescription]);
        return;
    }];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [operation start];
    
    return dataLoaded;
}

@end
