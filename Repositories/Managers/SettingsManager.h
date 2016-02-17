//
//  SettingsManager.h
//
//  Created by Sancho on 08/29/12.
//  Copyright (c) 2013 FinnetLimited.com. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Enums.h"

@class OAuthToken, SessionData, StaffData;
@interface SettingsManager : NSObject

@property (nonatomic, strong) NSString *currentLanguage;
@property (nonatomic, copy) NSString *deviceToken;

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *refreshToken;

@property (nonatomic, strong) OAuthToken *authToken;
@property (nonatomic, strong) SessionData *sessionData;

@property (nonatomic, strong) NSDictionary *countriesByCode;
@property (nonatomic, strong) NSArray *sortedCountries;
@property (nonatomic, strong, readonly) NSString *countryPhoneCode;
@property (nonatomic, strong) StaffData *currentMember;

@property (nonatomic, assign) NSInteger toothPerioMovementType;

@property (nonatomic, strong) NSArray *companyMembers;

@property (nonatomic, strong) NSArray *favouriteTreatmentCodes;
@property (nonatomic, strong) NSArray *favouriteDiagnosisCodes;
@property (nonatomic, strong) NSDictionary *favouriteTreatmentCodeImages;
@property (nonatomic, strong) NSDictionary *favouriteDiagnosisCodeImages;
//@property (nonatomic, strong) NSMutableDictionary *toothTypesDic;

@property (nonatomic, strong) NSString *permissions;

//todo need to remove after testing tooth types
@property (nonatomic, strong) NSString *currentPatientKey;
@property (nonatomic, strong) NSMutableDictionary *toothSuperNumericsDic;

@property (nonatomic, assign) BOOL showAppointmentNotifications;
@property (nonatomic, assign) BOOL showFavoriteQuickMode;
@property (nonatomic, strong) NSString *treatmentViewDefaultStatus;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) NSString *boldFontName;
//- (UIImage *)conditionImage:(UIImage *)image withType:(ToothConditionEntityType)type;

+ (id)sharedManager;

/*- (NSString *)countryPhoneCode;*/

- (NSString *)currencySymbol;
- (NSString *)translate:(NSString *)str;

//- (UIColor *)colorForAppoinmentAction:(AppoinmentActionMenuType)actionMenuType;

- (UIColor *)colorForAppoinmentTypeID:(NSString *)appoinmentTypeID;
- (void)setColorForAppoinmentTypeID:(NSString *)appoinmentTypeID with:(UIColor *)color;

- (UIColor *)colorForAppoinmentStatus:(NSString *)appoinmentStatusCode;
- (void)setColorForAppoinmentStatus:(NSString *)appoinmentStatusCode with:(UIColor *)color;

- (NSMutableDictionary *)toothTypesDicWithPatientKey:(NSString *)patientKey;

- (void)saveToothTypesDic:(NSDictionary *)dic withPatientKey:(NSString *)patientKey;

- (NSMutableDictionary *)toothSuperNumericsDicWithPatientKey:(NSString *)patientKey;

- (void)saveToothSuperNumericsDic:(NSDictionary *)dic withPatientKey:(NSString *)patientKey;

- (UIImage *)favouriteTreatmentImage:(NSString *)treatmentCode;

- (void)setFavouriteImageName:(NSString *)imageName forTreatement:(NSString *)treatmentCode;


@end