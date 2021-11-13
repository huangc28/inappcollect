#import <SpringBoard/SpringBoard.h>
#import <StoreKit/StoreKit.h>
#import <FrontBoard/FBProcess.h>

// #import <arknight_headers/SplashScreen.h> 
// #import <arknight_headers/SplashScreenController.h> 
#import "StoreKitReceiptRequestDelegate.h"
#import "StoreKitManager.h"

%group Hooks
%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
    %orig;

	NSLog(@"DEBUG* hello world bb");

	UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"TestTitle" message:@"TestMessage" preferredStyle:UIAlertControllerStyleAlert];

 	UIAlertAction *action = [
		UIAlertAction 
			actionWithTitle:@"OK" 
			style:UIAlertActionStyleDefault 
			handler:^(UIAlertAction *action){
				NSLog(@"DEBUG* fuck you bb"); 

 				NSLog(@"DEBUG* 2 i love you %@", action);
			}
	];

    [ alertController addAction: action];
  
    [self.keyWindow.rootViewController presentViewController:alertController animated:YES completion:NULL];
}

%end

// _PaymentSheetState
// _purchaseController
// SKProductsRequest
// SKPaymentQueue

%hook BLYLogger

+ (void)initialize{
	NSLog(@"DEBUG* initialize BLYLogger");

	UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"TestTitle" message:@"TestMessage" preferredStyle:UIAlertControllerStyleAlert];

	[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];

	%orig;
}
%end

// Try#1 SKProductsRequest
//   A set of method the delegate implements so it receives the product information your app requests.
//  Failed, might be SKProductsRequestDelegate is a protocol, not a class.
%hook SKProductsRequest
-(id)initWithProductIdentifiers:(id)arg1{
	NSLog(@"DEBUG* initWithProductIdentifiers");

	UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"TestTitle" message:@"TestMessage" preferredStyle:UIAlertControllerStyleAlert];
	[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];

	return %orig;
}
%end // SKProductsRequest 


%hook StoreKitManager
- (id)init {
	NSLog(@"DEBUG* StoreKitManager init");

	UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"TestTitle" message:@"TestMessage" preferredStyle:UIAlertControllerStyleAlert];
	[[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertController animated:YES completion:nil];

	return %orig;
}
- (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {
	NSLog(@"DEBUG* 3 trigger product request");

	UIAlertView *alertView = [
		[UIAlertView alloc] initWithTitle:@"Save" message:@"Enter File Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];

   	alertView.alertViewStyle = UIAlertViewStylePlainTextInput;

    [alertView show];

	%orig;
}

- (void)requestProductData:(id)arg1 {
	NSLog(@"DEBUG* 4 trigger requestProductData");

	%orig;
}
%end

// Detect application launch.
// Reference github: https://github.com/Razzile/RippleBoard/blob/master/Tweak.xm
// bundleIdentifier: 
//   明日方舟: tw.txwy.ios.arknights 
%hook SBMainWorkspace

-(void)applicationProcessDidLaunch:(FBProcess *)applicationProcess {
	// applicationProcessDidLaunch, tw.txwy.ios.arknights
    NSLog(@"DEBUG* applicationProcessDidLaunch %@", applicationProcess.bundleIdentifier);
    %orig;
}

%end // SBMainWorkspace

%end // Hooks


// %ctor gets called when executable is loaded into the momory
%ctor {
	NSLog(@"DEBUG* ctor!");

	%init(Hooks);
}