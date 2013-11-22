//
//  NSData+JSON.h
//  DorothyParker
//
//  Created by Janice Garingo on 11/21/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JSON)

+ (NSString *)loadJsonWithURL:(NSString *)urlToLoad withObjectName:(NSString *)objectName; 

@end
