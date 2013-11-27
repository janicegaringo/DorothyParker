//
//  RecipeWebViewController.m
//  DorothyParker
//
//  Created by Janice Garingo on 11/27/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "RecipeWebViewController.h"

@interface RecipeWebViewController ()

@end

@implementation RecipeWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *urlToLoad = [NSURL URLWithString:self.urlToLoad];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToLoad];
    [self.webView loadRequest:urlRequest];
}



@end
