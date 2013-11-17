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
    
    [self styleElements];
    
    self.navigationItem.title = self.recipetitle;
    
    if([UIScreen isRetina]) {
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.thumbnailRetina]];
    }
    else {
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.thumbnail]];
    }
    
   self.glasswareLabel.text = [NSString stringWithFormat:@"Glassware: %@", self.glassware];

    NSString *descriptionHtmlString = [NSString stringWithFormat:@"<font color='white'>%@<br><br>%@<br>%@</font>", self.recipedescription, self.recipetitle, self.ingredients];
    
    [self.webView loadHTMLString:descriptionHtmlString baseURL:nil];
}

- (void)styleElements
{
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kUIColorDarkGrey;
    
    [self.glasswareLabel setFont:[UIFont fontWithName:@"Palatino" size:16.0]];
    self.glasswareLabel.numberOfLines = 2;
    
    [self.thumbnailImageView.layer setShadowOffset:CGSizeMake(-1.0, -1.0)];
    [self.thumbnailImageView.layer setShadowOpacity:0.5];
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    
}


@end


