//
//  DSStyle.m
//  og
//
//  Created by traintrackcn on 13-8-6.
//  Copyright (c) 2013 2ViVe. All rights reserved.
//

#import "AGStyleCoordinator.h"
#import "NSObject+Singleton.h"
#import "GlobalDefine.h"
#import "DSImage.h"
#import "DSDeviceUtil.h"
#import "DSValueUtil.h"
#import "NSObject+Singleton.h"
#import "AGUIDefine.h"
#import "CHCSVParser.h"
#import "DACSVUtil.h"

typedef NS_ENUM(NSInteger, CSVFieldIndex) {
    CSVFieldIndexKey = 0,
    CSVFieldIndexValue
};

@interface AGStyleCoordinator()<CHCSVParserDelegate>{
}

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, assign) NSUInteger currentLineIdx;
@property (nonatomic, strong) NSString *currentKey;

@end

@implementation AGStyleCoordinator


- (id)init{
    self = [super init];
    if (self) {
        [self load];
    }
    return self;
}


- (void)load{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"color" withExtension:@"csv"];
    TLOG(@"url -> %@", url);
    
    if (url) {
        [self parseCSVWithURL:url];
    }
}

- (void)parseCSVWithURL:(NSURL *)url{
    CHCSVParser *parser = [[CHCSVParser alloc] initWithContentsOfCSVURL:url];
    [parser setDelegate:self];
    [parser parse];
}


#pragma mark -

- (BOOL)isRGBString:(NSString *)str{
    if ([str rangeOfString:@","].location != NSNotFound) return YES;
    return NO;
}

- (UIColor *)colorForKey:(NSString *)key{
    NSString *rgbValue = [self rgbForKey:key];
    if (rgbValue) return COLOR(rgbValue);
    return [UIColor clearColor];
}

- (NSString *)rgbForKey:(NSString *)key{
    NSString *value = [self.dic objectForKey:key];
    NSArray *arr = [value componentsSeparatedByString:@"|"];
    NSString *rgbKey = arr.firstObject;
    NSString *rgbValue = [self.dic valueForKey:rgbKey];
    
    if (rgbValue) {
        return rgbValue;
    }else if(arr.count == 2){
        rgbValue = arr.lastObject;
        return rgbValue;
    }
    
    return nil;
}

- (UIColor *)colorFromRGBValue:(NSString *)value{
    NSArray *arr = [value componentsSeparatedByString:@","];
    float r = [[arr objectAtIndex:0] doubleValue];
    float g = [[arr objectAtIndex:1] doubleValue];
    float b = [[arr objectAtIndex:2] doubleValue];
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}


#pragma mark - CHCSVParserDelegate

- (void)parserDidBeginDocument:(CHCSVParser *)parser{
    [self setCurrentLineIdx:0];
}

- (void)parserDidEndDocument:(CHCSVParser *)parser{
    TLOG(@"self.dic -> %@", self.dic);
}

- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber{
    //    TLOG(@"lineIdx -> %luld", (unsigned long)recordNumber);
}

- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber{
    self.currentLineIdx ++;
}
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex{
    //    TLOG(@"field -> %@ %ld", field, (long)fieldIndex);
    
    if (fieldIndex == CSVFieldIndexKey) {
        [self setCurrentKey:field];
    }if (fieldIndex == CSVFieldIndexValue) {
        NSString *value = [DACSVUtil removeQuoteForField:field];
        [self.dic setValue:value forKey:self.currentKey];
    }
    
}

- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error{
    TLOG(@"error -> %@", error);
}


#pragma mark - 

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

@end



