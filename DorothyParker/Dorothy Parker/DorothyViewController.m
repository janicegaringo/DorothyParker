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
    
    [self loadJson];
    [self styleView];
}


- (void)styleView
{
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kUIColorDarkGrey;
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
}


- (void)loadJson
{
    NSURL *url = [NSURL URLWithString:kDorothyURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSDictionary *dictionary = (NSDictionary *) JSON;
        
        NSArray *data = [dictionary objectForKey:@"data"];
        [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSString *dataLoaded = [obj objectForKey:@"dorothyparker"];
            NSString *htmlString = [NSString stringWithFormat:@"<font color='white'>%@</font>", dataLoaded];
            [self.webView loadHTMLString:htmlString baseURL:nil];
            
        }];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"error : %@", [error localizedDescription]);
    }];
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [operation start];
    
}

@end
