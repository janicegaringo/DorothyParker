//
//  UIScreen+Retina.m
//  DorothyParker
//
//  Created by Janice Garingo on 10/18/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "UIScreen+Retina.h"

@implementation UIScreen (Retina)

+ (BOOL)isRetina
{
    static int isRetina = -1;
    
    if(isRetina == -1) isRetina = [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f;
    return isRetina;
}

@end
