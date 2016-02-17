//
//  SettingsManager.m
//  SmartHome-iphone
//
//  Created by Sancho on 08/29/13.
//  Copyright (c) 2013 FinnetLimited.com. All rights reserved.
//

//#import "Address.h"
//#import "Country.h"
//#import "BaseToothConditionState.h"

#define CURRENT_LANGUAGE     @"currentLanguage"

#define ENGLISH_LANGUAGE     @"en"
#define RUSSIAN_LANGUAGE     @"ru"

#define TOOTH_PERIO_MOVEMENT_TYPE [@"TOOTH_PERIO_MOVEMENT_TYPE" MD5]

@interface SettingsManager () {

    NSMutableDictionary *_languageDict;

//    NSDictionary *countriesByCode;
}

@end

@implementation SettingsManager
@synthesize refreshToken = _refreshToken, accessToken = _accessToken;
@synthesize countryPhoneCode = _countryPhoneCode;
@synthesize toothSuperNumericsDic = _toothSuperNumericsDic;

//@synthesize currentLang = _currentLang;

static SettingsManager *_instance = nil;

- (id)init {
    self = [super init];
    if (self) {
        _languageDict = [[NSMutableDictionary alloc] init];
//        [self setupColors];
        // en, fr,es,de
//        NSString* language = [[NSLocale preferredLanguages] objectAtIndex:0];
//        DLog(@"%@",language);
        NSString *language = CURRENT_LANGUAGE;
        NSError *error = nil;
        if (language) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"translate" ofType:nil];

            NSString *temp = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                DLog(@"%@", [error localizedDescription]);
            }

            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[temp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                DLog(@"JSON SERIALIZATION error: %@", [error localizedDescription]);
            }
            _languageDict = [dict objectForKey:language];
        }


//        NSString *countriesStr = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:nil] encoding:NSUTF8StringEncoding error:&error];
//        if (error) {
//            DLog(@"%@", [error localizedDescription]);
//        }
//
//        _countriesByCode = [NSJSONSerialization JSONObjectWithData:[countriesStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
//        if (error) {
//            DLog(@"JSON SERIALIZATION error: %@", [error localizedDescription]);
//        } else {
//            _countriesByCode = _countriesByCode[@"countries"];
//        }
//
//        NSArray *countries = [_countriesByCode allValues];
//        _sortedCountries = [countries sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//            return [obj1[@"name"] compare:obj2[@"name"]];
//        }];

//        if ([self appLanguage]) {
//            [self setLanguage:[self appLanguage]];
//        } else{
//            [self setLanguage:RUSSIAN_LANGUAGE];
//        }
        self.fontName = @"Candara";
        self.boldFontName = @"Candara-Bold";
        if (self.treatmentViewDefaultStatus.length == 0) {
//            self.treatmentViewDefaultStatus = PLANNED_TRANSACTION_STATUS_CODE;
        }
//        [self setDefaultAppointmentStatusColors];
    }

    return self;
}

/*- (void)setToothConditionsDic {
    if (!self.toothTypesDic) {
        NSMutableDictionary *toothTypesDic = [NSMutableDictionary new];
        for (int i = 1, position = 18; i <= 16; i++) {

            toothTypesDic[[NSString stringWithFormat:@"%d", position]] = @YES;
            if (position <= 18) {
                position--;
            } else {
                position++;
            }

            if (position == 10) {
                position = 21;
            }
        }

        for (int i = 1, position = 48; i <= 16; i++) {

            toothTypesDic[[NSString stringWithFormat:@"%d", position]] = @YES;
            if (position >= 41) {
                position--;
            } else {
                position++;
            }

            if (position == 40) {
                position = 31;
            }
        }
        self.toothTypesDic = toothTypesDic;
    }
}*/

- (void)insertValueIfNotExist:(id)value forKey:(id)key {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:key] || [[[NSUserDefaults standardUserDefaults] objectForKey:key] isEqual:[NSNull null]]) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//- (void)setupColors {
//    UIColor *noResponseAppoinmentColor = nil;
//}

//- (UIImage *)conditionImage:(UIImage *)image withType:(ToothConditionEntityType)type {
//    UIColor *color = [BaseToothConditionState colorByType:type];
//    return color ? [image changeImageWithColor:color] : image;
//}


+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SettingsManager alloc] init];
    });

    return _instance;
}

- (id)objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveObject:(id)object forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSString *)permissions {
    return [NSUserDefaults objectForKey:@"PERMISSIONS"];
}

- (void)setPermissions:(NSString *)permissions {
    [NSUserDefaults setObject:permissions ForKey:@"PERMISSIONS"];
}


