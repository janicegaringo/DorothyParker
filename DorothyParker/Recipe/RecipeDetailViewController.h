//
//  RecipeDetailViewController.h
//  DorothyParker
//
//  Created by Janice Garingo on 10/15/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeDetailViewController : UIViewController

@property (nonatomic, strong) NSString *ingredients;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *thumbnailRetina; 
@property (weak, nonatomic) IBOutlet UIWebView *ingredientsWebView;
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end
