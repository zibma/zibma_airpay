#import "ZibmaAirpayPlugin.h"
#if __has_include(<zibma_airpay/zibma_airpay-Swift.h>)
#import <zibma_airpay/zibma_airpay-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zibma_airpay-Swift.h"
#endif

@implementation ZibmaAirpayPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZibmaAirpayPlugin registerWithRegistrar:registrar];
}
@end