- (NSString *)deviceToken {
//    return @"d7766191b6bb0fb001442c7b6bd9910cda3a0d435ce07d94b2196d613ddbf90e";
#if TARGET_IPHONE_SIMULATOR
    return [@"asfdasdadkjfhiuashuf377ed0a8dfd133923ee8b2be4c0dfb39e333fad390bd1" stringByAppendingString:[UIDevice currentDevice].uniqueDeviceIdentifier];
 return @"d7766191b6bb0fb001442c7b6bd9910cda3a0d435ce07d94b2196d613ddbf90e";
#else
    NSString *deviceToken = [self objectForKey:@"deviceToken"];
    return deviceToken;
#endif // TARGET_IPHONE_SIMULATOR
}

- (void)setDeviceToken:(NSString *)deviceToken {
    [self saveObject:deviceToken forKey:@"deviceToken"];
}

- (void)setSessionData:(SessionData *)sessionData {
    _sessionData = sessionData;
    _countryPhoneCode = nil;
}


//- (NSString *)countryPhoneCode {
//    if (!_countryPhoneCode) {
//        if (self.sessionData.clinic.address.country.name.length > 0) {
//            [self.sortedCountries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                if ([[obj[@"name"] lowercaseString] rangeOfString:[self.sessionData.clinic.address.country.name lowercaseString]].length != 0) {
//                    _countryPhoneCode = obj[@"phoneCode"];
//                    *stop = YES;
//                }
//            }];
//        }
//    }
//    return _countryPhoneCode;
//}

//- (NSString *)fontName {
//    return _fo;
//}

#pragma mark - Language methods

- (void)setCurrentLanguage:(NSString *)currentLanguage {
    if (currentLanguage) {
        _languageDict = [[NSMutableDictionary alloc] init];
        id settings = [NSUserDefaults standardUserDefaults];
        [settings setObject:currentLanguage forKey:CURRENT_LANGUAGE];
        [settings synchronize];

        if ([currentLanguage isEqualToString:ENGLISH_LANGUAGE]) {
            _languageDict = nil;
        } else {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"translate" ofType:nil];
            NSError *error = nil;
            NSString *temp = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                DLog(@"%@", [error localizedDescription]);
            }

            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[temp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                DLog(@"JSON SERIALIZATION error: %@", [error localizedDescription]);
            } else {
                [_languageDict setDictionary:dict];
            }

        }
    }
}

- (NSString *)currencySymbol {
    return @"$";
}


- (NSString *)currentLanguage {
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_LANGUAGE];
    return language ? language : ENGLISH_LANGUAGE;
}


- (NSString *)translate:(NSString *)str {
    if (!str) {
        return nil;
    }

    if ([_languageDict objectForKey:str]) {
        return _languageDict[str];
    }
    return str;
}

- (void)setRefreshToken:(NSString *)refreshToken {
    _refreshToken = refreshToken;
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"refreshToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)refreshToken {
    if (!_refreshToken) {
        _refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"refreshToken"];
    }
    return _refreshToken;
}

- (NSString *)accessToken {
    if (!_accessToken) {
        _accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    }
    return _accessToken;
}

- (void)setAccessToken:(NSString *)accessToken {
    _accessToken = accessToken;
    if (accessToken) {
        [[NSUserDefaults standardUserDefaults] setObject:_accessToken forKey:@"accessToken"];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)showFavoriteQuickMode {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"showFavoriteQuickMode"] boolValue];
}

- (void)setShowFavoriteQuickMode:(BOOL)showFavoriteQuickMode {
    [[NSUserDefaults standardUserDefaults] setObject:@(showFavoriteQuickMode) forKey:@"showFavoriteQuickMode"];
}

- (void)setTreatmentViewDefaultStatus:(NSString *)treatmentViewDefaultStatus {
    [NSUserDefaults setObject:treatmentViewDefaultStatus ForKey:@"treatmentViewDefaultStatus"];
}

- (NSString *)treatmentViewDefaultStatus {
    return [NSUserDefaults objectForKey:@"treatmentViewDefaultStatus"];
}


- (NSArray *)favouriteTreatmentCodes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavoriteTreatmentCodes.plist"];
    NSArray *items = [[NSArray alloc] initWithContentsOfFile:stringsPlistPath];
    return items ? items : @[];
}

- (void)setFavouriteTreatmentCodes:(NSArray *)favouriteTreatmentCodes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavoriteTreatmentCodes.plist"];
    [favouriteTreatmentCodes writeToFile:stringsPlistPath atomically:YES];
}


- (NSDictionary *)favouriteTreatmentCodeImages {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavouriteTreatmentCodeImages.plist"];
    NSDictionary *items = [[NSDictionary alloc] initWithContentsOfFile:stringsPlistPath];
    return items ? items : @{};
}

- (void)setFavouriteTreatmentCodeImages:(NSDictionary *)favouriteDiagnosisCodes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavouriteTreatmentCodeImages.plist"];
    [favouriteDiagnosisCodes writeToFile:stringsPlistPath atomically:YES];
}

