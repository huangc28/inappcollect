%group LineageRCollect

// 'LineageR' uses the same hook logic as 'Lineage2m' to collect product info.
%hook PaymentUtil

+ (void)setItemInfoData:(id)arg1 {
	NSLog(@"DEBUG* setItemInfoData %@", arg1);

	%orig;
}

+ (_Bool)needsUpdateItemInfoWithProductIdentifier:(id)arg1 {
	NSLog(@"DEBUG* needsUpdateItemInfoWithProductIdentifier %@", arg1);

	return %orig;
}

+ (id)itemInfoWithProductIdentifier:(id)arg1 {
	NSLog(@"DEBUG* itemInfoWithProductIdentifier %@", arg1);

	id r = %orig();

	return r;
}
+ (void)setItemInfo:(id)arg1 {
	NSLog(@"DEBUG* setItemInfo %@", arg1);

	%orig;
}

%end

%end // End of LineageRCollect

extern "C" void InitLineageRCollect() {
	%init(LineageRCollect);
}
