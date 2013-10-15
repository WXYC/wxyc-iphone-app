//
//  Created by Jake Bromberg.
//  Copyright WXYC 2009-10. All rights reserved.
//

#import "AboutViewController.h"
#import	"WebViewController.h"
#import "UIApplication+PresentViewController.h"

@interface AboutViewController ()

@property UIWebView *view;

@end

@implementation AboutViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	NSString* aboutTemplatePath = [[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"];
	NSURL* url = [NSURL fileURLWithPath:aboutTemplatePath];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	[self.view loadRequest:requestObj];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType != UIWebViewNavigationTypeLinkClicked)
        return YES;
    
    WebViewController *webViewController = [[WebViewController alloc] initWithRequest:request];
    webViewController.webView.scalesPageToFit = YES;
    [UIApplication presentViewController:webViewController animated:YES completion:nil];
    
    return NO;
}

@end