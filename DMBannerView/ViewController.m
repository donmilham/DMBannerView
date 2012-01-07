//
//  ViewController.m
//  DMBannerView
//
//  Created by @donmilham on 1/7/12.
//

#import "ViewController.h"

#import "DMBannerView.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

static DMBannerView * topBanner = nil;
static DMBannerView * bottomBanner = nil;

- (IBAction) topPressed:(id)sender {
	if (topBanner == nil) {
		topBanner = [[DMBannerView alloc] initWithDisplayMode:DM_BANNER_VIEW_DISPLAY_MODE_TOP];
		topBanner.heightAdjustment = 20.0f; // adjust for the status bar
		self.view.autoresizesSubviews = YES;
		[self.view addSubview:topBanner];
	}
	
	UIView * newView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
	newView.autoresizesSubviews = YES;
	newView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	newView.backgroundColor = [UIColor grayColor];
	
	UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
	label.text = @"Top Banner";
	label.textAlignment = UITextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[newView addSubview:label];
	
	[topBanner queueView:newView withDuration:2.0f];
}

- (IBAction) bottomPressed:(id)sender {
	if (bottomBanner == nil) {
		bottomBanner = [[DMBannerView alloc] initWithDisplayMode:DM_BANNER_VIEW_DISPLAY_MODE_BOTTOM];
		bottomBanner.heightAdjustment = 20.0f; // adjust for the status bar
		self.view.autoresizesSubviews = YES;
		[self.view addSubview:bottomBanner];
	}
	
	UIView * newView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
	newView.autoresizesSubviews = YES;
	newView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	newView.backgroundColor = [UIColor grayColor];
	
	UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 64)] autorelease];
	label.text = @"Bottom Banner";
	label.textAlignment = UITextAlignmentCenter;
	label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[newView addSubview:label];
	
	[bottomBanner queueView:newView withDuration:2.0f];
}

@end
