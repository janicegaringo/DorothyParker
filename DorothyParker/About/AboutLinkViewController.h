//
//  AboutLinkViewController.h
//  DorothyParker
//
//  Created by Janice Garingo on 11/26/13.
//  Copyright (c) 2013 Janice Garingo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutLinkViewController : UIViewController

@property (nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *urlToLoad;

@end
