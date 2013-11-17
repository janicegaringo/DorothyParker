//
//  RecipeDetailViewController.h
//  DorothyParker
//
//  Created by Janice Garingo on 10/15/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController

@property (nonatomic) NSString *ingredients;
@property (nonatomic) NSString *recipedescription;
@property (nonatomic) NSString *thumbnail;
@property (nonatomic) NSString *thumbnailRetina;
@property (nonatomic) NSString *recipetitle;
@property (nonatomic) NSString *glassware; 

@property (nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic) IBOutlet UILabel *glasswareLabel;
@property (nonatomic) IBOutlet UIWebView *webView;



@end
