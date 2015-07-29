//
//  DSLocalizationManager.h
//  og
//
//  Created by traintrackcn on 13-5-15.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DSLocalizedString(key, value)  key

@interface DSLocaleManager : NSObject

+ (void)setLanguageID:(NSString *)languageID;
+ (NSString *)languageID;

//+ (NSString *)localizedStringForKey:(NSString *)key;
//+ (NSString *)localizedStringForKey:(NSString *)key comment:(NSString *)comment;

@end
