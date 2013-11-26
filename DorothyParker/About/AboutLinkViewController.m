//
//  AboutLinkViewController.m
//  DorothyParker
//
//  Created by Janice Garingo on 11/26/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "AboutLinkViewController.h"

@interface AboutLinkViewController ()

@end

@implementation AboutLinkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"loading: self.urlToLoad : %@", self.urlToLoad);
    
   // [self.webView loadHTMLString:self.urlToLoad baseURL:nil];

   // [self.webView loadHTMLString:@"http://www.amazon.com/exec/obidos/ASIN/076279268X/dorothparkersnew" baseURL:nil];
    
    NSURL *urlToLoad = [NSURL URLWithString:self.urlToLoad];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToLoad];
    [self.webView loadRequest:urlRequest];
}



@end
