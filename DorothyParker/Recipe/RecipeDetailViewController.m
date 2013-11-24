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
    
  

    
    //
//    self.glasswareLabel.text = [NSString stringWithFormat:@"Glassware: %@", self.glassware];
    
//    NSString *descriptionHtmlString = [NSString stringWithFormat:@"<font color='white'>%@<br><br>%@<br>%@</font>", self.recipedescription, self.recipetitle, self.ingredients];

    
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
    
//    [self.glasswareLabel setFont:[UIFont fontWithName:@"Palatino" size:16.0]];
//    self.glasswareLabel.numberOfLines = 2;
//    
//    [self.thumbnailImageView.layer setShadowOffset:CGSizeMake(-1.0, -1.0)];
//    [self.thumbnailImageView.layer setShadowOpacity:0.5];
    
      [self.webView setBackgroundColor:kUIColorMedGrey];
      [self.webView setOpaque:NO];
    
}


@end


