#import <SpringBoard/SpringBoard.h>
#import <StoreKit/StoreKit.h>
// #import <arknight_headers/SplashScreen.h> 
// #import <arknight_headers/SplashScreenController.h> 
#import <arknight_headers/StoreKitManager.h> 

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

// %hook SplashScreenController
// %new 
// 
// -(void)redirectLogs { 
//  	NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
//  	NSString *documentsDirectory = [allPaths objectAtIndex:0]; 
//  	NSString *pathForLog = [documentsDirectory stringByAppendingPathComponent:@"arknights.txt"];
//  
//   	freopen(
// 	  [pathForLog cStringUsingEncoding:NSASCIIStringEncoding],
// 	  "a+",
// 	  stderr
// 	);
// 
// 	UIAlertView *alert = [
// 		[UIAlertView alloc]
// 			initWithTitle:@"New path for logs:" 
// 			message:pathForLog delegate:self 	
// 			cancelButtonTitle:@"Ok"	
// 			otherButtonTitles:nil
// 	];
// 
// 	[alert show];
// }
// 
// - (void)create:(id)arg1{
// 	%log;
// 
// 	%orig;
// 
// 	[self performSelector:@selector(redirectLogs)];
// 
// 	NSLog(@"DEBUG* SplashScreenController create");
// }
// - (id)init{
// 	%log;
// 	
// 	[self performSelector:@selector(redirectLogs)];
// 
// 	NSLog(@"DEBUG* SplashScreenController init");
// 
// 	return %orig;
// }
// %end

// %hook SplashScreen
// - (id)initWithFrame:(struct CGRect)arg1{
// 	
// 	NSLog(@"DEBUG* SplashScreen initWithFrame");
// 
// 	return %orig;
// }
// %end

// _PaymentSheetState
// _purchaseController
// SKProductsRequest
// SKPaymentQueue


// Try#1 SKProductsRequestDelegate
//   A set of method the delegate implements so it receives the product information your app requests.
//  Failed, might be SKProductsRequestDelegate is a protocol, not a class.
// %hook StoreKitManager
// -(void)redirectLogs { 
//  	NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
//  	NSString *documentsDirectory = [allPaths objectAtIndex:0]; 
//  	NSString *pathForLog = [documentsDirectory stringByAppendingPathComponent:@"arknights.txt"];
//  
//   	freopen(
// 	  [pathForLog cStringUsingEncoding:NSASCIIStringEncoding],
// 	  "a+",
// 	  stderr
// 	);
// 
// 	UIAlertView *alert = [
// 		[UIAlertView alloc]
// 			initWithTitle:@"New path for logs:" 
// 			message:pathForLog delegate:self 	
// 			cancelButtonTitle:@"Ok"	
// 			otherButtonTitles:nil
// 	];
// 
// 	[alert show];
// }
// 
// - (void)productsRequest:(id)arg1 didReceiveResponse:(id)arg2 {

// 	[self performSelector:@selector(redirectLogs)];
// 
// 	NSLog(@"DEBUG* 3 trigger product request");
// 
// 	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save"
//                                                         message:@"Enter File Name"
//                                                        delegate:self
//                                               cancelButtonTitle:@"Cancel"
//                                               otherButtonTitles:@"OK", nil];
// 
//     alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
// 
//     [alertView show];
// 
// 
// 	%orig;
// }

// - (void)requestProductData:(id)arg1 {
// 	%log;
// 
// 	[self performSelector:@selector(redirectLogs)];
// 
// 	NSLog(@"DEBUG* 4 trigger requestProductData");
// 
// 	%orig;
// }
// %end

// Try#2 SKPaymentQueue
// k%hook SKPaymentQueue  
// k- (void)addPayment:(id)arg1{
// k	NSLog(@"DEBUG* trigger add payment");
// k
// k	%orig;
// k}
// k%end
// k
// k// Try#3 SKProductsRequest
// k%hook SKProductsRequest  
// k- (void)initWithProductIdentifiers:(id)arg1{
// k	NSLog(@"DEBUG* trigger add payment");
// k
// k	%orig;
// k}
// k%end