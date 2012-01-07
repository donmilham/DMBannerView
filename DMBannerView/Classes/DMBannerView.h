//
//  DMBannerView.h
//  DMBannerView
//
//  Created by @donmilham on 1/7/12.
//

#import <UIKit/UIKit.h>

enum {
	DM_BANNER_VIEW_DISPLAY_MODE_TOP,
	DM_BANNER_VIEW_DISPLAY_MODE_BOTTOM,
};
typedef int DMBannerViewDisplayMode;

@interface DMBannerView : UIView

// heightAdjustment accounts smaller sized viewable areas.
// for example set to 20 if the app has a status bar
@property (nonatomic, assign) float heightAdjustment;

// transitionTime is the time the view takes to transition on or off screen
// defaults to .5 seconds
@property (nonatomic, assign) float transitionTime;

- (id) initWithDisplayMode:(DMBannerViewDisplayMode)mode;

- (void) queueView:(UIView*)view withDuration:(float)time;

@end
