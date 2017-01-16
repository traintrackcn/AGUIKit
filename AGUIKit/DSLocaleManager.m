//
//  DSLocalizationManager.m
//  og
//
//  Created by traintrackcn on 13-5-15.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "DSLocaleManager.h"
#import "GlobalDefine.h"
#import "AGUIDefine.h"
//#import "NSObject+Singleton.h"

#define kLocaleIdentifier @"kLocaleIdentifier"
#define kLocaleIdentifierBundle @"kLocaleIdentifierBundle"


//static NSBundle *_instanceDSLocaleManagerBundle;

@implementation DSLocaleManager


- (instancetype)init{
    self = [super init];
    if (self){
        NSString *languageID = [self deviceLanguageID];
        if (![self bAvailableLanguageID:languageID]) languageID = @"en";
        [self setLanguageID:languageID];
    }
    return self;
}


//    TLOG(@"languageID after -> %@", languageID);
//}


- (void)setLanguageID:(NSString *)localeID{
   NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:localeID forKey:kLocaleIdentifier];
}

- (NSString *)languageID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud stringForKey:kLocaleIdentifier];
}

- (NSString *)localeIDBundle{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:kLocaleIdentifierBundle];
}

- (void)setLocaleIDBundle:(NSString *)localeIDBundle{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:localeIDBundle forKey:kLocaleIdentifierBundle];
}


#pragma mark -

- (NSString *)deviceLanguageID{
//    TLOG(@"[NSLocale preferredLanguages] -> %@", );
    return [[NSLocale preferredLanguages] objectAtIndex:0];
//    return [[NSLocale currentLocale]  displayNameForKey:NSLocaleLanguageCode value:[[NSLocale preferredLanguages] objectAtIndex:0]];
}

- (BOOL)bAvailableLanguageID:(NSString *)languageID{
    NSArray *arr =  [AGUIDefine singleton].availableLanguages;
    for (int i=0; i<[arr count]; i++) {
        NSString *tmpLanguageID = [[arr objectAtIndex:i] identifier];
        //        LOG_DEBUG(@"targetLocaleID -> %@ localeID -> %@", localeIdentifier, tmpLocaleID);
        if ([languageID isEqualToString:tmpLanguageID]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)bLanguageChanged{
    return ![[self localeIDBundle] isEqualToString:[self languageID]];
}

#pragma mark - 

//+ (NSString *)localizedStringForKey:(NSString *)key{
//    return [self localizedStringForKey:key comment:nil];
//}
//
//+ (NSString *)localizedStringForKey:(NSString *)key comment:(NSString *)comment{
//    BOOL bLocaleChanged = [self bLanguageChanged];
//    if (bLocaleChanged) _instanceDSLocaleManagerBundle = nil;
//    
//    if (_instanceDSLocaleManagerBundle == nil) {
//        NSString *languageID = [self languageID];
//        NSString *path = [[ NSBundle mainBundle ] pathForResource:languageID ofType:@"lproj" ];
//        _instanceDSLocaleManagerBundle =  [NSBundle bundleWithPath:path];
//        
//        TLOG(@"switch to bundle -> %@", path);
//        
//        if (_instanceDSLocaleManagerBundle==nil){
//            TLOG(@"can't find bundle from path -> %@",path);
//            return @"";
//        }
//        [self setLocaleIDBundle:languageID];
//    }
//	return [_instanceDSLocaleManagerBundle localizedStringForKey:key value:comment table:nil];
//}



@end



//+ (BOOL)bAvailableLocaleIdentifier:(NSString *)localeIdentifier{
//    NSArray *localeIDs = [NSLocale availableLocaleIdentifiers];
//    for (int i=0; i<[localeIDs count]; i++) {
//        NSString *tmpLocaleID = [localeIDs objectAtIndex:i];
////        LOG_DEBUG(@"targetLocaleID -> %@ localeID -> %@", localeIdentifier, tmpLocaleID);
//        if ([localeIdentifier isEqualToString:tmpLocaleID]) {
//            return YES;
//        }
//    }
//    return NO;
//}
