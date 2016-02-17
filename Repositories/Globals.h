//
//  Globals.h
//  //
//  Created by Администратор on 7/17/14.
//
//

//#import "MFSideMenuContainerViewController.h"
//#import "UIViewController+MFSideMenuAdditions.h"

/* ===============  DEVICE UTILS   ============= */

#define IS_WIDESCREEN   (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON )
#define IS_IPHONE       ([[[UIDevice currentDevice] model] hasPrefix: @"iPhone"])
#define IS_IPOD         ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])
#define IS_IPHONE_5     (IS_IPHONE && IS_WIDESCREEN)
#define IS_IPHONE_6     (IS_IPHONE && IS_WIDESCREEN)

#define kPortraitWidth          320.f
#define kPortraitHeight         (IS_IPHONE_5 ? 548.f : 460.f)
#define portraitHeight         (IS_IPHONE_5 ? 568.f : 480.f)
#define kPortraitNavbarHeight   44.f

#define kLandscapeWidth         (IS_IPHONE_5 ? 568.f : 480.f)
#define kLandscapeHeight        320.f
#define kLandscpaeNavbarHeight  32.f

#define kPortraitWidth           320.f
#define kPortraitHeight          (IS_IPHONE_5 ? 548.f : 460.f)
#define kPortraitNavbarHeight    44.f

#define kLandscapeWidth          (IS_IPHONE_5 ? 568.f : 480.f)
#define kLandscapeHeight         320.f
#define kLandscpaeNavbarHeight   32.f

#define kiPadLandscapeWidth      360.f
#define kiPadLandscapeHeight     460.f

#define kStatusBarHeight                20.0f

#define widthInDevice          (IS_IPHONE_6 ? 375.f : 320.f)
#define heightInDevice         (IS_IPHONE_6 ? 667.f : 460.f)

/* ===============  DEVICE UTILS   ============= */


/* ===============  UTILS   ============= */
//#ifdef DEBUG
//#    define DLog(...) NSLog(__VA_ARGS__)
//#else
//#    define DLog(__FORMAT__, ...)   NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

//#endif

//#ifdef DEBUG
//# define DLog(...) NSLog(__VA_ARGS__)
//#else
//# define DLog(__FORMAT__, ...) TFLog((@"%s [Line %d] " _FORMAT_), _PRETTY_FUNCTION_, _LINE_, ##_VA_ARGS_)
//#endif

#ifdef DEBUG
# define DLog(...) NSLog(__VA_ARGS__)
#else
# define DLog(...) //NSLog((@"%s [Line %d] " _FORMAT_), _PRETTY_FUNCTION_, _LINE_, ##_VA_ARGS_)
#endif

#define COLOR(r, g, b)     [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

#define TRANSLATE(str)   [[SettingsManager sharedManager] translate:str]

#define STORE_DIRECTORY     [NSString stringWithFormat:@"%@/Library/Private Documents", NSHomeDirectory()]

#define FIELD_DB   @"Database"

#define ALERT(string) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];[alert show];

#define ALERT_TITLE(title, string) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:TRANSLATE(title) message:string delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];[alert show];

#define ALERT_TITLE_AND_MESSAGE(title, string) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:TRANSLATE(title) message:string delegate:nil cancelButtonTitle:@"CANCEL" otherButtonTitles:@"OK", nil];[alert show];

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })


#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define rgbColor(r, g, b) \
[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]