- (NSDictionary *)favouriteDiagnosisCodeImages {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavouriteDiagnosisCodeImages.plist"];
    NSDictionary *items = [[NSDictionary alloc] initWithContentsOfFile:stringsPlistPath];
    return items ? items : @{};
}

- (void)setFavouriteDiagnosisCodeImages:(NSDictionary *)favouriteDiagnosisCodes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavouriteDiagnosisCodeImages.plist"];
    [favouriteDiagnosisCodes writeToFile:stringsPlistPath atomically:YES];
}

- (NSArray *)favouriteDiagnosisCodes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavouriteDiagnosisCodes.plist"];
    NSArray *items = [[NSArray alloc] initWithContentsOfFile:stringsPlistPath];
    return items ? items : @[];
}

- (void)setFavouriteDiagnosisCodes:(NSArray *)favouriteDiagnosisCodes {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FavouriteDiagnosisCodes.plist"];
    [favouriteDiagnosisCodes writeToFile:stringsPlistPath atomically:YES];
}

//- (UIColor *)colorForAppoinmentAction:(AppoinmentActionMenuType)actionMenuType {
//    return [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%i_color", actionMenuType]];
//}

- (UIColor *)colorForAppoinmentTypeID:(NSString *)appoinmentTypeID {
    NSNumber *colorHexCode = [NSUserDefaults objectForKey:[NSString stringWithFormat:@"TYPE_COLOR___%@", appoinmentTypeID]];
    if (![colorHexCode integerValue]) {
        return UIColorFromRGB(0x0099FF);
    }
    return UIColorFromRGB([colorHexCode intValue]);
}

- (void)setColorForAppoinmentTypeID:(NSString *)appoinmentTypeID with:(UIColor *)color {
    [NSUserDefaults setObject:@([color getHexCode]) ForKey:[NSString stringWithFormat:@"TYPE_COLOR___%@", appoinmentTypeID]];
}

- (UIColor *)colorForAppoinmentStatus:(NSString *)appoinmentStatusCode {
    NSNumber *colorHexCode = [NSUserDefaults objectForKey:[NSString stringWithFormat:@"COLOR___%@", appoinmentStatusCode]];
    return UIColorFromRGB([colorHexCode intValue]);
}

- (void)setColorForAppoinmentStatus:(NSString *)appoinmentStatusCode with:(UIColor *)color {
    [NSUserDefaults setObject:@([color getHexCode]) ForKey:[NSString stringWithFormat:@"COLOR___%@", appoinmentStatusCode]];
}

- (void)setToothPerioMovementType:(NSInteger)toothPerioMovementType {
    [[NSUserDefaults standardUserDefaults] setInteger:toothPerioMovementType forKey:TOOTH_PERIO_MOVEMENT_TYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)toothPerioMovementType {
    return [[NSUserDefaults standardUserDefaults] integerForKey:TOOTH_PERIO_MOVEMENT_TYPE];
}

- (NSMutableDictionary *)toothTypesDicWithPatientKey:(NSString *)patientKey {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:[patientKey stringByAppendingString:@"_toothTypes"]];
    return [[NSMutableDictionary alloc] initWithDictionary:dic ? dic : @{}];
}

- (void)saveToothTypesDic:(NSDictionary *)dic withPatientKey:(NSString *)patientKey {
    if (patientKey.length > 0 && dic) {
        [NSUserDefaults setObject:dic ForKey:[patientKey stringByAppendingString:@"_toothTypes"]];
    }
}

- (NSMutableDictionary *)toothSuperNumericsDicWithPatientKey:(NSString *)patientKey {
    return [NSUserDefaults mutableDictionaryForKey:[patientKey stringByAppendingString:@"_toothSuperNumerics"]];
}

- (void)saveToothSuperNumericsDic:(NSDictionary *)dic withPatientKey:(NSString *)patientKey {
    if (patientKey.length > 0 && dic) {
        [NSUserDefaults setObject:dic ForKey:[patientKey stringByAppendingString:@"_toothSuperNumerics"]];
    }
}

- (UIImage *)favouriteTreatmentImage:(NSString *)treatmentCode {
    
    return [UIImage imageNamed:@"fav-icon1.png"];
    return treatmentCode.length > 0 ? [UIImage imageNamed:[NSUserDefaults objectForKey:[@"FAV_TREATMENT_IMAGE_" stringByAppendingString:treatmentCode]]] : nil;
}

- (void)setFavouriteImageName:(NSString *)imageName forTreatement:(NSString *)treatmentCode {
    if (treatmentCode.length > 0 && imageName.length > 0) {
        [NSUserDefaults setObject:imageName ForKey:[@"FAV_TREATMENT_IMAGE_" stringByAppendingString:treatmentCode]];
    }
}


@end
