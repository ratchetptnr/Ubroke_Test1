#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.ubroke.app";

/// The "AccentColor" asset catalog color resource.
static NSString * const ACColorNameAccentColor AC_SWIFT_PRIVATE = @"AccentColor";

/// The "onboarding-1" asset catalog image resource.
static NSString * const ACImageNameOnboarding1 AC_SWIFT_PRIVATE = @"onboarding-1";

/// The "onboarding-2" asset catalog image resource.
static NSString * const ACImageNameOnboarding2 AC_SWIFT_PRIVATE = @"onboarding-2";

/// The "onboarding-3" asset catalog image resource.
static NSString * const ACImageNameOnboarding3 AC_SWIFT_PRIVATE = @"onboarding-3";

/// The "onboarding-4" asset catalog image resource.
static NSString * const ACImageNameOnboarding4 AC_SWIFT_PRIVATE = @"onboarding-4";

/// The "onboarding-5" asset catalog image resource.
static NSString * const ACImageNameOnboarding5 AC_SWIFT_PRIVATE = @"onboarding-5";

/// The "onboarding-6" asset catalog image resource.
static NSString * const ACImageNameOnboarding6 AC_SWIFT_PRIVATE = @"onboarding-6";

#undef AC_SWIFT_PRIVATE