#define rgbColorWithAlpha(r, g, b, opacity) \
[UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:opacity]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBWithAlpha(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

//#define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:@"Sansumi" size:sizeFont]
//#define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:@"Sansumi-ExtraBold" size:sizeFont]

//#define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:@"Candara" size:sizeFont + 1]
//#define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:@"Candara-Bold" size:sizeFont + 1]
// kDefaultKernValue must @1 when font sansumi da enabled
#define kDefaultKernValue                  @0
#define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:@"Verdana" size:sizeFont]
#define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:@"Verdana-Bold" size:sizeFont]

//#define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:[[SettingsManager sharedManager] fontName] size:sizeFont + 1]
//#define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:[[SettingsManager sharedManager] boldFontName] size:sizeFont + 1]

//#ifndef NEW_FONT_LOGIK
//
//    #define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:globalRegularFontName size:sizeFont]
//    #define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:globalBoldFontName size:sizeFont]
////    UIFont *  FONT_SANSUMI(sizeFont){
////        return [UIFont fontWithName:globalRegularFontName size:sizeFont];
////    }
////
////    UIFont *  FONT_SANSUMI_BOLD(sizeFont){
////        return [UIFont fontWithName:globalBoldFontName size:sizeFont];
////    }
//
//
//#else
//    #define kDefaultKernValue           @1
//    #define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:@"Sansumi" size:sizeFont]
//    #define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:@"Sansumi-ExtraBold" size:sizeFont]
//
//#endif





//#define FONT_SANSUMI(sizeFont)              [UIFont fontWithName:@"PetitaLight" size:sizeFont]
//#define FONT_SANSUMI_BOLD(sizeFont)         [UIFont fontWithName:@"PetitaBold" size:sizeFont

#define PRELOADER_TAG                       3434343

#define REGEX_PHONE                         @"\\+*\\-*(\\([0-9]+\\))*\\-*\\.* *.*([0-9]*\\-*)*[0-9]+"

#define PERMISSION_DENIED_MSG  TRANSLATE(@"You don't have permission for this.")

#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
/* ===============  UTILS   ============= */



/* ===============  HTTP UTILS   ============= */

#define BASE_URL                                @"https://api.github.com/"    //amazon new life


BOOL        isLeftSideScrollingEnable;
BOOL        isRightSideScrollingEnable;
//MFSideMenuContainerViewController *containerMenuController;

#define LIMIT                                   @10

#define WINDOW_VIEW_TAG 33355

#define APPLICATION_API_KEY_VALUE               @"e6d4faab68fa6404e440e1055014ca12"
#define HTTP_REQUEST                            @"httpRequest"
#define FIELD_ERRORS                            @"errors"
#define FIELD_ERROR                             @"error"
#define API_DOMAIN_ERROR                        @"API_DOMAIN_ERROR"
#define FIELD_RESPONSE                          @"response"
#define FIELD_RESPONSE_FOR_ADVERTISING_IMAGE    @"url"
#define HOST_UNREACHABLE                        @"HOST_UNREACHABLE"
#define HOST_UNREACHABLE_CODE                   -100
#define EMAIL_NOT_SET_ERROR_CODE                999

#define SUCCEED_RESPONSE(res, er)                 !er && [res[@"statusCode"] integerValue]==2
#define SUCCEED_RESPONSE_AND_DATA_EXIST(res, er)  !er && [res[@"statusCode"] integerValue]==2 && res[@"data"] && ![res[@"data"] isEqual:[NSNull null]]

#define STATUS_OK    1
#define STATUS_WRONG 0


#define ERROR_OBJECT_EXIST 51

/* ===============  HTTP UTILS   ============= */




/* ===============  NSNOTIFICATION NAME LIST   ============= */
#define kDeviceTokenRetreivedNotification       @"kDeviceTokenRetreivedNotification"
static NSString *const kStatusBarTappedNotification = @"statusBarTappedNotification";
static NSString *const kStatusBarDoubleTappedNotification = @"kStatusBarDoubleTappedNotification";
static NSString *const kClinicalNewNoteAdded = @"kClinicalNewNoteAdded";
static NSString *const kClinicalNoteUpdated = @"kClinicalNoteUpdated";
static NSString *const kClinicalNoteCancelled = @"kClinicalNoteCancelled";
static NSString *const kPatientProfileDetailsDidChanged = @"kPatientProfileDetailsDidChanged";
static NSString *const kPatientDocumentStatusDidChanged = @"kPatientDocumentStatusDidChanged";
static NSString *const kAppointmentStatusColorChangedNotification = @"kAppointmentStatusColorChanged";
static NSString *const kMemberInfoChangedNotification = @"kMemberInfoChangedNotification";
static NSString *const kMemberWorkingHoursChangedNotification = @"kMemberWorkingHoursChangedNotification";
static NSString *const kCustomIPAdressChangedNotification = @"kCustomIPAdressChangedNotification";
static NSString *const kCustomFontSelectNotification = @"kCustomFontSelectNotification";

static NSString *const kLabOrderCreatedNotification = @"kLabOrderCreatedNotification";
static NSString *const kPatientNoteChangedNotification = @"kPatientNoteChangedNotification";
static NSString *const kPatientInsuranceNoteChangedNotification = @"kPatientInsuranceNoteChangedNotification";
static NSString *const kToothItemConditionsChanged = @"kToothItemConditionsChanged";


#define APPOINTMENT_FINISH_ALERT_LOCAL_NOTIFICATION  @"APPOINTMENT_FINISH_ALERT_LOCAL_NOTIFICATION"
#define APPOINTMENT_REMINDER_COMPLETE_LOCAL_NOTIFICATION  @"APPOINTMENT_REMINDER_COMPLETE_LOCAL_NOTIFICATION"

#define SELECTED_COLOR          @"SELECTED_COLOR"
#define RIGHT_SEARCH_VIEW_WIDTH 420.f

// userDefaults keys


/* ===============  BASE COLORS   ============= */
#define SEARCH_BAR_COLOR rgbColor(248, 248, 248)
#define BORDER_GRAY_COLOR rgbColor(206, 206, 206)
#define TEXT_GRAY_COLOR UIColorFromRGB(0x7d7d7d)
#define LIME_BUTTON_BG_COLOR rgbColor(190, 200, 68)
#define DELETE_BUTTON_BG_COLOR rgbColor(255, 2, 4)
#define BROWN_BUTTON_BG_COLOR rgbColor(184, 172, 151)
#define NAVIGATION_BAR_BTN_TEXT_COLOR  UIColorFromRGB(0xBEC945)
#define PICKER_CHOOSE_ITEM_TEXT_COLOR UIColorFromRGB(0xb9b8b8)


/* ================ DATE FORMATS ================ */
#define SHORT_DATE_FORMAT @"dd/MM/yyyy"
#define SHORT_DOTTED_DATE_FORMAT @"dd.MM.yyyy"
#define HOURS_MINUTES_DATE_FORMAT @"HH:mm"
#define HOURS_MINUTES_DATE_24_FORMAT @"hh:mm"
#define HOURS_SHORT_MINUTES_DATE_FORMAT @"h:mm a"
#define DATE_AND_TIME_FORMAT @"dd/MM/yyyy,hh:mm a"
#define HOURS_MINUTES_SECONDS_DATE_FORMAT @"HH:mm:ss"
#define HOURS_MINUTES_TIME_FORMAT @"hh:mm a"
#define SHORT_DATE_AND_TIME_FORMAT @"dd/MM/yy,hh:mm a"

#define STRING_OR_NOT_AVIABLE_STRING(string)  (string.length > 0) ? string : TRANSLATE(@"N/A")
#define NotEmptyTitleOrPlaceholder(title, placeholder)  (title.length > 0) ? title : placeholder

#define kMonitorToothWidth       420.0
#define kSettingsRightViewWidth          628
#define kSettingsLeftViewWidth           395


#define TOOTH_IMAGE_HEIGHT 125.f
#define TOOTH_IMAGE_WIDTH 60.f

#define IS_NOT_EDIT_MODE_MSG            @"This action is not available in View mode"
#define DEFAULT_NONE_EMAIL              @"none@none.com"

typedef void (^CompletedEditBlock)(id object);

///api/member/choose.json
#define METHOD_REPOSITORIES_OBJECTIVE_C         @"/legacy/repos/search/Go?language=Objective-C&sort=stars"
#define METHOD_REPOSITORIES_SWIFT               @"/legacy/repos/search/Go?language=swift&sort=stars"
#define METHOD_SAVE_NEW_USER                    @"/signUp"
#define METHOD_PASSWORD_RECOVERY                @"/passwordRecovery"
#define METHOD_GET_LIST_ALL_TRANDS_ANNOUNCEMETS @"/getAds"
#define METHOD_GET_LISTOFANNOUNCEMENTS          @"/getTrendAds"
#define METHOD_GET_ANNOUNCEMENTS                @"/getMyAds"
#define METHOD_ADD_ANNOUNCEMENT                 @"/addAd"
#define METHOD_CHANGE_PROFESSOR_PROFILE         @"/changeProfile"
#define METHOD_UPLOAD_PHOTO                     @"/upload"
#define METHOD_SEND_MESSAGE                     @"/sendMessage"
#define METHOD_GET_MESSAGE                      @"/getMessages"
#define METHOD_ADD_GROUP_CHAT                   @"/addGroupChat"
#define METHOD_GET_GROUP_CHAT                   @"/getGroupChatByUser"
#define METHOD_GET_GROUP_CHAT_NO_MEMBERS        @"/getGroupChat"
#define METHOD_GET_GROUP                        @"/getGroupByUser"
#define METHOD_GET_ALL_GROUP                    @"/getAllGroups"
#define METHOD_ADD_GROUP_MEMBER                 @"/addGroupMember"
#define METHOD_REMOVE_GROUP_MEMBER              @"/removeGroupMember"
#define METHOD_ADD_GROUP                        @"/addGroup"
#define METHOD_FIND_USERS                       @"/findUsers"
#define METHOD_ADD_GROUP_CHAT_MEMBER            @"/addGroupChatMember"
#define METHOD_ADD_NEWS_TO_GROUP                @"/addNewsToGroup"
#define METHOD_GROUP_BY_ID                      @"/getGroup"
#define METHOD_SEND_GROUP_CHAT_MESSAGE          @"/addMessage"
#define METHOD_GET_GROUP_CHAT_MESSAGE           @"/getGroupChatMessages"
#define METHOD_UPDATE_ANNOUNCEMENT              @"/updateAd"




