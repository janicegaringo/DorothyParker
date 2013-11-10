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
    
    if([UIScreen isRetina])
    {
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.thumbnailRetina]];
        
    }
    else
    {
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.thumbnail]];
    }
    
    NSString *ingredientsHtmlString = [NSString stringWithFormat:@"<font face='helvetica'>%@", self.ingredients];
    [self.ingredientsWebView loadHTMLString:ingredientsHtmlString baseURL:nil];
    
    NSString *descriptionHtmlString = [NSString stringWithFormat:@"<font face='helvetica'>%@", self.description];
    [self.descriptionWebView loadHTMLString:descriptionHtmlString baseURL:nil];
}

@end


