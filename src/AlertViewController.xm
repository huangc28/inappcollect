#import "AlertViewController.h"

// This alert view is made specifically for maplestory
@implementation AlertViewController

- (void)render {
			UIWindow *window = ([UIApplication sharedApplication].delegate).window;
			self.view = [
				[UIView alloc] initWithFrame:CGRectMake(
					0,
					0,
				  280,
					170
				)
			];

			self.view.center = [window convertPoint:window.center fromView:window.superview];

			self.view.userInteractionEnabled = YES;
			self.view.backgroundColor = [UIColor whiteColor];

			[window addSubview:self.view];

			[window.rootViewController addChildViewController:self];
			[self didMoveToParentViewController:window.rootViewController];

			// Render confirm button
			UIButton *cb = [self _createConfirmButton];
			[self.view addSubview:cb];
}

- (UIButton *) _createConfirmButton {
	UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[
		but
			addTarget: self
				 action: @selector(_handleConfirm:)
				forControlEvents:UIControlEventTouchUpInside
	];
	[
		but
			setFrame:CGRectMake(
					0,
					self.view.bounds.size.height - 40,
					self.view.bounds.size.width,
					50
			)
	];
	[but setTitle: @"確定" forState: UIControlStateNormal];
	[but setExclusiveTouch: YES];

	return but;
}

- (void)_handleConfirm:(UIButton *)btn {
	NSLog(@"DEBUG* handleConfirm");
	// self.view = nil;

	// Remove alert controller from parent view.
}

// TODO remove alert from parent view
- (void)dealloc {}

@end
