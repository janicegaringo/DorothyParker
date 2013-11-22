//
//  DorothyViewController.m
//  DorothyParker
//
//  Created by Janice Garingo on 11/21/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "DorothyViewController.h"

@interface DorothyViewController ()

@end

@implementation DorothyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *dataLoaded = [NSData loadJsonWithURL:kDorothyURL withObjectName:@"dorothyparker"];
    
}



@end
