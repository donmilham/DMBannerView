//
//  DMBannerView.m
//  DMBannerView
//
//  Created by @donmilham on 1/7/12.
//

#import "DMBannerView.h"

#define INFO_KEY_VIEW		@"view"
#define INFO_KEY_DURATION	@"duration"

@interface DMBannerView()
{
	DMBannerViewDisplayMode displayMode;
	
	NSMutableArray * queue;
	
	NSTimer * waitTimer;
}

-(void) frameForView:(UIView*)view onScreen:(CGRect*)onScreen offScreen:(CGRect*)offScreen;

-(void) showNextBanner;
-(void) hideBanner;

@end

@implementation DMBannerView
@synthesize heightAdjustment;
@synthesize transitionTime;

- (id) initWithDisplayMode:(DMBannerViewDisplayMode)mode
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 0)];
    if (self) {
        // Initialization code
		self->displayMode = mode;
		self->transitionTime = .5f;
		
		[self setAutoresizesSubviews:YES];
		
		UIViewAutoresizing mask = UIViewAutoresizingFlexibleWidth;
		
		if (mode == DM_BANNER_VIEW_DISPLAY_MODE_TOP)
			mask |= UIViewAutoresizingFlexibleBottomMargin;
		else
			mask |= UIViewAutoresizingFlexibleTopMargin;
		
		[self setAutoresizingMask:mask];
	}
    return self;
}

- (void) queueView:(UIView*)view withDuration:(float)time
{
	if (queue == nil) {
		queue = [[NSMutableArray alloc] init];
	}
	
	NSDictionary * info = [NSDictionary dictionaryWithObjectsAndKeys:
						   view, INFO_KEY_VIEW,
						   [NSNumber numberWithFloat:time], INFO_KEY_DURATION,
						   nil];
	
	[queue addObject:info];
	
	if (waitTimer == nil) {
		[self showNextBanner];
	}
}

-(void) frameForView:(UIView*)view onScreen:(CGRect*)onScreen offScreen:(CGRect*)offScreen {
	float screenWidth, screenHeight;
	float viewHeight = view.frame.size.height;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
			screenWidth = 1024;
			screenHeight = 768;
		}
		else {
			screenWidth = 768;
			screenHeight = 1024;
		}
	}
	else {
		if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
			screenWidth = 480;
			screenHeight = 320;
		}
		else {
			screenWidth = 320;
			screenHeight = 480;
		}
	}
	screenHeight -= heightAdjustment;
	
	CGRect _offScreen = view.frame;
	_offScreen.size.width = screenWidth;
	_offScreen.origin.x = 0;
	CGRect _onScreen = _offScreen;
	
	if (displayMode == DM_BANNER_VIEW_DISPLAY_MODE_BOTTOM) {
		_offScreen.origin.y = screenHeight;
		_onScreen.origin.y = screenHeight - viewHeight;
	}
	else {
		_offScreen.origin.y = 0 - viewHeight;
		_onScreen.origin.y = 0;
	}
	
	*offScreen = _offScreen;
	*onScreen = _onScreen;
}

- (void) showNextBanner {
	// remove subviews before starting
	while ([[self subviews] count] > 0) {
		[[[self subviews] lastObject] removeFromSuperview];
	}
	
	if ([queue count] == 0) {
		[waitTimer invalidate];
		[waitTimer release], waitTimer = nil;
		return;
	}
	
	NSDictionary * info = [queue objectAtIndex:0];
	float duration = [[info objectForKey:INFO_KEY_DURATION] floatValue];
	UIView * view = [info objectForKey:INFO_KEY_VIEW];

	[waitTimer invalidate];
	[waitTimer release];
	waitTimer = [[NSTimer scheduledTimerWithTimeInterval:transitionTime + duration target:self selector:@selector(hideBanner) userInfo:nil repeats:NO] retain];

	// animation
	{	
		CGRect onScreen, offScreen;
		[self frameForView:view onScreen:&onScreen offScreen:&offScreen];
		
		CGRect viewFrame = view.frame;
		viewFrame.origin = CGPointMake(0, 0);
		viewFrame.size = onScreen.size;
		view.frame = viewFrame;
		
		self.frame = offScreen;
		[self addSubview:view];
		
		// animate onscreen
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:transitionTime];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		
		self.frame = onScreen;
		
		[UIView commitAnimations];
	}

}

-(void) hideBanner {
	NSDictionary * info = [queue objectAtIndex:0];
	UIView * view = [info objectForKey:INFO_KEY_VIEW];
	
	[waitTimer invalidate];
	[waitTimer release];
	waitTimer = [[NSTimer scheduledTimerWithTimeInterval:transitionTime target:self selector:@selector(showNextBanner) userInfo:nil repeats:NO] retain];

	// animation
	{
		CGRect onScreen, offScreen;
		[self frameForView:view onScreen:&onScreen offScreen:&offScreen];
		
		self.frame = onScreen;

		// animate offscreen
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:transitionTime];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		
		self.frame = offScreen;
		
		[UIView commitAnimations];
	}

	[queue removeObjectAtIndex:0];
}

- (void) dealloc
{
	[queue release];
	
	[waitTimer invalidate];
	[waitTimer release];
	
	[super dealloc];
}

@end
