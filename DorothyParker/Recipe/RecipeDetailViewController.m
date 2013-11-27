//
//  RecipeDetailViewController.m
//  DorothyParker
//
//  Created by Janice Garingo on 10/15/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import "RecipeDetailViewController.h"
#import "RecipeWebViewController.h"

@interface RecipeDetailViewController ()

@property (nonatomic) NSString *urlToLoad;

@end

@implementation RecipeDetailViewController

- (void)viewDidLoad
{
    [self setElements];
    [self styleElements];
    
    self.webView.delegate = self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setElements];
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
    self.view.backgroundColor = kUIColorLtGrey;
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kUIColorMedGrey;
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      kNovellaFont, NSFontAttributeName,
                                                                      [UIColor whiteColor],NSForegroundColorAttributeName,
                                                                      nil]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    NSUInteger isValidLink = 0;
    
    if([requestString isEqualToString:kDorothyLink] || [requestString isEqualToString:kIndieLink] || [requestString isEqualToString:kBarnesNobleLink] || [requestString isEqualToString:kPowellsLink])
    {
        isValidLink = 1;
    }
    
    if((navigationType == UIWebViewNavigationTypeLinkClicked) && isValidLink)
    {
        self.urlToLoad = [[request URL] absoluteString];
        [self performSegueWithIdentifier:@"recipeWebViewSegue" sender:self];
    }

    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"recipeWebViewSegue"])
    {
        RecipeWebViewController *recipeWebViewController = [segue destinationViewController];
        recipeWebViewController.urlToLoad = self.urlToLoad;
    }
}

@end


