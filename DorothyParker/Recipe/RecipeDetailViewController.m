//
//  RecipeDetailViewController.m
//  DorothyParker
//
//  Created by Janice Garingo on 10/15/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "RecipeDetailViewController.h"

@implementation RecipeDetailViewController

- (void)viewDidLoad
{
    [self setElements];
    [self styleElements];
}


- (void)setElements
{
    self.navigationItem.title = self.recipetitle;
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"recipeWebView" ofType: @"html"];
    NSError *error;
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- body -->" withString:self.recipedescription];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- ingredients -->" withString:self.ingredients];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- glassware -->" withString:self.glassware];
    html = [html stringByReplacingOccurrencesOfString:@"<!-- title -->" withString:self.recipetitle];

    if([UIScreen isRetina]) {
        html = [html stringByReplacingOccurrencesOfString:@"<!-- image -->" withString:self.thumbnailRetina];
    }
    else {
        html = [html stringByReplacingOccurrencesOfString:@"<!-- image -->" withString:self.thumbnail];
    }
    
    [self.webView loadHTMLString:html baseURL:nil];
}


- (void)styleElements
{
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kUIColorDarkGrey;
    
    [self.webView setBackgroundColor:kUIColorMedGrey];
    [self.webView setOpaque:NO];
}


@end


