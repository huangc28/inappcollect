// 'LineageMLiveCollect' uses the same hook logic as 'Lineage2m' to collect product info.
%group LineageMLiveCollect

%end

extern "C" void InitLineageMLiveCollect() {
	%init(LineageMLiveCollect);
}
