//
//  WWN-Bridging-Header.h
//  Bridging header for Swift-Objective-C interop
//

#ifndef WWN_Bridging_Header_h
#define WWN_Bridging_Header_h

// Import UniFFI C header for Swift access when available in this build path.
#if __has_include("wwnFFI.h")
#import "wwnFFI.h"
#endif
#import "ui/Machines/WWNMachineProfileStore.h"
#import "ui/Settings/WWNWaypipeRunner.h"
#import "ui/Settings/WWNPreferencesManager.h"
#import "ui/Settings/WWNPreferences.h"

#endif /* WWN_Bridging_Header_h */
