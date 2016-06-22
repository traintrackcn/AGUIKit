//
//  DSText.m
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "AGTextCoordinator.h"
#import <Foundation/Foundation.h>
#import "NSObject+Singleton.h"
#import "GlobalDefine.h"
#import "DSLocaleManager.h"
#import "CHCSVParser.h"
#import "DACSVUtil.h"

typedef NS_ENUM(NSInteger, CSVFieldIndex) {
    CSVFieldIndexKey = 0,
    CSVFieldIndexComment
};


@interface AGTextCoordinator()<CHCSVParserDelegate>{
}

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, strong) NSArray *availableLanguages;
@property (nonatomic, strong) id currentLangKey;
@property (nonatomic, strong) id currentLangValue;

@property (nonatomic, assign) NSUInteger currentLineIdx;
@property (nonatomic, assign) NSInteger selectedLangFieldIdx;

@end

@implementation AGTextCoordinator



- (id)init{
    self = [super init];
    if (self) {
        [self load];
    }
    return self;
}


#pragma mark - main ops

+ (NSString *)textForKey:(NSString *)key roleCode:(NSString *)roleCode{
    return [[self singleton] textForKey:key roleCode:roleCode];
}

+ (BOOL)isAvailableTextKey:(NSString *)key roleCode:(NSString *)roleCode{
    return [[self singleton] isAvailableTextKey:key roleCode:roleCode];
}

- (NSString *)textForKey:(NSString *)key roleCode:(NSString *)roleCode{
//    NSString *originalKey = [key copy];
    NSArray *keys = [key componentsSeparatedByString:@"|"];
    id value;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        key = [keys objectAtIndex:i];
        
        if (roleCode) {
            key = [NSString stringWithFormat:@"%@-%@", key, roleCode.lowercaseString];
        }
        
//        TLOG(@"key -> %@", key);
        
        value = [self.dic objectForKey:key];
        if (value) return value;
    }
    
    if ([[[self class] singleton] returnFirstKeyIfNoValue]) {
        return keys.firstObject;
    }
    
    return keys.lastObject;
}

- (BOOL)isAvailableTextKey:(NSString *)key roleCode:(NSString *)roleCode{
    NSArray *keys = [key componentsSeparatedByString:@","];
    id value;
    
    for (NSInteger i = 0; i < keys.count; i++) {
        key = [keys objectAtIndex:i];
        if (roleCode) {
            key = [NSString stringWithFormat:@"%@-%@", key, roleCode.lowercaseString];
        }
        
        value = [self.dic objectForKey:key];
        if (value) return YES;
    }
    return NO;
}


#pragma mark - load localized texts

- (void)reload{
    [self setDic:nil];
    [self load];
}

- (void)load{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"localization" withExtension:@"csv"];
    TLOG(@"url -> %@", url);
    
    if (url) {
        [self parseCSVWithURL:url];
    }else{
        [self generateCSV];
    }
}

- (void)parseCSVWithURL:(NSURL *)url{
    CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVURL:url];
    [parser setDelegate:self];
    [parser parse];
}

- (id)dicFromPlist{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *fileName = [NSString stringWithFormat:@"Text-%@", self.langID];
    TLOG(@"fileName -> %@", fileName);
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    id tmpDic = [NSPropertyListSerialization
                 propertyListFromData:plistXML
                 mutabilityOption:NSPropertyListMutableContainersAndLeaves
                 format:&format
                 errorDescription:&errorDesc];
    //    if (!data) TLOG(@"Error reading plist: %@, format: %lu", errorDesc, format);
    //    TLOG(@"text-%@ -> %@", languageID, data);
//    [self setDic:tmpDic];
    return tmpDic;
}

- (void)generateCSV{
    NSString *path = [NSString stringWithFormat:@"%@/localization_copy.csv", [[NSBundle mainBundle] bundlePath]];
    [[NSFileManager defaultManager] createFileAtPath:path contents:[@"" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"localization_copy" ofType:@"csv"];
    TLOG(@"path -> %@", path);
    if (!path) return;
    CHCSVWriter *writer = [[CHCSVWriter alloc] initForWritingToCSVFile:path];
//    TLOG(@"writer -> %@", writer);
    id dic = [self dicFromPlist];
    
    if (dic && writer) {
        NSInteger lineIdx = 0;
        for (NSString *key in dic) {
            id value = [dic objectForKey:key];
            //                TLOG(@"key -> %@ value -> %@", key, value);
            if (lineIdx != 0) {
                [writer writeField:key];
                [writer writeField:value];
                [writer writeField:@""];
            }else{
                [writer writeField:@"key"];
                [writer writeField:@"en"];
                [writer writeField:@"comment"];
                
            }
            
            [writer finishLine];
            lineIdx ++;
        }
        
        TLOG(@"%@ generated", path);
    }
}


#pragma mark -

- (BOOL)isParsingFirstLine{
    if (self.currentLineIdx == 0) return YES;
    return NO;
}

- (void)parserDidBeginDocument:(CHCSVParser *)parser{
    [self setCurrentLineIdx:0];
}

- (void)parserDidEndDocument:(CHCSVParser *)parser{
    
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber{
//    TLOG(@"lineIdx -> %luld", (unsigned long)recordNumber);
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber{
    self.currentLineIdx ++;
}
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex{
//    TLOG(@"field -> %@ %ld", field, (long)fieldIndex);
    if ([self isParsingFirstLine]) {
        if ([field isEqualToString:self.langID]) {
            [self setSelectedLangFieldIdx:fieldIndex];
        }
    }else{
        if (fieldIndex == CSVFieldIndexKey) {
            [self setCurrentLangKey:field];
        }
        
        if (fieldIndex == self.selectedLangFieldIdx) {
            
            field = [DACSVUtil removeQuoteForField:field];
            
            [self.dic setObject:field forKey:self.currentLangKey];
        }
    }
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error{
    TLOG(@"error -> %@", error);
}


#pragma mark - properties

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSString *)langID{
    return [DSLocaleManager languageID];
}

@end
